part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthEvent {
  const FirebaseAuthEvent();
}

final class FirebaseAuthEventAppStarted extends FirebaseAuthEvent {}

final class FirebaseAuthEventRequestedLogIn extends FirebaseAuthEvent {}

final class FirebaseAuthEventRequestedLogOut extends FirebaseAuthEvent {}

