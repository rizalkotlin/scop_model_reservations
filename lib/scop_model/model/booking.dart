import 'package:scop_model_reservation/scop_model/base_architecture.dart';

class Booking extends BaseModel {
  String id, idKamar, uid;
  DateTime createdBooking, createdCheckin;
  bool status;

  Booking({
    this.id,
    this.idKamar,
    this.uid,
    this.createdBooking,
    this.createdCheckin,
    this.status,
  });

  @override
  String toString() {
    return "$id,$idKamar,$uid,$createdBooking,$createdCheckin,$status";
  }

  Booking.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idKamar = map['id_kamar'];
    uid = map['uid'];
    createdBooking = map['created_booking'];
    createdCheckin = map['created_checkin'];
    status = map['status'];
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'id_kamar': idKamar,
        'uid': uid,
        'createdBooking': createdBooking,
        'createdCheckin': createdCheckin,
        'status': status,
      };
}
