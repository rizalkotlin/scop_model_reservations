import 'dart:async';

import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/booking.dart';

class BookingRepo extends BaseRepo {
  final _dataController = StreamController<List<Booking>>();
  BookingRepo() : super('booking');
  Stream<List<Booking>> getData({int limit = 1000}) {
    colRef
        .orderBy('created_booking', descending: true)
        .limit(limit)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.documents.map((snap) {
        var map = snap.data;
        map['id'] = snap.documentID;
        return Booking.fromMap(map);
      }).toList();
      _dataController.add(data);
    });
    return _dataController.stream;
  }
}
