import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    Key? key,
    required this.header,
    required this.body,
    this.child,
    this.assetImage,
  }) : super(key: key);

  final String header;
  final String body;
  final String? assetImage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 30.0),
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),
          Text(
            body,
            style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.onBackground,
                letterSpacing: 1.1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
