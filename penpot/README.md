# Penpot

[Penpot](https://penpot.app/) is a free, open-source design and prototyping platform. It runs entirely in your own infrastructure.

## Services

| Service            | Image                    | Port  |
|--------------------|--------------------------|-------|
| penpot-frontend    | penpotapp/frontend:latest | 9001  |
| penpot-backend     | penpotapp/backend:latest  | —     |
| penpot-exporter    | penpotapp/exporter:latest | —     |
| penpot-postgres    | postgres:15-alpine        | —     |
| penpot-redis       | redis:7-alpine            | —     |

## Environment Variables

Create a `.env` file in this directory with the following values (never commit it to git):

```env
# Mandatory
POSTGRES_PASSWORD=changeme
PENPOT_SECRET_KEY=your-random-secret-key

# Optional overrides
POSTGRES_DB=penpot
POSTGRES_USER=penpot
PENPOT_PUBLIC_URI=http://localhost:9001
PENPOT_FLAGS=enable-registration enable-login
PENPOT_TELEMETRY_ENABLED=false
```

## Getting Started

1. Copy the example variables above into a `.env` file and fill in the required values.
2. Make sure the external `shared` network exists:
   ```bash
   docker network create shared
   ```
3. Start the stack:
   ```bash
   docker compose up -d
   ```
4. Open your browser at `http://<host>:9001` and register your first user.

## Notes

- Assets are persisted in the `penpot-assets` Docker volume, shared between the frontend and backend containers.
- If you use a reverse proxy (e.g. Nginx Proxy Manager), remove the `ports` mapping from `penpot-frontend` and set `PENPOT_PUBLIC_URI` to your external URL.
- To disable public registration after the first user is created, remove `enable-registration` from `PENPOT_FLAGS`.
