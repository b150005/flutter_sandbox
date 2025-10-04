import 'package:flutter/material.dart';

extension AsyncSnapshotWidget<T> on AsyncSnapshot<T> {
  Widget when({
    required Widget Function() loading,
    required Widget Function(Object? error, StackTrace? stackTrace) error,
    required Widget Function(T? data) data,
  }) => switch (connectionState) {
    ConnectionState.none || ConnectionState.waiting => loading(),
    _ => hasError ? error(this.error, stackTrace) : data(this.data),
  };
}
