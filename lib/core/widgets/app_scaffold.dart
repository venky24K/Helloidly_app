import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom Scaffold wrapper that provides consistent styling across the app,
/// including background colors and system navigation bar styling.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool safeArea;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    // Default background color (can be moved to a constants file later)
    final Color bgColor = backgroundColor ?? const Color(0xFFFAFAFA);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appBar,
        body: safeArea ? SafeArea(child: body) : body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
