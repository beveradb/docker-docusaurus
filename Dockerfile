# Use a Node.js base image to build the Docusaurus site
FROM node:current-alpine as builder
LABEL maintainer="Andrew Beveridge <andrew@beveridge.uk>"

# Copy your Docusaurus project into the image - assumes you have this in a `docs` directory
COPY docs /docs
WORKDIR /docs

# Install dependencies and build the static site
RUN npm install && npm run build

# Use nginx to serve the static site
FROM nginx:alpine
LABEL description="Lightweight Docusaurus container based on Alpine Linux"

# Create directories and set permissions
# This is necessary to run nginx as a non-root user with a read-only filesystem
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp \
    && chmod -R 777 /var/cache/nginx /var/run /var/log/nginx

# Copy the built static site from the builder stage
COPY --from=builder /docs/build /usr/share/nginx/html

# Redirect logs to stdout and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Edit nginx config to listen on port 3000 (required for non-root user)
RUN sed -i 's/listen       80;/listen       3000;/' /etc/nginx/conf.d/default.conf

# Expose port 3000 for the web server
EXPOSE 3000

# Start nginx in the foreground to keep the container running
CMD ["nginx", "-g", "daemon off;"]
