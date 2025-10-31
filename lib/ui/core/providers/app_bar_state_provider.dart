import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/constants/widget_keys.dart';
import '../../../core/config/policies/design_policy.dart';
import '../../../core/utils/l10n/app_localizations.dart';

part 'app_bar_state_provider.freezed.dart';
part 'app_bar_state_provider.g.dart';

@freezed
abstract class AppBarState with _$AppBarState {
  const factory AppBarState({
    Widget? leading,
    @Default(false) bool automaticallyImplyLeading,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    double? scrolledUnderElevation,
    @Default(defaultScrollNotificationPredicate)
    bool Function(ScrollNotification) notificationPredicate,
    Color? shadowColor,
    Color? surfaceTintColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    @Default(true) bool primary,
    bool? centerTitle,
    @Default(false) bool excludeHeaderSemantics,
    double? titleSpacing,
    @Default(1.0) double toolbarOpacity,
    @Default(1.0) double bottomOpacity,
    double? toolbarHeight,
    double? leadingWidth,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
    @Default(false) bool forceMaterialTransparency,
    @Default(true) bool useDefaultSemanticsOrder,
    Clip? clipBehavior,
    EdgeInsetsGeometry? actionsPadding,
    @Default(false) bool animateColor,
  }) = _AppBarState;

  const AppBarState._();

  AppBar get appBar => AppBar(
    key: WidgetKeys.appBar,
    leading: leading ?? const _BackButton(),
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: title,
    actions: actions,
    flexibleSpace: flexibleSpace,
    bottom: bottom,
    elevation: elevation,
    scrolledUnderElevation: scrolledUnderElevation,
    notificationPredicate: notificationPredicate,
    shadowColor: shadowColor,
    surfaceTintColor: surfaceTintColor,
    shape: shape,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    iconTheme: iconTheme,
    actionsIconTheme: actionsIconTheme,
    primary: primary,
    centerTitle: centerTitle,
    excludeHeaderSemantics: excludeHeaderSemantics,
    titleSpacing: titleSpacing,
    toolbarOpacity: toolbarOpacity,
    bottomOpacity: bottomOpacity,
    toolbarHeight: toolbarHeight,
    leadingWidth: leadingWidth,
    toolbarTextStyle: toolbarTextStyle,
    titleTextStyle: titleTextStyle,
    systemOverlayStyle: systemOverlayStyle,
    forceMaterialTransparency: forceMaterialTransparency,
    useDefaultSemanticsOrder: useDefaultSemanticsOrder,
    clipBehavior: clipBehavior,
    actionsPadding: actionsPadding,
    animateColor: animateColor,
  );
}

@Riverpod(keepAlive: true)
class AppBarStateNotifier extends _$AppBarStateNotifier {
  @override
  AppBarState? build() => null;

  AppBarState update(AppBarState newState) => state = newState;

  void clear() => state = null;
}

@immutable
class _BackButton extends ConsumerWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return context.canPop()
        ? IconButton(
            key: WidgetKeys.back,
            onPressed: () => context.pop(),
            icon: Icon(
              DesignPolicy.shouldUseCupertino
                  ? Icons.arrow_back_ios_new_outlined
                  : Icons.arrow_back_outlined,
            ),
            tooltip: l10n.back,
          )
        : const SizedBox.shrink();
  }
}
