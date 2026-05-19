# Etapa 1: Construcción
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Etapa 2: Ejecución (Mínimo Privilegio)
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app ./
# Crear usuario sin privilegios por seguridad (Hardening)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
EXPOSE 3001
CMD ["npm", "start"]