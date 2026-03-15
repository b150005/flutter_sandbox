extension ObjectExtension on Object? {
  T? tryCast<T>() => this is T ? this as T : null;
}
