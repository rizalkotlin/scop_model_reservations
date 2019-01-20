import 'dart:async';

import 'package:scop_model_reservation/scop_model/base_architecture.dart';
//change commit
import 'package:scop_model_reservation/scop_model/model/kamar.dart';

class KamarRepo extends BaseRepo {
  final _dataController = StreamController<List<Kamar>>();
  KamarRepo() : super('kamar');
  Stream<List<Kamar>> getData({int limit = 1000}) {
    colRef
        .orderBy('nama_kamar', descending: true)
        .limit(limit)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.documents.map((snap) {
        var map = snap.data;
        map['id'] = snap.documentID;
        return Kamar.fromMap(map);
      }).toList();
      _dataController.add(data);
    });
    return _dataController.stream;
  }
}
