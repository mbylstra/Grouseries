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
