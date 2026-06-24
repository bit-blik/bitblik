# Offers Dashboard

Real-time offers monitoring dashboard with WebSocket support for live updates.

## Features

- **Real-time Updates**: WebSocket-based live offer status updates
- **Audit Logs**: View detailed audit logs for each offer
- **Analytics Dashboard**: Comprehensive charts and statistics
- **Multi-Coordinator Switcher**: Connect one dashboard to multiple coordinator databases and switch between them from the top bar
- **Responsive Design**: Works on desktop and mobile devices

## Architecture

The application consists of:
- **Backend**: Node.js Express server with WebSocket support and PostgreSQL LISTEN/NOTIFY
- **Frontend**: React SPA with real-time WebSocket connections
- **Database**: PostgreSQL with triggers for real-time notifications

The Docker image uses a multi-stage build process:
1. **Frontend Build Stage**: Builds the React application into optimized static files
2. **Production Stage**: Runs the Node.js server which serves both the API endpoints and the static frontend files

## Building the Image

From the `dashboard` directory, run:

```bash
docker build -t offers-dashboard .
```

## Running the Container

## Configuration Modes

### Single Coordinator

Legacy single-database env vars still work:

```env
COORDINATOR_ID=main
COORDINATOR_LABEL=Main Coordinator
DB_HOST=localhost
DB_PORT=5432
DB_NAME=bitblik
DB_USER=postgres
DB_PASSWORD=your_password
```

### Multiple Coordinators

Set `COORDINATORS_JSON` to a JSON array. Each entry becomes one option in the dashboard dropdown:

```env
COORDINATORS_JSON='[{"id":"main","label":"Main Coordinator","host":"postgres-main","port":5432,"database":"bitblik","user":"postgres","password":"your_password"},{"id":"staging","label":"Staging Coordinator","host":"postgres-staging","port":5432,"database":"bitblik_staging","user":"postgres","password":"your_password"}]'
```

When `COORDINATORS_JSON` is present, it overrides the single `DB_*` connection.
In `.env` files loaded by `dotenv`, quote whole value and keep JSON on one line.

### Basic Run

```bash
docker run -p 3001:3001 \
  -e COORDINATOR_ID=main \
  -e COORDINATOR_LABEL="Main Coordinator" \
  -e DB_HOST=your_db_host \
  -e DB_PORT=5432 \
  -e DB_NAME=bitblik \
  -e DB_USER=postgres \
  -e DB_PASSWORD=your_password \
  offers-dashboard
```

### Using Environment File

Create a `.env` file with your database configuration:

```env
COORDINATOR_ID=main
COORDINATOR_LABEL=Main Coordinator
DB_HOST=localhost
DB_PORT=5432
DB_NAME=bitblik
DB_USER=postgres
DB_PASSWORD=your_password
```

Then run:

```bash
docker run -p 3001:3001 --env-file .env offers-dashboard
```

### With Docker Compose

Add this service to your `docker-compose.yml`:

```yaml
services:
  dashboard:
    build: ./dashboard
    ports:
      - "3001:3001"
    environment:
      - COORDINATOR_ID=main
      - COORDINATOR_LABEL=Main Coordinator
      - DB_HOST=postgres
      - DB_PORT=5432
      - DB_NAME=bitblik
      - DB_USER=postgres
      - DB_PASSWORD=${DB_PASSWORD}
    depends_on:
      - postgres
```

Multi-coordinator Compose example:

```yaml
services:
  dashboard:
    build: ./dashboard
    ports:
      - "3001:3001"
    environment:
      COORDINATORS_JSON: >-
        [
          {"id":"main","label":"Main Coordinator","host":"postgres-main","port":5432,"database":"bitblik","user":"postgres","password":"${MAIN_DB_PASSWORD}"},
          {"id":"backup","label":"Backup Coordinator","host":"postgres-backup","port":5432,"database":"bitblik_backup","user":"postgres","password":"${BACKUP_DB_PASSWORD}"}
        ]
```

## Accessing the Application

Once running, access the dashboard at:
- **Frontend**: http://localhost:3001
- **API Endpoints**: http://localhost:3001/api/*

Coordinator-specific API and WebSocket calls use the `coordinator` query parameter internally, for example:

```text
/api/offers/recent?coordinator=main
/ws/offers?coordinator=staging
```

## Port Configuration

The default port is 3001, but you can override it:

```bash
docker run -p 8080:8080 \
  -e PORT=8080 \
  -e DB_HOST=your_db_host \
  # ... other env vars
  offers-dashboard
```

## Development vs Production

This Dockerfile is optimized for production use. For development:
- Run the frontend with `npm start` in the `frontend` directory (hot reload on port 3000)
- Run the backend with `node server.js` in the `dashboard` directory (API on port 3001)

## Deployment Behind Nginx/Reverse Proxy

The frontend automatically detects the protocol and host it was loaded from, so it works seamlessly behind reverse proxies.

### Example Nginx Configuration

See `nginx.example.conf` for a complete configuration. Key points:

```nginx
# API endpoints
location /api/ {
    proxy_pass http://dashboard:3001;
    # ... headers
}

# WebSocket endpoint - IMPORTANT: Upgrade headers required
location /ws/ {
    proxy_pass http://dashboard:3001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    # Long timeouts for WebSocket
    proxy_read_timeout 7d;
}

# Frontend
location / {
    proxy_pass http://dashboard:3001;
}
```

### Docker Compose with Nginx

See `docker-compose.example.yml` for a complete setup including:
- Dashboard service
- Nginx reverse proxy
- PostgreSQL database

**Copy and customize:**
```bash
cp docker-compose.example.yml docker-compose.yml
cp nginx.example.conf nginx.conf
# Edit both files with your domain and settings
docker-compose up -d
```

### Environment Variables for Custom URLs

If you need to override the automatic URL detection:

```bash
# For frontend build-time configuration
REACT_APP_API_BASE=https://api.yourdomain.com
REACT_APP_WS_URL=wss://api.yourdomain.com/ws/offers

# Rebuild frontend
cd frontend && npm run build
```

## Troubleshooting

### Cannot connect to database
- Ensure the `DB_HOST` is accessible from within the container
- If using `localhost`, it refers to the container, not your host machine
- Use `host.docker.internal` (Mac/Windows) or the actual host IP for local development

### Frontend not loading
- Check that the build completed successfully in the Docker logs
- Verify the `frontend/build` directory exists in the container
- Check server logs for any errors serving static files

### WebSocket connection fails behind proxy
- Ensure nginx has `proxy_set_header Upgrade $http_upgrade;` and `Connection "upgrade"`
- Check that the `/ws/` location block has long timeouts (7d recommended)
- Verify nginx is proxying to the correct backend port
- For HTTPS, make sure the frontend uses `wss://` instead of `ws://` (this is automatic)

### "Disconnected" status after navigating between tabs
- This has been fixed in the latest version
- Make sure you have the latest frontend build
- Clear browser cache and reload
