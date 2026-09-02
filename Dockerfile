FROM node:22.12-alpine AS ui-builder
WORKDIR /app
COPY ui/package*.json ./
RUN npm ci
COPY ui/ ./
RUN npm run build

FROM golang:1.27-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
COPY --from=ui-builder /app/dist ./ui/dist
# The repository root is the PocketBase library. The standalone executable
# is the examples/base command, so build that package explicitly.
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /pocketbase ./examples/base

FROM alpine:3.22
WORKDIR /app
COPY --from=builder /pocketbase ./pocketbase
RUN chmod +x ./pocketbase
EXPOSE 8090
VOLUME ["/app/pb_data"]
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
