import 'dart:core';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../mocks.dart';

void main() {
  group('AuthenticationBloc', () {
    late UserRepository userRepository;
    final userId = 'user-id';

    setUp(() {
      userRepository = MockFirebaseUserRepository();
    });

    test('initial state is Uninitialized', () {
      expect(
        AuthenticationBloc(userRepository: userRepository).state,
        equals(const Uninitialized()),
      );
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits Authenticated when SignInAnonymously is added '
      'and authentication is successful',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((_) async => false);
        when(userRepository.authenticate)
          .thenAnswer((_) async => null);
        when(userRepository.getUserId)
          .thenAnswer((_) async => userId);
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(const SignInAnonymously()),
      expect: () => [const LoggingIn(), const Authenticated('user-id')],
      verify: (_) {
        verify(userRepository.isAuthenticated).called(1);
        verify(userRepository.getUserId).called(1);
        verify(userRepository.authenticate).called(1);
      });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingIn(), LoginError] '
      'when SignInAnonymously is added and authentication is not successful',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((_) async => false);
        when(userRepository.authenticate).thenThrow(Exception('error'));
        when(userRepository.getUserId)
          .thenAnswer((_) async => userId);
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(const SignInAnonymously()),
      expect: () => [const LoggingIn(), const LoginError()],
      verify: (_) {
        verify(userRepository.isAuthenticated).called(1);
        verify(userRepository.authenticate).called(1);
        verifyNever(userRepository.getUserId);
      });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingIn(), Authenticated { userId: $userId }] '
      'when SignInAnonymously is added and user is already authenticated',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((_) async => true);
        when(userRepository.getUserId)
          .thenAnswer((_) async => userId);
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(const SignInAnonymously()),
      expect: () => [const LoggingIn(), Authenticated(userId)],
      verify: (_) {
        verify(userRepository.isAuthenticated).called(1);
        verifyNever(userRepository.authenticate);
        verify(userRepository.getUserId).called(1);
      }
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingOut(), Uninitialized()] when Logout is added',
      build: () {
        when(userRepository.logout)
          .thenAnswer((_) async => null);
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(const Logout()),
      expect: () => [const LoggingOut(), const Uninitialized()],
      verify: (_) {
        verify(userRepository.logout).called(1);
      }
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingOut(), LogoutError()] when Logout throws an error',
      build: () {
        when(userRepository.logout).thenThrow(Exception());
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(const Logout()),
      expect: () => [const LoggingOut(), const LogoutError()],
      verify: (_) {
        verify(userRepository.logout).called(1);
      }
    );
  });
}
