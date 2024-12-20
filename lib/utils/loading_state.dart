import 'package:flutter/material.dart';

enum LoadingStatus {
  initial,
  loading,
  success,
  error,
}

class LoadingState<T> {
  final LoadingStatus status;
  final T? data;
  final String? error;

  const LoadingState._({
    required this.status,
    this.data,
    this.error,
  });

  factory LoadingState.initial() => const LoadingState._(
        status: LoadingStatus.initial,
      );

  factory LoadingState.loading() => const LoadingState._(
        status: LoadingStatus.loading,
      );

  factory LoadingState.success(T data) => LoadingState._(
        status: LoadingStatus.success,
        data: data,
      );

  factory LoadingState.error(String message) => LoadingState._(
        status: LoadingStatus.error,
        error: message,
      );

  bool get isInitial => status == LoadingStatus.initial;
  bool get isLoading => status == LoadingStatus.loading;
  bool get isSuccess => status == LoadingStatus.success;
  bool get isError => status == LoadingStatus.error;

  R when<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  }) {
    switch (status) {
      case LoadingStatus.initial:
        return initial?.call() ?? loading?.call() ?? _empty();
      case LoadingStatus.loading:
        return loading?.call() ?? _empty();
      case LoadingStatus.success:
        return success?.call(data as T) ?? _empty();
      case LoadingStatus.error:
        return error?.call(this.error ?? 'Unknown error') ?? _empty();
    }
  }

  R _empty<R>() => '' as R;
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      if (message != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ],
      ),
    );
  }
}

class AsyncValueWidget<T> extends StatelessWidget {
  final LoadingState<T> value;
  final Widget Function(T data) onData;
  final Widget Function(String error)? onError;
  final Widget Function()? onLoading;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.onData,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => onLoading?.call() ?? const LoadingWidget(),
      error: (error) =>
          onError?.call(error) ??
          Center(
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                  ),
            ),
          ),
      success: onData,
    );
  }
}
