.PHONY: flutter-run-web flutter-run flutter-analyze format help

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make flutter-run-web   - Run Flutter in web mode on port 8080"
	@echo "  make flutter-run       - Run Flutter"
	@echo "  make flutter-analyze   - Run Flutter analyzer"
	@echo "  make format            - Format Dart code"

flutter-run-web:
	flutter run -d web-server --web-port=8080

flutter-run:
	flutter run

flutter-analyze:
	flutter analyze

format:
	dart format .

adb-wsl:
	@echo 'in windows, run `adb shell ip route` to get your IP address and edit ANDROID_IP_ADDRESS_FOR_WSL_ADB in .envrc in this repo. Then run `adb tcpip 5555` to allow connections from WSL'
	adb connect $$ANDROID_IP_ADDRESS_FOR_WSL_ADB:5555