.PHONY: flutter-run-web flutter-run help

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make flutter-run-web  - Run Flutter in web mode on port 8080"
	@echo "  make flutter-run      - Run Flutter"

flutter-run-web:
	flutter run -d web-server --web-port=8080

flutter-run:
	flutter run
