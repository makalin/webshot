# WebShot Project Structure

This document provides an overview of the WebShot project structure and organization.

## Directory Structure

```
webshot/
├── cmd/                          # Application entry points
│   └── webshot/
│       └── main.go              # Main application entry point
├── internal/                     # Internal packages (not importable)
│   ├── webshot/
│   │   ├── webshot.go           # Core WebShot functionality
│   │   └── webshot_test.go      # Unit tests for WebShot
│   ├── utils/
│   │   └── utils.go             # Utility functions
│   └── notifications/
│       └── notifications.go     # System notification utilities
├── docs/                         # Documentation
│   ├── usage.md                 # Detailed usage guide
│   └── example.png              # Example screenshot (placeholder)
├── examples/                     # Example files
│   └── urls.txt                 # Example batch URL file
├── scripts/                      # Build and utility scripts
│   └── install.sh               # Installation script
├── .github/                      # GitHub-specific files
│   └── workflows/
│       └── ci.yml               # GitHub Actions CI/CD
├── .gitignore                   # Git ignore patterns
├── .golangci.yml                # Go linter configuration
├── CHANGELOG.md                 # Version history and changes
├── CONTRIBUTING.md              # Contribution guidelines
├── LICENSE                      # MIT License
├── Makefile                     # Build and development tasks
├── PROJECT_STRUCTURE.md         # This file
├── README.md                    # Project overview and quick start
├── go.mod                       # Go module definition
├── go.sum                       # Go module checksums
└── webshot                      # Compiled binary (generated)
```

## Package Organization

### `cmd/webshot/`
Contains the main application entry point that sets up the command-line interface using Cobra.

**Files:**
- `main.go`: Main function, CLI setup, flag definitions

### `internal/webshot/`
Core package containing the main WebShot functionality.

**Files:**
- `webshot.go`: Main WebShot struct, configuration, and screenshot capture logic
- `webshot_test.go`: Comprehensive unit tests

**Key Components:**
- `Config`: Configuration struct for WebShot options
- `WebShot`: Main struct with screenshot capture methods
- URL validation and path generation utilities
- Batch processing functionality

### `internal/utils/`
Utility functions used across the application.

**Files:**
- `utils.go`: File system utilities, URL validation, path expansion

**Key Functions:**
- `EnsureDirectory()`: Create directories if they don't exist
- `IsValidURL()`: Basic URL validation
- `GetHomeDir()`: Cross-platform home directory detection
- `ExpandPath()`: Path expansion with home directory support
- `FormatFileSize()`: Human-readable file size formatting
- `SanitizeFilename()`: Remove invalid characters from filenames

### `internal/notifications/`
Cross-platform system notification utilities.

**Files:**
- `notifications.go`: System notification implementation

**Key Features:**
- macOS: Uses `osascript` for native notifications
- Linux: Uses `notify-send` command
- Windows: Uses PowerShell for toast notifications

## Configuration Files

### `.gitignore`
Excludes build artifacts, temporary files, and system-specific files from version control.

### `.golangci.yml`
Configuration for golangci-lint with multiple linters enabled for code quality.

### `Makefile`
Provides convenient commands for building, testing, and development tasks.

**Key Targets:**
- `build`: Compile the application
- `install`: Install to system
- `test`: Run tests
- `lint`: Run linter
- `release`: Build for multiple platforms
- `clean`: Remove build artifacts

### `go.mod` & `go.sum`
Go module definition and dependency management.

**Key Dependencies:**
- `github.com/chromedp/chromedp`: Chrome DevTools Protocol client
- `github.com/spf13/cobra`: Command-line interface framework
- `github.com/spf13/viper`: Configuration management (for future use)

## Documentation

### `README.md`
Project overview, features, installation, and basic usage examples.

### `docs/usage.md`
Comprehensive usage guide with detailed examples and troubleshooting.

### `CHANGELOG.md`
Version history, feature additions, and breaking changes.

### `CONTRIBUTING.md`
Guidelines for contributors, development setup, and code standards.

## Scripts and Automation

### `scripts/install.sh`
Cross-platform installation script that:
- Detects OS and architecture
- Downloads appropriate binary
- Installs to system path
- Checks dependencies
- Provides helpful feedback

### `.github/workflows/ci.yml`
GitHub Actions workflow for:
- Automated testing
- Multi-platform builds
- Code quality checks
- Automated releases

## Examples

### `examples/urls.txt`
Sample batch file demonstrating URL list format for batch processing.

## Build Artifacts

### `webshot` (binary)
Compiled executable generated by `go build`.

## Development Workflow

1. **Setup**: Clone repository, run `go mod download`
2. **Development**: Use `make dev` for development mode
3. **Testing**: Use `make test` for running tests
4. **Linting**: Use `make lint` for code quality checks
5. **Building**: Use `make build` for compilation
6. **Release**: Use `make release` for multi-platform builds

## Key Design Principles

1. **Modularity**: Clear separation of concerns with dedicated packages
2. **Testability**: Comprehensive unit tests for all functionality
3. **Cross-Platform**: Support for Linux, macOS, and Windows
4. **User-Friendly**: Clear error messages and helpful documentation
5. **Automation-Ready**: Silent mode and script-friendly output
6. **Extensible**: Clean architecture for future feature additions

## Future Structure Considerations

As the project grows, consider adding:

- `pkg/`: Public packages that can be imported by other projects
- `api/`: API definitions and interfaces
- `configs/`: Configuration file templates
- `assets/`: Static assets and resources
- `deploy/`: Deployment configurations
- `benchmarks/`: Performance benchmarks 