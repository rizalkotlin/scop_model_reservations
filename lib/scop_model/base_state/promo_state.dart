import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/promo.dart';
import 'package:scop_model_reservation/scop_model/repository/promo_repo.dart';

abstract class PromoState extends BaseState {
  final _repo = PromoRepo();
  Promo promo = Promo();

  ///jalankan stream data
  loadDataPromo() {
    _repo.getData().listen((it) {
      dataPromo = it;
      notifyListeners();
    });
  }

  createNewPromo() {
    promo = Promo();
    notifyListeners();
  }

  selectPromo(Promo p) {
    promo = p;
    notifyListeners();
  }

  ///simpan data produk
  Future<String> createPromo() async {
    processing = true;
    notifyListeners();
    var id = await _repo.save(promo);
    promo.id = id;
    processing = false;
    notifyListeners();
    return id;
  }

  ///delete data
  deletePromo() {
    _repo.delete(promo);
  }
}
