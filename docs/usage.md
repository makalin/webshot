# WebShot Usage Guide

## Basic Usage

Capture a screenshot of a website:

```bash
webshot https://example.com
```

This will save a screenshot to `shots/example_com_YYYYMMDD_HHMMSS.png` by default.

## Command Line Options

### Output Options

- `--output, -o <path>`: Specify output directory or file path
- `--format, -f <format>`: Output format (png, jpg, pdf) - default: png
- `--name, -n <filename>`: Custom filename for the screenshot

### Capture Options

- `--full, -F`: Capture full-page screenshot instead of viewport-only
- `--viewport, -v <WxH>`: Set custom viewport size (e.g., 1280x720) - default: 1280x720

### Batch Processing

- `--batch, -b <file>`: Process multiple URLs from a text file

### Other Options

- `--silent, -s`: Disable console output
- `--help, -h`: Show help information
- `--version`: Show version information

## Examples

### Basic Screenshots

```bash
# Capture viewport screenshot
webshot https://github.com

# Capture full-page screenshot
webshot https://github.com --full

# Save with custom name
webshot https://github.com --name github_homepage

# Save to specific directory
webshot https://github.com --output ./my_screenshots/
```

### Custom Viewport

```bash
# Mobile viewport
webshot https://example.com --viewport 375x667

# Desktop viewport
webshot https://example.com --viewport 1920x1080
```

### Different Formats

```bash
# PNG format (default)
webshot https://example.com --format png

# JPEG format
webshot https://example.com --format jpg

# PDF format
webshot https://example.com --format pdf
```

### Batch Processing

Create a file `urls.txt` with URLs (one per line):

```
https://github.com
https://stackoverflow.com
https://reddit.com
```

Then run:

```bash
webshot --batch urls.txt --output ./batch_screenshots/
```

### Silent Mode

```bash
# Capture without console output (useful for scripts)
webshot https://example.com --silent
```

## File Naming

By default, screenshots are named using the pattern:
`{domain}_{timestamp}.{format}`

Examples:
- `github_com_20231201_143022.png`
- `stackoverflow_com_20231201_143045.jpg`

## Output Directory Structure

```
shots/
├── github_com_20231201_143022.png
├── stackoverflow_com_20231201_143045.jpg
└── reddit_com_20231201_143052.pdf
```

## Error Handling

The tool handles various error conditions gracefully:

- Invalid URLs are skipped in batch mode
- Network timeouts are handled with retries
- Invalid viewport sizes show helpful error messages
- Permission errors for output directories are reported clearly

## Integration Examples

### Cron Job

```bash
# Add to crontab to capture daily screenshots
0 9 * * * webshot https://example.com --output /var/www/screenshots/ --silent
```

### Shell Script

```bash
#!/bin/bash
# capture_screenshots.sh

webshot https://github.com --output ./daily/ --name github_$(date +%Y%m%d)
webshot https://stackoverflow.com --output ./daily/ --name stackoverflow_$(date +%Y%m%d)
```

### CI/CD Pipeline

```yaml
# .github/workflows/screenshots.yml
name: Capture Screenshots
on: [push]
jobs:
  screenshots:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install WebShot
        run: |
          wget https://github.com/makalin/webshot/releases/latest/download/webshot-linux-amd64
          chmod +x webshot-linux-amd64
          sudo mv webshot-linux-amd64 /usr/local/bin/webshot
      - name: Capture Screenshots
        run: |
          webshot https://example.com --output ./screenshots/ --silent
```

## Troubleshooting

### Common Issues

1. **Chrome/Chromium not found**: Install Chrome or Chromium browser
2. **Permission denied**: Check write permissions for output directory
3. **Network timeout**: Increase timeout or check network connectivity
4. **Invalid viewport**: Use format WxH (e.g., 1280x720)

### Debug Mode

For debugging, you can run with verbose output:

```bash
webshot https://example.com --debug
```

### System Requirements

- Chrome or Chromium browser installed
- Go 1.21+ (for building from source)
- 512MB RAM minimum
- Network connectivity for target URLs 