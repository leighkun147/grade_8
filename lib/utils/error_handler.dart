import 'package:flutter/material.dart';

enum ErrorType {
  network,
  authentication,
  validation,
  server,
  unknown,
}

class AppError {
  final String message;
  final ErrorType type;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppError({
    required this.message,
    required this.type,
    this.originalError,
    this.stackTrace,
  });

  factory AppError.network(dynamic error) {
    return AppError(
      message: 'Network error occurred. Please check your connection.',
      type: ErrorType.network,
      originalError: error,
    );
  }

  factory AppError.auth(String message) {
    return AppError(
      message: message,
      type: ErrorType.authentication,
    );
  }

  factory AppError.validation(String message) {
    return AppError(
      message: message,
      type: ErrorType.validation,
    );
  }

  factory AppError.server(String message) {
    return AppError(
      message: message,
      type: ErrorType.server,
    );
  }

  factory AppError.unknown(dynamic error, [StackTrace? stackTrace]) {
    return AppError(
      message: 'An unexpected error occurred.',
      type: ErrorType.unknown,
      originalError: error,
      stackTrace: stackTrace,
    );
  }
}

class ErrorHandler {
  static void showError(BuildContext context, AppError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
        backgroundColor: _getErrorColor(error.type),
        action: error.type == ErrorType.network
            ? SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  // TODO: Implement retry logic
                },
              )
            : null,
      ),
    );
  }

  static Color _getErrorColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange;
      case ErrorType.authentication:
        return Colors.red;
      case ErrorType.validation:
        return Colors.yellow.shade900;
      case ErrorType.server:
        return Colors.red.shade900;
      case ErrorType.unknown:
        return Colors.red;
    }
  }

  static void logError(AppError error) {
    // TODO: Implement error logging service
    debugPrint('Error: ${error.message}');
    if (error.originalError != null) {
      debugPrint('Original error: ${error.originalError}');
    }
    if (error.stackTrace != null) {
      debugPrint('Stack trace: ${error.stackTrace}');
    }
  }
}

class ErrorScreen extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getErrorIcon(),
                size: 64,
                color: _getErrorColor(error.type),
              ),
              const SizedBox(height: 24),
              Text(
                _getErrorTitle(),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                error.message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    switch (error.type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.authentication:
        return Icons.lock;
      case ErrorType.validation:
        return Icons.warning;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.unknown:
        return Icons.error;
    }
  }

  String _getErrorTitle() {
    switch (error.type) {
      case ErrorType.network:
        return 'No Internet Connection';
      case ErrorType.authentication:
        return 'Authentication Error';
      case ErrorType.validation:
        return 'Invalid Input';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.unknown:
        return 'Oops! Something Went Wrong';
    }
  }

  Color _getErrorColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange;
      case ErrorType.authentication:
        return Colors.red;
      case ErrorType.validation:
        return Colors.yellow.shade900;
      case ErrorType.server:
        return Colors.red.shade900;
      case ErrorType.unknown:
        return Colors.red;
    }
  }
}
