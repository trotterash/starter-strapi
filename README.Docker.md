# Strapi LaunchPad Demo

Official Strapi demo application with pre-configured content types and sample data.

## Quick Start with Docker

### Prerequisites
- Docker
- Docker Compose

### Setup

1. **Clone or copy this project**

2. **Configure environment variables** (optional but recommended for production):
   ```bash
   cp .env.example .env
   # Edit .env and replace the default values with secure secrets
   ```

   To generate secure secrets, you can use:
   ```bash
   # Generate a random string for secrets
   openssl rand -base64 32
   ```

3. **Build and start the container**:
   ```bash
   docker-compose up -d
   ```

4. **Access the admin panel**:
   - Open http://localhost:1337/admin
   - Create your first admin user
   - Explore the pre-configured content types and sample data

### Common Commands

```bash
# View logs
docker-compose logs -f

# Stop the container
docker-compose down

# Rebuild and restart
docker-compose up --build -d

# Stop and remove volumes (will delete all data)
docker-compose down -v
```

## What's Included

- **Strapi 5.31.2** - Latest version
- **SQLite database** - File-based, no external database needed
- **Sample content** including:
  - Articles (blog posts)
  - Pages with dynamic zones
  - Products
  - Testimonials
  - FAQs
  - Media library with sample images
- **Pre-configured components** for page building
- **Docker volumes** for data persistence

## Connecting to Your Frontend

Once running, the REST API is available at:
- `http://localhost:1337/api/*`

Example: `http://localhost:1337/api/articles`

You'll need to create API tokens in Settings > API Tokens for authenticated requests.

## Production Deployment

For production deployment:

1. **Always set custom secrets** in your `.env` file or environment variables
2. **Consider using PostgreSQL or MySQL** instead of SQLite for better performance
3. **Set up proper backups** for the Docker volumes
4. **Use a reverse proxy** (nginx, Caddy) with HTTPS
5. **Review the security settings** in Strapi admin

## Data Persistence

Data is persisted using Docker volumes:
- `strapi-data`: SQLite database
- `strapi-uploads`: Media files

These volumes will persist even if you recreate the container.

## Troubleshooting

**Container won't start:**
- Check logs: `docker-compose logs`
- Ensure port 1337 is not already in use
- Verify Docker has enough resources allocated

**Database errors:**
- Stop container: `docker-compose down`
- Remove volumes: `docker-compose down -v`
- Rebuild: `docker-compose up --build -d`

**Permission errors:**
- Ensure the `.tmp` directory has proper permissions
- Check Docker volume mount permissions

## License

MIT
