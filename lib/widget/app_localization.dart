import 'package:flutter/material.dart' hide Action;

class AppLocalization extends StatefulWidget {
  final Widget child;

  const AppLocalization(this.child);

  @override
  State<StatefulWidget> createState() => _AppLocalization();
}

class _AppLocalization extends State<AppLocalization> {
  Locale _locale = const Locale('zh', 'CH');

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}

Widget appLocalization(Widget child) => AppLocalization(child);
