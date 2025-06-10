import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ProviderChangeNotifier<T> extends ChangeNotifier {
  ProviderChangeNotifier({
    required Ref ref,
    required ProviderListenable<T> provider,
  }) : _ref = ref,
       _listenable = provider {
    _subscription = _ref.listen<T>(_listenable, (_, _) => notifyListeners());
  }

  final Ref _ref;
  final ProviderListenable<T> _listenable;

  late final ProviderSubscription _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
