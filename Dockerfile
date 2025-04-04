FROM node:18.17

WORKDIR /app

# Install n8n globally
RUN npm install -g n8n

# Set environment variables
ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=UTC
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV N8N_PATH=/

# Expose the port n8n runs on
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"] 