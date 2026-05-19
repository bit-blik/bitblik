# Docker Runtime Configuration for Group Links

This document explains how to configure group links (Telegram, Element, SimpleX, Signal) shown in the notifications bar at **runtime** when running the Docker container.

## Overview

The group links are configured at runtime (not build time) using either:
1. **Environment variables** - The entrypoint script generates `config.js` from environment variables
2. **Volume mount** - Mount a custom `config.js` file to override the default configuration

## Method 1: Using Environment Variables (Recommended)

### Using Docker Run

```bash
docker run -d \
  -p 80:80 \
  -e TELEGRAM_GROUP_LINK="https://t.me/+xSktv2JukXUxYmEx" \
  -e ELEMENT_GROUP_LINK="https://matrix.to/#/#bitblik-offers:matrix.org" \
  -e SIMPLEX_GROUP_LINK="https://simplex.chat/contact#/?v=2-7&smp=..." \
  -e SIGNAL_GROUP_LINK="https://signal.group/#..." \
  bitblik-client:latest
```

### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  bitblik-client:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "80:80"
    environment:
      - TELEGRAM_GROUP_LINK=${TELEGRAM_GROUP_LINK:-}
      - ELEMENT_GROUP_LINK=${ELEMENT_GROUP_LINK:-}
      - SIMPLEX_GROUP_LINK=${SIMPLEX_GROUP_LINK:-}
      - SIGNAL_GROUP_LINK=${SIGNAL_GROUP_LINK:-}
```

Or use a `.env` file:

```env
TELEGRAM_GROUP_LINK=https://t.me/+xSktv2JukXUxYmEx
ELEMENT_GROUP_LINK=https://matrix.to/#/#bitblik-offers:matrix.org
SIMPLEX_GROUP_LINK=https://simplex.chat/contact#/?v=2-7&smp=...
SIGNAL_GROUP_LINK=https://signal.group/#...
```

Then run:
```bash
docker-compose up -d
```

### Partial Configuration

You can provide only the links you want to show:

```bash
docker run -d \
  -p 80:80 \
  -e TELEGRAM_GROUP_LINK="https://t.me/+xSktv2JukXUxYmEx" \
  -e ELEMENT_GROUP_LINK="https://matrix.to/#/#bitblik-offers:matrix.org" \
  bitblik-client:latest
```

## Method 2: Using Volume Mount

### Step 1: Create config.js

Copy the example file and customize it:

```bash
cp config.example.js config.js
```

Edit `config.js` with your group links:

```javascript
window.appConfig = {
  telegramGroupLink: 'https://t.me/+xSktv2JukXUxYmEx',
  elementGroupLink: 'https://matrix.to/#/#bitblik-offers:matrix.org',
  simplexGroupLink: 'https://simplex.chat/contact#/?v=2-7&smp=...',
  signalGroupLink: 'https://signal.group/#...'
};
```

### Step 2: Mount the config file

```bash
docker run -d \
  -p 80:80 \
  -v $(pwd)/config.js:/usr/share/nginx/html/config.js:ro \
  bitblik-client:latest
```

Or in `docker-compose.yml`:

```yaml
version: '3.8'

services:
  bitblik-client:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "80:80"
    volumes:
      - ./config.js:/usr/share/nginx/html/config.js:ro
```

## Environment Variables

The following environment variables are available (all optional):

- `TELEGRAM_GROUP_LINK` - Telegram group invite link
- `ELEMENT_GROUP_LINK` - Element/Matrix room link
- `SIMPLEX_GROUP_LINK` - SimpleX contact/group link
- `SIGNAL_GROUP_LINK` - Signal group invite link

Only links that are provided (non-empty) will be displayed in the UI.

## How It Works

1. **Build time**: The Docker image is built with a default empty `config.js` file
2. **Runtime**:
    - The entrypoint script (`docker-entrypoint.sh`) runs when the container starts
    - It generates `config.js` from environment variables (if provided)
    - Alternatively, you can mount a custom `config.js` file to override the generated one
3. **Application**: The Flutter web app reads `window.appConfig` from the JavaScript file at runtime
4. **UI**: Only non-empty links are displayed in the notifications bar

## Advantages of Runtime Configuration

- ✅ **No rebuild required**: Change links without rebuilding the Docker image
- ✅ **Flexible deployment**: Same image can be used with different configurations
- ✅ **Easy updates**: Update links by restarting the container with new environment variables
- ✅ **Multiple environments**: Use the same image for dev/staging/production with different links

## Example Files

- `config.example.js` - Example configuration file for volume mounting
- `docker-compose.example.yml` - Example Docker Compose configuration
- `docker-entrypoint.sh` - Entrypoint script that generates config.js from environment variables
