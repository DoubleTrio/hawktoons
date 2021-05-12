import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  OnboardingWidget({
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
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30.0),
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 15.0),
          Text(
            body,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
