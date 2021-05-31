import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const OnboardingWidget({
    required this.header,
    required this.body,
    this.child,
    this.assetImage,
  });

  final String header;
  final String body;
  final String? assetImage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 80),
          Semantics(
            header: true,
            child: Text(
              header,
              style: textTheme.headline4!.copyWith(
                color: colorScheme.onSurface
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            body,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onBackground,
              letterSpacing: 1.05
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
