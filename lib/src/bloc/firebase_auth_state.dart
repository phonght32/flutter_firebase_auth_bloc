part of 'firebase_auth_bloc.dart';

class FirebaseAuthState extends Equatable {
  final AuthUser user;

  const FirebaseAuthState._({
    this.user = AuthUser.empty,
  });

  const FirebaseAuthState.unknown() : this._();

  const FirebaseAuthState.authenticated(AuthUser user)
    : this._(user: user);

  const FirebaseAuthState.unauthenticated()
    : this._();

  @override
  List<Object> get props => [user];
}