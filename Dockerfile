# Multi-stage build to optimize image size
FROM nginx:alpine

# Metadata
LABEL maintainer="GymPal Team FIB-UPC"
LABEL description="GymPal Technical Documentation - Web Server"
LABEL version="1.0.0"

# Copy documentation files
COPY index.html /usr/share/nginx/html/
COPY _sidebar.md /usr/share/nginx/html/
COPY docs/ /usr/share/nginx/html/docs/
# Copy GYMPAL.md if it exists (will fail gracefully if not present in newer Docker versions)
COPY GYMPAL.md /usr/share/nginx/html/GYMPAL.md

# Install wget for health check and create Nginx configuration
RUN apk add --no-cache wget && \
    echo 'server { \
    listen 3000; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    \
    # Configuration for Docsify (SPA) \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    \
    # Configuration for static files \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
    \
    # Configuration for Markdown files \
    location ~* \.md$ { \
        add_header Content-Type text/markdown; \
        add_header Access-Control-Allow-Origin *; \
    } \
    \
    # Configuration for YAML files (OpenAPI) \
    location ~* \.yaml$ { \
        add_header Content-Type text/yaml; \
        add_header Access-Control-Allow-Origin *; \
    } \
    \
    # Security headers \
    add_header X-Frame-Options "SAMEORIGIN" always; \
    add_header X-Content-Type-Options "nosniff" always; \
    add_header X-XSS-Protection "1; mode=block" always; \
    \
    # Gzip compression \
    gzip on; \
    gzip_vary on; \
    gzip_min_length 1024; \
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json application/xml; \
}' > /etc/nginx/conf.d/default.conf

# Expose port 3000
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
