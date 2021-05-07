import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/home/home_flow.dart';

class AuthFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
        state: context.watch<AuthenticationBloc>().state,
        onGeneratePages: (state, pages) {
          if (state is Authenticated) {
            return [LoginPage(), HomeFlowPage()];
          }
          return [LoginPage()];
        });
  }
}
