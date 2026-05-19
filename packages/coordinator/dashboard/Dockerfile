# Multi-stage build for dashboard app
FROM node:18-alpine AS frontend-build

# Build frontend
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Copy backend files
COPY server.js ./
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy built frontend from build stage
COPY --from=frontend-build /app/frontend/build ./frontend/build

# Expose port for the server
EXPOSE 3001

# Start the server
CMD ["node", "server.js"]
