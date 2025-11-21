import 'package:imechano_admin/ui/model/booking_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class BookingListbloc {
  final _bookinglist = PublishSubject<BookingDetailsModel>();
  final _repository = Repository();

  Stream<BookingDetailsModel> get bookingliststream => _bookinglist.stream;

  // ignore: non_constant_identifier_names
  Future bookinglistsink(String customer_id, String status,
      {String search = "",
      String start_date = "0",
      String end_date = "",
      String category = ""}) async {
    final BookingDetailsModel? bookingListModel =
        await _repository.BookingListAPI(
            customer_id, status, search, start_date, end_date, category);
    if (bookingListModel != null) _bookinglist.sink.add(bookingListModel);
  }

  void dispose() {
    _bookinglist.close();
  }
}

final bookingListbloc = BookingListbloc();
