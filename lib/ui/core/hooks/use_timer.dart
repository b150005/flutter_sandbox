import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

int usePeriodic({
  Duration interval = const Duration(seconds: 1),
  List<Object>? keys,
}) => use(_TimerHook(interval: interval, keys: keys));

Duration useTimer({
  required Duration duration,
  Duration interval = const Duration(seconds: 1),
  List<Object>? keys,
}) {
  final tick = usePeriodic(interval: interval, keys: keys);

  return useMemoized(
    () => interval * tick > duration ? duration : interval * tick,
    [tick, ...?keys],
  );
}

Duration useCountdown({
  required Duration duration,
  Duration interval = const Duration(seconds: 1),
  List<Object>? keys,
}) {
  final tick = usePeriodic(interval: interval, keys: keys);

  return useMemoized(
    () =>
        interval * tick > duration ? Duration.zero : duration - interval * tick,
    [tick, ...?keys],
  );
}

class _TimerHook extends Hook<int> {
  const _TimerHook({required this.interval, required super.keys});

  final Duration interval;

  @override
  HookState<int, Hook<int>> createState() => _TimerHookState();
}

class _TimerHookState extends HookState<int, _TimerHook> {
  late Timer _timer;

  int _currentTick = 0;

  @override
  void initHook() {
    super.initHook();

    _timer = Timer.periodic(
      hook.interval,
      (timer) => setState(() => _currentTick = timer.tick),
    );
  }

  @override
  int build(BuildContext context) {
    return _currentTick;
  }

  @override
  void deactivate() {
    _timer.cancel();

    super.deactivate();
  }
}
