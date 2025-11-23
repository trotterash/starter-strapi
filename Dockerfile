# Use Node 22 Alpine (Latest LTS)
FROM node:22-alpine

WORKDIR /app

# Install pnpm and build dependencies for better-sqlite3
RUN apk add --no-cache python3 make g++ && \
    npm install -g pnpm

# Copy package files and scripts
COPY package.json pnpm-lock.yaml .npmrc ./
COPY scripts ./scripts

# Install dependencies and build better-sqlite3
RUN pnpm install --frozen-lockfile && \
    cd node_modules/.pnpm/better-sqlite3@11.7.0/node_modules/better-sqlite3 && \
    npm run build-release && \
    cd /app

# Copy source code
COPY . .

# Build admin panel
RUN pnpm build

# Create directory for SQLite database
RUN mkdir -p .tmp

# Expose port
EXPOSE 1337

# Set environment
ENV NODE_ENV=production

# Start the application
CMD ["pnpm", "start"]
