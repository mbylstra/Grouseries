# Flutter Project Rules

## Flutter/Dart Development

- Never manually edit pubspec.yaml to add dependencies
- Always use `dart pub add` or `flutter pub add` to install packages

### Code Reuse and DRY Principle

- BEFORE duplicating any code block, ALWAYS ask if we should extract/reuse existing code instead
- When you notice similar code patterns, proactively suggest refactoring
- Search the codebase first before creating new implementations
- Prefer refactoring over copy-paste, even if it takes more steps
- If duplicating code, explicitly state WHY duplication is appropriate in this case

### Import Style

- Prefer `show` for ubiquitous packages where concise usage is desired (e.g., Flutter material widgets)
- Prefer prefixed imports (`as`) for other cases to make code origin immediately clear
- Avoid basic wildcard imports - they make it impossible to know where variables come from when reading code
