FROM golang:1.25-alpine AS builder

WORKDIR /app

# COPY go.mod go.sum ./ # keeping this around in case a go.sum appears in the future
COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -o /mapalavra .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /mapalavra /app/mapalavra


EXPOSE 8080

CMD ["/app/mapalavra"]

