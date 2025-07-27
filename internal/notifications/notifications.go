package notifications

import (
	"fmt"
	"os/exec"
	"runtime"
)

// Notification represents a system notification
type Notification struct {
	Title   string
	Message string
	Sound   bool
}

// Send sends a system notification
func Send(n *Notification) error {
	switch runtime.GOOS {
	case "darwin":
		return sendMacOSNotification(n)
	case "linux":
		return sendLinuxNotification(n)
	case "windows":
		return sendWindowsNotification(n)
	default:
		return fmt.Errorf("unsupported operating system: %s", runtime.GOOS)
	}
}

// sendMacOSNotification sends a notification on macOS using osascript
func sendMacOSNotification(n *Notification) error {
	script := fmt.Sprintf(`
		display notification "%s" with title "%s"
	`, n.Message, n.Title)

	if n.Sound {
		script = fmt.Sprintf(`
			display notification "%s" with title "%s" sound name "default"
		`, n.Message, n.Title)
	}

	cmd := exec.Command("osascript", "-e", script)
	return cmd.Run()
}

// sendLinuxNotification sends a notification on Linux using notify-send
func sendLinuxNotification(n *Notification) error {
	args := []string{"-t", "5000", n.Title, n.Message}
	cmd := exec.Command("notify-send", args...)
	return cmd.Run()
}

// sendWindowsNotification sends a notification on Windows using PowerShell
func sendWindowsNotification(n *Notification) error {
	script := fmt.Sprintf(`
		[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
		[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
		[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

		$template = @"
		<toast>
			<visual>
				<binding template="ToastGeneric">
					<text>%s</text>
					<text>%s</text>
				</binding>
			</visual>
		</toast>
"@

		$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
		$xml.LoadXml($template)
		$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
		[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("WebShot").Show($toast)
	`, n.Title, n.Message)

	cmd := exec.Command("powershell", "-Command", script)
	return cmd.Run()
}
