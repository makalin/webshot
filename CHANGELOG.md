# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of WebShot
- Command-line interface with Cobra
- Screenshot capture using Chrome DevTools Protocol
- Support for PNG, JPEG, and PDF output formats
- Full-page and viewport-only screenshot modes
- Custom viewport size configuration
- Batch processing from URL files
- Custom output directory and filename support
- Silent mode for automation
- Cross-platform support (Linux, macOS, Windows)
- Comprehensive test suite
- GitHub Actions CI/CD pipeline
- Installation script for easy setup
- Detailed documentation and usage examples

### Features
- **Core Functionality**: Capture screenshots of websites using headless Chrome
- **Multiple Formats**: Support for PNG, JPEG, and PDF output
- **Flexible Output**: Custom directories, filenames, and automatic naming
- **Batch Processing**: Process multiple URLs from text files
- **Viewport Control**: Custom viewport sizes and full-page capture
- **Cross-Platform**: Works on Linux, macOS, and Windows
- **Automation Ready**: Silent mode and script-friendly output

### Technical Details
- Built with Go 1.21+
- Uses Chrome DevTools Protocol via chromedp
- Command-line interface with Cobra
- Comprehensive error handling and validation
- Modular architecture with separate packages
- Extensive unit tests with good coverage

## [0.1.0] - 2024-01-01

### Added
- Initial release
- Basic screenshot functionality
- Command-line interface
- Support for common image formats
- Cross-platform compatibility

---

## Version History

### v0.1.0 (Initial Release)
- Core screenshot capture functionality
- Command-line interface with essential flags
- Support for PNG, JPEG, and PDF formats
- Full-page and viewport capture modes
- Batch processing capabilities
- Cross-platform support
- Comprehensive documentation

---

## Planned Features

### v0.2.0
- [ ] Auto-thumbnail generation
- [ ] Screenshot diff for visual regression testing
- [ ] Markdown report mode
- [ ] S3 upload support
- [ ] Custom CSS injection
- [ ] Authentication support
- [ ] Proxy configuration

### v0.3.0
- [ ] Web interface for configuration
- [ ] Scheduled screenshot capture
- [ ] Email notifications
- [ ] Advanced filtering options
- [ ] Plugin system
- [ ] API endpoints

---

## Migration Guide

### From v0.0.x to v0.1.0
- No breaking changes - this is the initial release
- All existing functionality is preserved
- New features are additive only

---

## Deprecation Notices

None at this time.

---

## Breaking Changes

None in v0.1.0 - this is the initial release.

---

## Contributors

- [Mehmet T. AKALIN](https://github.com/makalin) - Initial implementation

---

## Acknowledgments

- [chromedp](https://github.com/chromedp/chromedp) - Chrome DevTools Protocol client
- [Cobra](https://github.com/spf13/cobra) - Command-line interface framework
- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/) - Browser automation protocol 