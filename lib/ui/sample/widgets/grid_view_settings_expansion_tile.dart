import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class GridViewSettingsOption<T> {
  const GridViewSettingsOption({
    required this.title,
    required ValueNotifier<T> valueNotifier,
    this.min = 0,
    this.max = 1,
    this.hintText,
  }) : _valueNotifier = valueNotifier;

  final String title;
  final ValueNotifier<T> _valueNotifier;
  final double min;
  final double max;
  final String? hintText;

  ValueNotifier<T> get valueNotifier => _valueNotifier;
}

@immutable
class _DropdownOption<T> {
  const _DropdownOption({
    T? value,
    required this.label,
    this.isDefault = false,
    this.enabled = true,
  }) : _value = value;

  final T? _value;
  final String label;
  final bool isDefault;
  final bool enabled;

  DropdownMenuEntry<T?> get dropdownMenuEntry => DropdownMenuEntry(
    value: _value,
    label: isDefault ? '$label (default)' : label,
    enabled: enabled,
  );
}

class GridViewSettingsExpansionTile<T> extends StatelessWidget {
  const GridViewSettingsExpansionTile({
    super.key,
    required List<GridViewSettingsOption<T>> options,
    required this.onControllerChanged,
    required this.onPrimaryChanged,
  }) : _options = options;

  final List<GridViewSettingsOption<T>> _options;

  final void Function({ScrollController? controller}) onControllerChanged;
  final void Function({bool? primary}) onPrimaryChanged;

  @override
  Widget build(BuildContext context) => ExpansionTile(
    title: const Text('GridView.extent'),
    children: _options
        .map(
          (option) => _GridViewSettingsListTile(
            option: option,
            onControllerChanged: onControllerChanged,
            onPrimaryChanged: onPrimaryChanged,
          ),
        )
        .toList(),
  );
}

class _GridViewSettingsListTile<T> extends StatefulWidget {
  const _GridViewSettingsListTile({
    super.key,
    required GridViewSettingsOption<T> option,
    required this.onControllerChanged,
    required this.onPrimaryChanged,
  }) : _option = option;

  final GridViewSettingsOption<T> _option;

  final void Function({ScrollController? controller}) onControllerChanged;
  final void Function({bool? primary}) onPrimaryChanged;

  static const _sliderWidthRatio = 0.6;
  static const _defaultDivisions = 10;

  static final List<_DropdownOption<ScrollController>> scrollControllerOptions =
      [
        const _DropdownOption(label: 'null', isDefault: true),
        _DropdownOption(value: ScrollController(), label: 'ScrollController'),
        _DropdownOption(
          value: TrackingScrollController(),
          label: 'TrackingScrollController',
        ),
        _DropdownOption(
          value: FixedExtentScrollController(),
          label: 'FixedExtentScrollController',
        ),
        _DropdownOption(value: PageController(), label: 'PageController'),
      ];

  static const List<_DropdownOption<ScrollPhysics>> scrollPhysicsOptions = [
    _DropdownOption(label: 'null', isDefault: true),
    _DropdownOption(
      value: AlwaysScrollableScrollPhysics(),
      label: 'AlwaysScrollable',
    ),
    _DropdownOption(
      value: NeverScrollableScrollPhysics(),
      label: 'NeverScrollable',
    ),
    _DropdownOption(value: BouncingScrollPhysics(), label: 'Bouncing'),
    _DropdownOption(value: ClampingScrollPhysics(), label: 'Clamping'),
    _DropdownOption(value: FixedExtentScrollPhysics(), label: 'FixedExtent'),
    _DropdownOption(value: PageScrollPhysics(), label: 'Page'),
    _DropdownOption(
      value: RangeMaintainingScrollPhysics(),
      label: 'RangeMaintaining',
    ),
  ];

  static const List<_DropdownOption<DragStartBehavior>>
  dragStartBehaviorOptions = [
    _DropdownOption(value: DragStartBehavior.down, label: 'down'),
    _DropdownOption(
      value: DragStartBehavior.start,
      label: 'start',
      isDefault: true,
    ),
  ];

  static const List<_DropdownOption<ScrollViewKeyboardDismissBehavior>>
  scrollViewKeyboardDismissBehaviorOptions = [
    _DropdownOption(label: 'null', isDefault: true),
    _DropdownOption(
      value: ScrollViewKeyboardDismissBehavior.manual,
      label: 'manual',
    ),
    _DropdownOption(
      value: ScrollViewKeyboardDismissBehavior.onDrag,
      label: 'onDrag',
    ),
  ];

  static const List<_DropdownOption<Clip>> clipOptions = [
    _DropdownOption(value: Clip.none, label: 'none'),
    _DropdownOption(value: Clip.hardEdge, label: 'hardEdge', isDefault: true),
    _DropdownOption(value: Clip.antiAlias, label: 'antiAlias'),
    _DropdownOption(
      value: Clip.antiAliasWithSaveLayer,
      label: 'antiAliasWithSaveLayer',
    ),
  ];

  static const List<_DropdownOption<HitTestBehavior>> hitTestBehaviorOptions = [
    _DropdownOption(value: HitTestBehavior.deferToChild, label: 'deferToChild'),
    _DropdownOption(
      value: HitTestBehavior.opaque,
      label: 'opaque',
      isDefault: true,
    ),
    _DropdownOption(value: HitTestBehavior.translucent, label: 'translucent'),
  ];

  @override
  State<_GridViewSettingsListTile<T>> createState() =>
      _GridViewSettingsListTileState<T>();
}

class _GridViewSettingsListTileState<T>
    extends State<_GridViewSettingsListTile<T>> {
  @override
  void dispose() {
    for (final option in _GridViewSettingsListTile.scrollControllerOptions) {
      option._value?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => switch (widget._option.valueNotifier) {
    ValueNotifier<bool?>() => SwitchListTile.adaptive(
      title: Text(widget._option.title),
      value: (widget._option.valueNotifier.value as bool?) ?? false,
      onChanged: (value) {
        widget._option.valueNotifier.value = value as T;

        if (widget._option.valueNotifier is ValueNotifier<bool?>) {
          widget.onPrimaryChanged(
            primary: widget._option.valueNotifier.value as bool?,
          );
        }
      },
    ),

    ValueNotifier<double>() => ListTile(
      title: Text(widget._option.title),
      subtitle: Text(
        (widget._option.valueNotifier.value as double).toStringAsFixed(1),
      ),
      trailing: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width:
              constraints.maxWidth *
              _GridViewSettingsListTile._sliderWidthRatio,
          child: Slider.adaptive(
            value: widget._option.valueNotifier.value as double,
            min: widget._option.min,
            max: widget._option.max,
            onChanged: (value) =>
                widget._option.valueNotifier.value = value as T,
            divisions:
                (widget._option.max <= 1
                        ? _GridViewSettingsListTile._defaultDivisions
                        : widget._option.max - widget._option.min)
                    .round(),
            label: widget._option.valueNotifier.value.toString(),
          ),
        ),
      ),
    ),

    ValueNotifier<double?>() || ValueNotifier<int?>() => ListTile(
      title: Text(widget._option.title),
      subtitle: Text(
        widget._option.valueNotifier is ValueNotifier<int?> ||
                widget._option.valueNotifier.value == null
            ? widget._option.valueNotifier.value.toString()
            : (widget._option.valueNotifier.value as double).toStringAsFixed(1),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioMenuButton(
            value: null,
            groupValue: widget._option.valueNotifier.value,
            onChanged: (value) =>
                widget._option.valueNotifier.value = value as T,
            child: const Text('null'),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                width:
                    constraints.maxWidth *
                    _GridViewSettingsListTile._sliderWidthRatio,
                child: Slider.adaptive(
                  value:
                      (widget._option.valueNotifier.value as num?)
                          ?.toDouble() ??
                      0,
                  min: widget._option.min,
                  max: widget._option.max,
                  onChanged: (value) {
                    if (widget._option._valueNotifier is ValueNotifier<int?>) {
                      widget._option.valueNotifier.value = value.round() as T;
                      return;
                    }

                    widget._option.valueNotifier.value = value as T;
                  },
                  divisions:
                      (widget._option.max <= 1
                              ? _GridViewSettingsListTile._defaultDivisions
                              : widget._option.max - widget._option.min)
                          .round(),
                  label: widget._option.valueNotifier.value.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    ValueNotifier<ScrollController?>() ||
    ValueNotifier<ScrollPhysics?>() ||
    ValueNotifier<DragStartBehavior>() ||
    ValueNotifier<ScrollViewKeyboardDismissBehavior?>() ||
    ValueNotifier<Clip>() ||
    ValueNotifier<HitTestBehavior>() => ListTile(
      title: Text(widget._option.title),
      trailing: DropdownMenu(
        dropdownMenuEntries: switch (widget._option.valueNotifier) {
          ValueNotifier<ScrollController?>() =>
            _GridViewSettingsListTile.scrollControllerOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          ValueNotifier<ScrollPhysics?>() =>
            _GridViewSettingsListTile.scrollPhysicsOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          ValueNotifier<DragStartBehavior>() =>
            _GridViewSettingsListTile.dragStartBehaviorOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          ValueNotifier<ScrollViewKeyboardDismissBehavior?>() =>
            _GridViewSettingsListTile.scrollViewKeyboardDismissBehaviorOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          ValueNotifier<Clip>() =>
            _GridViewSettingsListTile.clipOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          ValueNotifier<HitTestBehavior>() =>
            _GridViewSettingsListTile.hitTestBehaviorOptions
                .map((option) => option.dropdownMenuEntry)
                .toList(),
          _ => throw UnimplementedError(),
        },
        initialSelection: widget._option.valueNotifier.value,
        onSelected: (value) {
          widget._option.valueNotifier.value = value as T;

          if (widget._option.valueNotifier
              is ValueNotifier<ScrollController?>) {
            widget.onControllerChanged(
              controller:
                  widget._option.valueNotifier.value as ScrollController?,
            );
          }
        },
        hintText: widget._option.hintText,
      ),
    ),

    _ => throw UnimplementedError(),
  };
}
