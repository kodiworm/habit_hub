import 'package:flutter/material.dart';
import 'package:theme/src/data/theme_data_container.dart';

class ThemeResolver extends InheritedTheme {
  const ThemeResolver({Key? key, required Widget child, required this.data})
      : super(child: child, key: key);

  final ThemeDataContainer data;

  // static ThemeDataContainer of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<ThemeResolver>()!.data;
  // }


  static ThemeDataContainer of(BuildContext context) {
    final resolver = context.dependOnInheritedWidgetOfExactType<ThemeResolver>();
    if (resolver == null) {
      throw FlutterError(
          'ThemeResolver.of(context) called with a context that does not contain a ThemeResolver.'
              'Ensure that a ThemeResolver widget is an ancestor of the current context.'
      );
    }
    return resolver.data;
  }

  @override
  bool updateShouldNotify(covariant ThemeResolver oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ThemeResolver(
      data: data,
      child: child,
    );
  }
}
