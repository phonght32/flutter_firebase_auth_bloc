import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repo/firebase_auth_repo.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final FirebaseAuthRepo _firebaseAuthRepo;

  FirebaseAuthBloc({
    required FirebaseAuthRepo firebaseAuthRepo,
  }) : _firebaseAuthRepo = firebaseAuthRepo,
        super(const FirebaseAuthState.unknown()) {
    on<FirebaseAuthEventAppStarted>(_onAppStarted);
    on<FirebaseAuthEventRequestedLogIn>((event, emit) async {
      if (_firebaseAuthRepo.isLoggedIn() == true) {
        final user = _firebaseAuthRepo.user;
        emit(FirebaseAuthState.authenticated(user));
      }
    });
    on<FirebaseAuthEventRequestedLogOut>((event, emit) async {
      await _firebaseAuthRepo.logOut();
      emit(const FirebaseAuthState.unauthenticated());
    });
  }

  Future<void> _onAppStarted(
      FirebaseAuthEventAppStarted event,
    Emitter<FirebaseAuthState> emit
  ) async {
    try  {
      if (_firebaseAuthRepo.isLoggedIn() == true) {
        final user = _firebaseAuthRepo.user;
        return emit(FirebaseAuthState.authenticated(user));
      } else {
        return emit(const FirebaseAuthState.unauthenticated());
      }
    } catch (_) {
      return emit(const FirebaseAuthState.unauthenticated());
    }
  }
}