import 'dart:async';

import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/base_state/booking_state.dart';
import 'package:scop_model_reservation/scop_model/base_state/kamar_state.dart';
import 'package:scop_model_reservation/scop_model/base_state/promo_state.dart';
import 'package:scop_model_reservation/scop_model/base_state/user_state.dart';
import 'package:scop_model_reservation/scop_model/model/pengguna.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model
    with BaseState, KamarState, PromoState, BookingState, UserState {
  User currentUser;
  Map<String, User> _users = {};
  StreamSubscription _userStream, _authStream;

  AppState() {
    initState();
  }

  initState() {
    loadDataKamar();
    loadDataBooking();
    loadDataPromo();
    loadDataUser();
  }

  authSream() {
    _authStream = FirebaseAuth.instance.onAuthStateChanged.listen((fuser) {
      if (fuser != null) {
        //read current user stream
        _userStream = User.loadUserSnapshot(fuser.uid).listen((snap) {
          currentUser = new User.fromSnapshot(snap);
          print("!!Data User Ketika Login $currentUser");
          notifyListeners();
        });
      }
    });
  }

  ///dispose all subscription
  void dispose() {
    _userStream?.cancel();
    _authStream?.cancel();
  }
}
