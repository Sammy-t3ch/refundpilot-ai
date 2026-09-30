FROM node:22-alpine

WORKDIR /app

# Prisma requires OpenSSL in Alpine-based images.
RUN apk add --no-cache openssl

COPY package.json package-lock.json ./

# The backend starts TypeScript with tsx and runs Prisma CLI commands from
# docker-entrypoint.sh, so devDependencies are intentionally included.
RUN npm ci --include=dev

COPY . .

RUN npx prisma generate \
    && chmod +x /app/docker-entrypoint.sh

EXPOSE 4000

ENTRYPOINT ["/app/docker-entrypoint.sh"]
