import 'package:scop_model_reservation/scop_model/base_architecture.dart';

class Promo extends BaseModel {
  String id, idKamar, title, description;
  DateTime createdPromo;

  Promo({
    this.id,
    this.idKamar,
    this.title,
    this.description,
    this.createdPromo,
  });

  @override
  String toString() {
    return "$id,$idKamar,$title,$description,$createdPromo";
  }

  Promo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idKamar = map['id_kamar'];
    title = map['title'];
    description = map['description'];
    createdPromo = map[' createdPromo'];
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'id_kamar': idKamar,
        'title': title,
        'description': description,
        'createdPromo': createdPromo,
      };
}
