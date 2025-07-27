package utils

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
)

// EnsureDirectory creates a directory if it doesn't exist
func EnsureDirectory(path string) error {
	return os.MkdirAll(path, 0755)
}

// IsValidURL checks if a string is a valid URL
func IsValidURL(urlStr string) bool {
	return strings.HasPrefix(urlStr, "http://") || strings.HasPrefix(urlStr, "https://")
}

// GetHomeDir returns the user's home directory
func GetHomeDir() string {
	if runtime.GOOS == "windows" {
		home := os.Getenv("HOMEDRIVE") + os.Getenv("HOMEPATH")
		if home == "" {
			home = os.Getenv("USERPROFILE")
		}
		return home
	}
	return os.Getenv("HOME")
}

// ExpandPath expands a path that may contain ~ for home directory
func ExpandPath(path string) string {
	if strings.HasPrefix(path, "~") {
		return filepath.Join(GetHomeDir(), path[1:])
	}
	return path
}

// FormatFileSize formats bytes into human readable format
func FormatFileSize(bytes int64) string {
	const unit = 1024
	if bytes < unit {
		return fmt.Sprintf("%d B", bytes)
	}
	div, exp := int64(unit), 0
	for n := bytes / unit; n >= unit; n /= unit {
		div *= unit
		exp++
	}
	return fmt.Sprintf("%.1f %cB", float64(bytes)/float64(div), "KMGTPE"[exp])
}

// SanitizeFilename removes invalid characters from filename
func SanitizeFilename(filename string) string {
	// Replace invalid characters with underscore
	invalid := []string{"/", "\\", ":", "*", "?", "\"", "<", ">", "|"}
	result := filename
	for _, char := range invalid {
		result = strings.ReplaceAll(result, char, "_")
	}
	return result
}
