import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Kamar extends BaseModel {
  String id, namaKamar, fasilitas;
  int lantai;

  static CollectionReference _ref = Firestore.instance.collection('kamar');

  Kamar({this.id, this.namaKamar, this.fasilitas, this.lantai});

  @override
  String toString() {
    return "$id,$namaKamar,$fasilitas,$lantai";
  }

  Kamar.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    namaKamar = map['nama_kamar'];
    fasilitas = map['fasilitas'];
    lantai = map['lantai'];
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_kamar': namaKamar,
        'fasilitas': fasilitas,
        'lantai': lantai,
      };

  ///update image url
  static updatePhotoUrl(String id, String url) {
    return _ref.document(id).updateData({'gambar': url});
  }
}
