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

# Create directory for SQLite database and remove any existing data.db
RUN mkdir -p .tmp && rm -f .tmp/data.db

# Copy seed database ONLY
COPY .tmp/data.db /app/.tmp/data.db.seed

# Copy and set permissions for entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port
EXPOSE 1337

# Set environment
ENV NODE_ENV=production

# Use custom entrypoint that seeds data on first run
ENTRYPOINT ["docker-entrypoint.sh"]
