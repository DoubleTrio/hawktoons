import 'dart:async';
import 'dart:core';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockFirebaseUserRepository extends Mock
    implements FirebaseUserRepository {}

void main() {
  group('AuthenticationBloc', () {
    late UserRepository userRepository;
    final userId = 'user-id';

    setUpAll(() {
      userRepository = MockFirebaseUserRepository();
    });

    test('initial state is Uninitialized', () {
      var state = Uninitialized();
      expect(AuthenticationBloc(userRepository: userRepository).state,
          equals(state));
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [Authenticated { userId: $userId }] '
      'when SignInAnonymously is added and authentication is successful',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((invocation) => Future.value(false));
        when(userRepository.authenticate)
          .thenAnswer((invocation) => Future.value());
        when(userRepository.getUserId)
          .thenAnswer((_) => Future.value(userId));
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(SignInAnonymously()),
      expect: () => [LoggingIn(), Authenticated('user-id')],
      verify: (_) {
        verify(userRepository.isAuthenticated).called(1);
        verify(userRepository.getUserId).called(1);
        verify(userRepository.authenticate).called(1);
      }
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingIn(), LoginError] '
      'when SignInAnonymously is added and authentication is not successful',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((invocation) => Future.value(false));
        when(userRepository.authenticate).thenThrow(Exception('error'));
        when(userRepository.getUserId)
          .thenAnswer((_) => Future.value(userId));
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(SignInAnonymously()),
      expect: () => [LoggingIn(), LoginError()],
      verify: (_) {
        verify(userRepository.isAuthenticated).called(1);
        verify(userRepository.authenticate).called(1);
        verifyNever(userRepository.getUserId);
      }
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingIn(), Authenticated { userId: $userId }] '
      'when SignInAnonymously is added and user is already authenticated',
      build: () {
        when(userRepository.isAuthenticated)
          .thenAnswer((invocation) => Future.value(true));
        when(userRepository.getUserId)
          .thenAnswer((_) => Future.value(userId));
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(SignInAnonymously()),
      expect: () => [LoggingIn(), Authenticated(userId)],
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
          .thenAnswer((invocation) => Future.value(null));
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(Logout()),
      expect: () => [LoggingOut(), Uninitialized()],
      verify: (_) {
        verify(userRepository.logout).called(1);
      }
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LoggingOut(), LogoutError()] when Logout throws an error',
      build: () {
        when(userRepository.logout)
          .thenThrow(Exception());
        return AuthenticationBloc(userRepository: userRepository);
      },
      act: (bloc) => bloc.add(Logout()),
      expect: () => [LoggingOut(), LogoutError()],
      verify: (_) {
        verify(userRepository.logout).called(1);
      }
    );
  });
}
