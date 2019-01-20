import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/pengguna.dart';
import 'package:scop_model_reservation/scop_model/repository/user_repo.dart';

abstract class UserState extends BaseState {
  final _repo = UserRepo();
  User user = User();

  ///jalananin stream data
  loadDataUser() {
    _repo.getData().listen((it) {
      dataUser = it;
      notifyListeners();
    });
  }

  ///filter pencarian data User
  List<User> filterUser(String query) {
    if (dataUser != null) {
      var result = dataUser.where((it) {
        var q = query.toLowerCase(); //ubah kata kunci ke huruf kecil
        var f1 = it.displayName.toLowerCase(); //ubah nama barang ke huruf kecil
        return f1.contains(q); //cek apakah f1 atau f2 berisi kata kunci q
      });
      return result; //return hasil filter
    }
    return [];
  }

  ///pilih data stok saat ini
  selectUser(User u) {
    user = u;
    notifyListeners();
  }
}
