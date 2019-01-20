import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:scop_model_reservation/scop_model/model/booking.dart';
import 'package:scop_model_reservation/scop_model/repository/booking_repo.dart';

abstract class BookingState extends BaseState {
  final _repo = BookingRepo();
  Booking booking = Booking();

  ///jalankan stream data
  loadDataBooking() {
    _repo.getData().listen((it) {
      dataBooking = it;
      notifyListeners();
    });
  }

  createNewBooking() {
    booking = Booking();
    notifyListeners();
  }

  selectBooking(Booking b) {
    booking = b;
    notifyListeners();
  }

  ///simpan data produk
  Future<String> createBooking() async {
    processing = true;
    notifyListeners();
    var id = await _repo.save(booking);
    booking.id = id;
    processing = false;
    notifyListeners();
    return id;
  }

  ///delete data
  deleteBooking() {
    _repo.delete(booking);
  }
}
