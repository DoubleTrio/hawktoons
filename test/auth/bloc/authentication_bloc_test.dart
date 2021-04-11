import 'dart:async';
import 'dart:core';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/authentication_event.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockFirebaseUserRepository extends Mock
    implements FirebaseUserRepository {}

void main() {
  group('AuthenticationBloc', () {
    late UserRepository userRepository;
    final userId = 'user-id';

    setUpAll(() => {
          userRepository = MockFirebaseUserRepository(),
        });

    test('initial state is Uninitialized', () {
      var state = Uninitialized();
      expect(AuthenticationBloc(userRepository: userRepository).state,
          equals(state));
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Authenticated { userId: $userId }] '
        'when StartApp is added and authentication is successful',
        build: () {
          when(userRepository.isAuthenticated)
              .thenAnswer((invocation) => Future.value(false));
          when(userRepository.authenticate)
              .thenAnswer((invocation) => Future.value());
          when(userRepository.getUserId)
              .thenAnswer((_) => Future.value(userId));
          return AuthenticationBloc(userRepository: userRepository);
        },
        act: (bloc) => bloc.add(StartApp()),
        expect: () => [Authenticated('user-id')],
        verify: (_) => {
              verify(userRepository.isAuthenticated).called(1),
              verify(userRepository.getUserId).called(1),
              verify(userRepository.authenticate).called(1)
            });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Unauthenticated] '
        'when StartApp is added and authentication is not successful',
        build: () {
          when(userRepository.isAuthenticated)
              .thenAnswer((invocation) => Future.value(false));
          when(userRepository.authenticate).thenThrow(Exception('error'));
          when(userRepository.getUserId)
              .thenAnswer((_) => Future.value(userId));
          return AuthenticationBloc(userRepository: userRepository);
        },
        act: (bloc) => bloc.add(StartApp()),
        expect: () => [Unauthenticated()],
        verify: (_) => {
              verify(userRepository.isAuthenticated).called(1),
              verify(userRepository.authenticate).called(1),
              verifyNever(userRepository.getUserId),
            });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Authenticated { userId: $userId }] '
        'when StartApp is added and user is already authenticated',
        build: () {
          when(userRepository.isAuthenticated)
              .thenAnswer((invocation) => Future.value(true));
          when(userRepository.getUserId)
              .thenAnswer((_) => Future.value(userId));
          return AuthenticationBloc(userRepository: userRepository);
        },
        act: (bloc) => bloc.add(StartApp()),
        expect: () => [Authenticated(userId)],
        verify: (_) => {
              verify(userRepository.isAuthenticated).called(1),
              verifyNever(userRepository.authenticate),
              verify(userRepository.getUserId).called(1),
            });
  });
}
