import 'package:imechano_admin/ui/model/incoming_bookings_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class IncomingBookingsDetailsBloc {
  final _incomingdetails = PublishSubject<IncomingBookingsDetailsModel>();
  final _repositiry = Repository();

  Stream<IncomingBookingsDetailsModel> get incomingdetailsStream =>
      _incomingdetails.stream;

  Future onincomingdetailsSink(String id) async {
    final IncomingBookingsDetailsModel model =
        await _repositiry.onIncomingBookingsDetailsApi(id);
    _incomingdetails.sink.add(model);
  }

  void dispose() {
    _incomingdetails.close();
  }
}

final incomingBookingsDetailsBloc = IncomingBookingsDetailsBloc();
