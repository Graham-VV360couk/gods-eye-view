# God's Eye View — Coolify / Docker fun deploy
# Runs the Vite app server (needed for API provider middleware).
FROM node:24.14.0-bookworm-slim

WORKDIR /app

# Chromium deps unused in this fun deploy; keep image lean.
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci --omit=optional

COPY . .

ENV NODE_ENV=development \
    HOST=0.0.0.0 \
    PORT=4173

EXPOSE 4173

# Vite + provider plugins (not static preview) so live layers keep working.
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "4173"]
