BINARY_NAME=moonchain-publisher
LDFLAGS="-w -s"

.PHONY: build build-static clean test test_coverage dep vet lint

build:
	go build -o $(BINARY_NAME) ./cmd/...

build-static:
	CGO_ENABLED=1 go build -race -v -o $(BINARY_NAME) -a -installsuffix cgo -ldflags $(LDFLAGS) ./cmd/...

clean:
	go clean
	rm ${BINARY_NAME}

test:
	go test ./...

test_coverage:
	go test ./... -coverprofile=coverage.out

dep:
	go mod tidy
	go mod download

vet:
	go vet ./...

lint:
	golangci-lint run --enable-all
