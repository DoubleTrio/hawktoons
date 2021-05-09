import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
