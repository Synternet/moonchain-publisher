# Build container
FROM golang:1.21 AS build

ARG VERSION

COPY . /home/src
WORKDIR /home/src

RUN CGO_ENABLED=0 go build -v -o moonchain-publisher -ldflags="-w -s" ./cmd/...

# Runtime container
FROM alpine as moonchain-publisher

RUN apk add --update --no-cache \
    ca-certificates \
    bash

WORKDIR /home/app
COPY --from=build /home/src/moonchain-publisher .
RUN chmod +x /home/app/moonchain-publisher

CMD ["./moonchain-publisher", "start"]
