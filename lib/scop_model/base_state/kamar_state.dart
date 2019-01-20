import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/kamar.dart';
import 'package:scop_model_reservation/scop_model/repository/kamar_repo.dart';

abstract class KamarState extends BaseState {
  final _repo = KamarRepo();
  Kamar kamar = Kamar();

  ///jalankan stream data
  loadDataKamar() {
    _repo.getData().listen((it) {
      dataKamar = it;
      notifyListeners();
    });
  }

  createNewKamar() {
    kamar = Kamar();
    notifyListeners();
  }

  selectKamar(Kamar k) {
    kamar = k;
    notifyListeners();
  }

  ///simpan data produk
  Future<String> createKamar() async {
    processing = true;
    notifyListeners();
    var id = await _repo.save(kamar);
    kamar.id = id;
    processing = false;
    notifyListeners();
    return id;
  }

  ///delete data
  deleteKamar() {
    _repo.delete(kamar);
  }
}
