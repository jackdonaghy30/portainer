FROM node:20-alpine AS builder

ARG VITE_VARIANT=full
ARG VITE_MAP_INTERACTION_MODE=3d
ARG VITE_SENTRY_DSN=
ARG VITE_POSTHOG_KEY=
ARG VITE_POSTHOG_HOST=

ENV VITE_VARIANT=$VITE_VARIANT \
    VITE_MAP_INTERACTION_MODE=$VITE_MAP_INTERACTION_MODE \
    VITE_SENTRY_DSN=$VITE_SENTRY_DSN \
    VITE_POSTHOG_KEY=$VITE_POSTHOG_KEY \
    VITE_POSTHOG_HOST=$VITE_POSTHOG_HOST

RUN apk add --no-cache git

# Clona o branch principal (latest). Para build reproduzível, substitua por:
# git clone --depth 1 --branch <tag> https://github.com/koala73/worldmonitor.git /app
RUN git clone --depth 1 https://github.com/koala73/worldmonitor.git /app

WORKDIR /app

RUN npm ci

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
