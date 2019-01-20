import 'dart:async';

//comit change
import 'package:scop_model_reservation/scop_model/model/booking.dart';
import 'package:scop_model_reservation/scop_model/model/kamar.dart';
import 'package:scop_model_reservation/scop_model/model/pengguna.dart';
import 'package:scop_model_reservation/scop_model/model/promo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class BaseModel {
  String id;
  BaseModel();
  BaseModel.fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

///Base class for repository bussines
///logic firestore
class BaseRepo {
  CollectionReference colRef;

  ///Constructor
  BaseRepo(String path) {
    colRef = Firestore.instance.collection(path);
  }

  ///Save data to firestore
  Future<String> save(BaseModel model) async {
    if (model.id == null) {
      return (await colRef.add(model.toMap())).documentID;
    } else {
      await colRef.document(model.id).updateData(model.toMap());
      return model.id;
    }
  }

  ///delete data from firestore
  delete(BaseModel model) {
    return colRef.document(model.id).delete();
  }

  ///find data by id (returning map)
  Future<Map<String, dynamic>> findById(String id) async {
    final snap = await colRef.document(id).get();
    final map = snap.data;
    if (map != null) map[id] = snap.documentID;
    return map;
  }
}

///Base class for scoped_model state
class BaseState extends Model {
  bool processing = false;
  List<Kamar> dataKamar = [];
  List<Promo> dataPromo = [];
  List<Booking> dataBooking = [];
  List<User> dataUser = [];
  //List<Order> dataOrder = [];
}
