import 'dart:async';

import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/promo.dart';

class PromoRepo extends BaseRepo {
  final _dataController = StreamController<List<Promo>>();
  PromoRepo() : super('kamar');

  Stream<List<Promo>> getData({int limit = 1000}) {
    colRef
        .orderBy('created_Promo', descending: true)
        .limit(limit)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.documents.map((snap) {
        var map = snap.data;
        map['id'] = snap.documentID;
        return Promo.fromMap(map);
      }).toList();
      _dataController.add(data);
    });
    return _dataController.stream;
  }
}
