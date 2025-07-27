# Contributing to WebShot

Thank you for your interest in contributing to WebShot! This document provides guidelines and information for contributors.

## Getting Started

### Prerequisites

- Go 1.21 or later
- Chrome or Chromium browser
- Git

### Setting up the development environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/webshot.git
   cd webshot
   ```

3. Install dependencies:
   ```bash
   go mod download
   ```

4. Build the project:
   ```bash
   make build
   ```

## Development Workflow

### Making Changes

1. Create a new branch for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes

3. Run tests:
   ```bash
   make test
   ```

4. Run linter:
   ```bash
   make lint
   ```

5. Format code:
   ```bash
   make fmt
   ```

6. Commit your changes:
   ```bash
   git commit -m "feat: add your feature description"
   ```

7. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

8. Create a Pull Request

### Code Style

- Follow Go conventions and best practices
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write tests for new functionality

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

Example:
```
feat: add support for custom viewport sizes

- Add --viewport flag to specify custom dimensions
- Support format WxH (e.g., 1280x720)
- Add validation for viewport parameters
```

## Testing

### Running Tests

```bash
# Run all tests
make test

# Run tests with coverage
make test-coverage

# Run specific test
go test ./internal/webshot -v -run TestValidateURL
```

### Writing Tests

- Write tests for all new functionality
- Use descriptive test names
- Test both success and failure cases
- Mock external dependencies when appropriate

## Documentation

### Updating Documentation

- Update README.md for user-facing changes
- Update docs/usage.md for new features
- Add inline comments for complex code
- Update examples if needed

## Pull Request Process

1. Ensure your code follows the project's style guidelines
2. All tests must pass
3. Code must be linted and formatted
4. Update documentation as needed
5. Provide a clear description of your changes
6. Reference any related issues

## Issue Reporting

When reporting issues, please include:

- Operating system and version
- Go version
- Chrome/Chromium version
- Steps to reproduce
- Expected vs actual behavior
- Error messages (if any)

## Feature Requests

For feature requests:

- Describe the feature clearly
- Explain the use case
- Consider implementation complexity
- Check if it aligns with project goals

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Follow the project's coding standards

## Getting Help

- Check existing issues and PRs
- Read the documentation
- Ask questions in issues
- Join discussions in PRs

Thank you for contributing to WebShot! 🚀 