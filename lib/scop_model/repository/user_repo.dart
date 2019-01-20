import 'dart:async';

import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/pengguna.dart';

///Repository cloud firestore connector
///Untuk hubungkan bussines logic ke cloud database
class UserRepo extends BaseRepo {
  final _dataController = StreamController<List<User>>();
  UserRepo() : super('user');

  Stream<List<User>> getData({int limit = 1000}) {
    colRef.limit(limit).snapshots().listen((snapshot) {
      final data = snapshot.documents.map((snap) {
        var map = snap.data;
        map['uid'] = snap.documentID;
        return User.fromMap(map);
      }).toList();
      _dataController.add(data);
    });
    return _dataController.stream;
  }
}
