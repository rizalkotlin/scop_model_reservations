class BookingRiwayat {
  String id, idBooking, uid;
  DateTime createBooking;

  BookingRiwayat({
    this.id,
    this.idBooking,
    this.uid,
    this.createBooking,
  });

  @override
  String toString() {
    return "$id,$idBooking,$uid,$createBooking";
  }

  BookingRiwayat.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idBooking = map['id_booking'];
    uid = map['uid'];
    createBooking = map['created_booking'];
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'id_booking': idBooking,
        'uid': uid,
        'created_booking': createBooking,
      };
}
