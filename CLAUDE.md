# Flutter Project Rules

## Flutter/Dart Development

- Never manually edit pubspec.yaml to add dependencies
- Always use `dart pub add` or `flutter pub add` to install packages

## Quality Checks

- After completing any prompt, always run `flutter analyze` to check for type errors and other issues
- After completing any prompt, always run `make format` to format code

## Code Reuse and DRY Principle

- BEFORE duplicating any code block, ALWAYS ask if we should extract/reuse existing code instead
- When you notice similar code patterns, proactively suggest refactoring
- Search the codebase first before creating new implementations
- Prefer refactoring over copy-paste, even if it takes more steps
- If duplicating code, explicitly state WHY duplication is appropriate in this case
