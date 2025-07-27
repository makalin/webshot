.PHONY: build install clean test lint help

# Binary name
BINARY_NAME=webshot

# Build flags
LDFLAGS=-ldflags "-X main.Version=$(shell git describe --tags --always --dirty)"

# Default target
all: build

# Build the application
build:
	@echo "Building $(BINARY_NAME)..."
	go build $(LDFLAGS) -o $(BINARY_NAME) ./cmd/webshot

# Install to system
install: build
	@echo "Installing $(BINARY_NAME)..."
	cp $(BINARY_NAME) /usr/local/bin/
	@echo "Installation complete!"

# Clean build artifacts
clean:
	@echo "Cleaning..."
	rm -f $(BINARY_NAME)
	rm -rf dist/
	rm -rf build/

# Run tests
test:
	@echo "Running tests..."
	go test -v ./...

# Run tests with coverage
test-coverage:
	@echo "Running tests with coverage..."
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

# Lint code
lint:
	@echo "Linting code..."
	golangci-lint run

# Format code
fmt:
	@echo "Formatting code..."
	go fmt ./...

# Generate documentation
docs:
	@echo "Generating documentation..."
	godoc -http=:6060

# Create release build
release: clean
	@echo "Creating release builds..."
	mkdir -p dist
	
	# Build for different platforms
	GOOS=darwin GOARCH=amd64 go build $(LDFLAGS) -o dist/$(BINARY_NAME)-darwin-amd64 ./cmd/webshot
	GOOS=darwin GOARCH=arm64 go build $(LDFLAGS) -o dist/$(BINARY_NAME)-darwin-arm64 ./cmd/webshot
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o dist/$(BINARY_NAME)-linux-amd64 ./cmd/webshot
	GOOS=linux GOARCH=arm64 go build $(LDFLAGS) -o dist/$(BINARY_NAME)-linux-arm64 ./cmd/webshot
	GOOS=windows GOARCH=amd64 go build $(LDFLAGS) -o dist/$(BINARY_NAME)-windows-amd64.exe ./cmd/webshot

# Install dependencies
deps:
	@echo "Installing dependencies..."
	go mod download
	go mod tidy

# Development mode (build and run)
dev: build
	@echo "Running in development mode..."
	./$(BINARY_NAME) --help

# Show help
help:
	@echo "Available targets:"
	@echo "  build        - Build the application"
	@echo "  install      - Install to system"
	@echo "  clean        - Clean build artifacts"
	@echo "  test         - Run tests"
	@echo "  test-coverage- Run tests with coverage"
	@echo "  lint         - Lint code"
	@echo "  fmt          - Format code"
	@echo "  docs         - Generate documentation"
	@echo "  release      - Create release builds"
	@echo "  deps         - Install dependencies"
	@echo "  dev          - Build and run in development mode"
	@echo "  help         - Show this help" 