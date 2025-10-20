# AI Integration (Detailed)

## Dify Client

```typescript
// backend/src/modules/ai/dify.client.ts
export class DifyClient {
  private apiKey: string;
  private baseUrl = 'https://api.dify.ai/v1';
  
  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }
  
  async chat(params: {
    query: string;
    user: string;
    conversationId?: string;
    inputs?: Record<string, any>;
  }) {
    const response = await fetch(`${this.baseUrl}/chat-messages`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query: params.query,
        user: params.user,
        conversation_id: params.conversationId,
        inputs: params.inputs || {},
        response_mode: 'blocking'
      })
    });
    
    if (!response.ok) {
      throw new Error(`Dify API error: ${response.status}`);
    }
    
    return response.json();
  }
  
  async completion(params: {
    prompt: string;
    user: string;
    inputs?: Record<string, any>;
  }) {
    const response = await fetch(`${this.baseUrl}/completion-messages`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        inputs: { prompt: params.prompt, ...params.inputs },
        user: params.user,
        response_mode: 'blocking'
      })
    });
    
    if (!response.ok) {
      throw new Error(`Dify API error: ${response.status}`);
    }
    
    return response.json();
  }
}
```

## Context Builder

```typescript
// backend/src/modules/ai/context.builder.ts
import { createClient } from '@supabase/supabase-js';

export class ContextBuilder {
  private supabase;
  
  constructor() {
    this.supabase = createClient(
      process.env.SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_KEY!
    );
  }
  
  async buildForUser(userId: string) {
    // Get user profile
    const { data: profile } = await this.supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();
    
    // Get recent workouts (last 5)
    const { data: recentWorkouts } = await this.supabase
      .from('workout_logs')
      .select('*')
      .eq('user_id', userId)
      .order('log_date', { ascending: false })
      .limit(5);
    
    // Get active workout plan
    const { data: activeWorkout } = await this.supabase
      .from('workouts')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(1)
      .single();
    
    return {
      profile: profile || {},
      recentWorkouts: recentWorkouts || [],
      activeWorkout: activeWorkout || null,
      goals: profile?.goals || {}
    };
  }
}
```

## Frontend Chat Component

```typescript
// frontend/src/components/ai/chat-interface.tsx
'use client';

import { useState, useRef, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { apiClient } from '@/lib/api/client';

interface Message {
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
}

export function ChatInterface() {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [sessionId, setSessionId] = useState<string>();
  const scrollRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    scrollRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);
  
  const sendMessage = async () => {
    if (!input.trim()) return;
    
    const userMessage: Message = {
      role: 'user',
      content: input,
      timestamp: new Date()
    };
    
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);
    
    try {
      const response = await apiClient.post<{
        message: string;
        sessionId: string;
        suggestions?: string[];
      }>('/ai/chat', {
        message: input,
        sessionId
      });
      
      setSessionId(response.sessionId);
      
      const assistantMessage: Message = {
        role: 'assistant',
        content: response.message,
        timestamp: new Date()
      };
      
      setMessages(prev => [...prev, assistantMessage]);
    } catch (error) {
      console.error('Chat error:', error);
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: 'Sorry, an error occurred. Please try again.',
        timestamp: new Date()
      }]);
    } finally {
      setIsLoading(false);
    }
  };
  
  return (
    <div className="flex flex-col h-[600px] border rounded-lg">
      <div className="p-4 border-b">
        <h2 className="text-xl font-semibold">AI Fitness Assistant</h2>
        <p className="text-sm text-muted-foreground">
          Ask about exercises, nutrition, or your progress
        </p>
      </div>
      
      <ScrollArea className="flex-1 p-4">
        <div className="space-y-4">
          {messages.map((msg, idx) => (
            <div
              key={idx}
              className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}
            >
              <div
                className={`max-w-[80%] rounded-lg p-3 ${
                  msg.role === 'user'
                    ? 'bg-primary text-primary-foreground'
                    : 'bg-muted'
                }`}
              >
                <p className="text-sm">{msg.content}</p>
                <span className="text-xs opacity-70">
                  {msg.timestamp.toLocaleTimeString()}
                </span>
              </div>
            </div>
          ))}
          {isLoading && (
            <div className="flex justify-start">
              <div className="bg-muted rounded-lg p-3">
                <div className="flex space-x-2">
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce" />
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce delay-100" />
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce delay-200" />
                </div>
              </div>
            </div>
          )}
          <div ref={scrollRef} />
        </div>
      </ScrollArea>
      
      <div className="p-4 border-t">
        <form
          onSubmit={(e) => {
            e.preventDefault();
            sendMessage();
          }}
          className="flex gap-2"
        >
          <Input
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type your message..."
            disabled={isLoading}
          />
          <Button type="submit" disabled={isLoading || !input.trim()}>
            Send
          </Button>
        </form>
      </div>
    </div>
  );
}
```

## AI Architecture

```mermaid
graph TB
  subgraph "Frontend"
    CHAT[Chat Interface]
    RECO[Recommendation UI]
    WORKOUT[Workout Generator]
  end
  
  subgraph "Backend AI Module"
    AI_SERVICE[AI Service]
    CONTEXT[Context Builder]
    DIFY_CLIENT[Dify Client]
  end
  
  subgraph "External AI Services"
    DIFY[Dify AI Platform]
    N8N[n8n Workflows]
  end
  
  subgraph "Data Sources"
    USER_PROFILE[User Profile]
    WORKOUT_HISTORY[Workout History]
    SOCIAL_DATA[Social Data]
    NUTRITION_DATA[Nutrition Data]
  end
  
  CHAT --> AI_SERVICE
  RECO --> AI_SERVICE
  WORKOUT --> AI_SERVICE
  
  AI_SERVICE --> CONTEXT
  AI_SERVICE --> DIFY_CLIENT
  
  CONTEXT --> USER_PROFILE
  CONTEXT --> WORKOUT_HISTORY
  CONTEXT --> SOCIAL_DATA
  CONTEXT --> NUTRITION_DATA
  
  DIFY_CLIENT --> DIFY
  AI_SERVICE --> N8N
```

## AI Chat Flow

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant AI as AI Service
  participant C as Context Builder
  participant D as Dify Client
  participant DIFY as Dify AI
  
  U->>FE: Sends message
  FE->>AI: POST /ai/chat
  AI->>C: buildForUser(userId)
  C-->>AI: User context
  AI->>D: chat(query, user, context)
  D->>DIFY: API call
  DIFY-->>D: AI response
  D-->>AI: Processed response
  AI-->>FE: Chat response
  FE-->>U: Shows response
```

## Recommendation System

```mermaid
graph TB
  subgraph "Data Collection"
    USER_BEHAVIOR[User Behavior]
    WORKOUT_PATTERNS[Workout Patterns]
    SOCIAL_INTERACTIONS[Social Interactions]
    NUTRITION_PREFERENCES[Nutrition Preferences]
  end
  
  subgraph "Feature Engineering"
    FEATURE_EXTRACT[Feature Extraction]
    EMBEDDINGS[Embeddings Generation]
    SIMILARITY[Similarity Calculation]
  end
  
  subgraph "Recommendation Engine"
    COLLABORATIVE[Collaborative Filtering]
    CONTENT_BASED[Content-Based Filtering]
    HYBRID[Hybrid Approach]
  end
  
  subgraph "Output"
    WORKOUT_RECO[Workout Recommendations]
    USER_RECO[User Recommendations]
    CONTENT_RECO[Content Recommendations]
  end
  
  USER_BEHAVIOR --> FEATURE_EXTRACT
  WORKOUT_PATTERNS --> FEATURE_EXTRACT
  SOCIAL_INTERACTIONS --> FEATURE_EXTRACT
  NUTRITION_PREFERENCES --> FEATURE_EXTRACT
  
  FEATURE_EXTRACT --> EMBEDDINGS
  EMBEDDINGS --> SIMILARITY
  
  SIMILARITY --> COLLABORATIVE
  SIMILARITY --> CONTENT_BASED
  COLLABORATIVE --> HYBRID
  CONTENT_BASED --> HYBRID
  
  HYBRID --> WORKOUT_RECO
  HYBRID --> USER_RECO
  HYBRID --> CONTENT_RECO
```

## AI-Driven Workout Generation

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant AI as AI Service
  participant D as Dify Client
  participant DIFY as Dify AI
  participant DB as Database
  
  U->>FE: Requests personalized routine
  FE->>AI: POST /ai/generate-workout
  AI->>DB: Get user profile
  DB-->>AI: User profile + goals
  AI->>D: completion(prompt, user, context)
  D->>DIFY: Generate workout
  DIFY-->>D: AI generated workout
  D-->>AI: Structured workout data
  AI->>DB: Save generated routine
  DB-->>AI: Workout saved
  AI-->>FE: Generated workout
  FE-->>U: Show personalized routine
```

## Integration with n8n for Automation

```mermaid
graph TB
  subgraph "Triggers"
    WORKOUT_COMPLETE[Workout Completed]
    GOAL_ACHIEVED[Goal Achieved]
    SOCIAL_INTERACTION[Social Interaction]
    NUTRITION_LOG[Nutrition Logged]
  end
  
  subgraph "n8n Workflows"
    CONGRATULATIONS[Congratulations Workflow]
    MOTIVATION[Motivation Workflow]
    NUTRITION_TIPS[Nutrition Tips Workflow]
    SOCIAL_NOTIFICATIONS[Social Notifications]
  end
  
  subgraph "AI Processing"
    DIFY_ANALYSIS[Dify Analysis]
    PERSONALIZATION[Personalization Engine]
    CONTENT_GENERATION[Content Generation]
  end
  
  subgraph "Output Channels"
    EMAIL[Email Notifications]
    TELEGRAM[Telegram Bot]
    WHATSAPP[WhatsApp Bot]
    IN_APP[In-App Notifications]
  end
  
  WORKOUT_COMPLETE --> CONGRATULATIONS
  GOAL_ACHIEVED --> MOTIVATION
  SOCIAL_INTERACTION --> SOCIAL_NOTIFICATIONS
  NUTRITION_LOG --> NUTRITION_TIPS
  
  CONGRATULATIONS --> DIFY_ANALYSIS
  MOTIVATION --> DIFY_ANALYSIS
  NUTRITION_TIPS --> DIFY_ANALYSIS
  SOCIAL_NOTIFICATIONS --> DIFY_ANALYSIS
  
  DIFY_ANALYSIS --> PERSONALIZATION
  PERSONALIZATION --> CONTENT_GENERATION
  
  CONTENT_GENERATION --> EMAIL
  CONTENT_GENERATION --> TELEGRAM
  CONTENT_GENERATION --> WHATSAPP
  CONTENT_GENERATION --> IN_APP
```

## AI Prompts and Templates

### Workout Generation Prompt

```typescript
const WORKOUT_GENERATION_PROMPT = `
You are an expert personal trainer. Generate a personalized workout routine based on:

User profile:
- Experience level: {experience_level}
- Primary goal: {primary_goal}
- Secondary goals: {secondary_goals}
- Training frequency: {workout_frequency} days/week
- Preferred duration: {preferred_duration} minutes
- Available equipment: {available_equipment}
- Medical restrictions: {medical_restrictions}

Generate a routine that includes:
1. Warm up (5-10 minutes)
2. Main exercises (organized by muscle groups)
3. Cool down (5-10 minutes)
4. Weekly progression
5. Form and safety tips

Response format (JSON):
{
  "name": "Routine name",
  "description": "Detailed description",
  "duration_minutes": 60,
  "exercises": [
    {
      "name": "Exercise name",
      "muscle_group": "Muscle group",
      "sets": 3,
      "reps": "12-15",
      "rest_seconds": 60,
      "notes": "Specific tips"
    }
  ],
  "progression": "Weekly progression plan",
  "tips": ["Tip 1", "Tip 2"]
}
`;
```

### Recommendation Prompt

```typescript
const RECOMMENDATION_PROMPT = `
Analyze the user's profile and history to generate personalized recommendations:

User data:
- Profile: {user_profile}
- Workout history: {workout_history}
- Social interactions: {social_interactions}
- Nutrition preferences: {nutrition_preferences}

Generate recommendations for:
1. Similar workout routines
2. Users with compatible goals
3. Relevant content (posts, tips, etc.)
4. Diet adjustments
5. New exercises to try

Response format (JSON):
{
  "workout_recommendations": [...],
  "user_recommendations": [...],
  "content_recommendations": [...],
  "nutrition_suggestions": [...],
  "new_exercises": [...]
}
`;
```

## AI Monitoring and Metrics

```mermaid
graph TB
  subgraph "AI Metrics"
    CHAT_METRICS[Chat Metrics]
    RECO_METRICS[Recommendation Metrics]
    GENERATION_METRICS[Generation Metrics]
    USER_SATISFACTION[User Satisfaction]
  end
  
  subgraph "Monitoring"
    RESPONSE_TIME[Response Time]
    ACCURACY[Accuracy Rate]
    ENGAGEMENT[Engagement Rate]
    CONVERSION[Conversion Rate]
  end
  
  subgraph "Alerts"
    HIGH_LATENCY[High Latency Alert]
    LOW_ACCURACY[Low Accuracy Alert]
    API_ERRORS[API Error Alert]
    USER_COMPLAINTS[User Complaint Alert]
  end
  
  CHAT_METRICS --> RESPONSE_TIME
  RECO_METRICS --> ACCURACY
  GENERATION_METRICS --> ENGAGEMENT
  USER_SATISFACTION --> CONVERSION
  
  RESPONSE_TIME --> HIGH_LATENCY
  ACCURACY --> LOW_ACCURACY
  ENGAGEMENT --> API_ERRORS
  CONVERSION --> USER_COMPLAINTS
```
