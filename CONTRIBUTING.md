# Contributing to Grade 8 National Exam Prep App

First off, thank you for considering contributing to the Grade 8 National Exam Prep App! It's people like you that make this app a great tool for students.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps which reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include screenshots if possible
* Include error messages if any

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* Use a clear and descriptive title
* Provide a step-by-step description of the suggested enhancement
* Provide specific examples to demonstrate the steps
* Describe the current behavior and explain which behavior you expected to see instead
* Explain why this enhancement would be useful
* List some other applications where this enhancement exists, if applicable

### Pull Requests

* Fill in the required template
* Do not include issue numbers in the PR title
* Include screenshots and animated GIFs in your pull request whenever possible
* Follow the Flutter style guide
* Include thoughtfully-worded, well-structured tests
* Document new code based on the Documentation Styleguide
* End all files with a newline

## Development Process

1. Fork the repo
2. Create a new branch from `main`
3. Make your changes
4. Run tests
5. Create pull request

### Branch Naming Convention

* Feature: `feature/description`
* Bug fix: `fix/description`
* Documentation: `docs/description`
* Performance: `perf/description`

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
* feat: A new feature
* fix: A bug fix
* docs: Documentation only changes
* style: Changes that do not affect the meaning of the code
* refactor: A code change that neither fixes a bug nor adds a feature
* perf: A code change that improves performance
* test: Adding missing tests
* chore: Changes to the build process or auxiliary tools

## Style Guide

### Dart Style Guide

* Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
* Use `dartfmt` to format your code
* Run `flutter analyze` before committing

### Documentation Style Guide

* Use [dartdoc](https://dart.dev/tools/dartdoc) comments
* Document all public APIs
* Include code examples in documentation when applicable

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run tests with coverage
flutter test --coverage
```

### Writing Tests

* Write unit tests for all new code
* Write widget tests for all new widgets
* Write integration tests for all new features
* Aim for high test coverage
* Follow test naming convention: `should_do_something_when_something`

## Project Structure

```
lib/
├── di/                 # Dependency injection
├── models/            # Data models
├── providers/         # State management
├── screens/           # UI screens
├── services/          # Business logic
├── utils/             # Utilities
└── widgets/           # Reusable widgets
```

## Release Process

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Create and push tag
4. CI/CD will handle the release

## Getting Help

* Join our [Slack channel](https://grade8prep.slack.com)
* Check out the [documentation](docs/)
* Email the maintainers at maintainers@grade8prep.com

## Code Review Process

1. Another developer must review your code
2. All tests must pass
3. Code coverage must not decrease
4. Documentation must be updated
5. CHANGELOG.md must be updated
6. Commit messages must follow convention

## Community

* Join our [Slack channel](https://grade8prep.slack.com)
* Follow us on [Twitter](https://twitter.com/grade8prep)
* Read our [blog](https://blog.grade8prep.com)

## Recognition

Contributors will be:
* Listed in CONTRIBUTORS.md
* Mentioned in release notes
* Given credit in the app's about page

Thank you for contributing! 🎉
