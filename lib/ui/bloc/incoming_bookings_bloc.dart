import 'package:imechano_admin/ui/model/incoming_bookings_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class IncomingBookingsBloc {
  var _incoming = PublishSubject<IncomingBookingsModel>();
  final _repositiry = Repository();

  Stream<IncomingBookingsModel> get incomingStream => _incoming.stream;

  void clearIncomingStream() {
    _incoming.sink.add(
        IncomingBookingsModel()); // Replace this with your initial/default model
  }

  Future onincomingBookSink(
      String status, String fromdate, String todate) async {
// Clear the stream and set it to an initial state
    clearIncomingStream();

    final IncomingBookingsModel? model =
        await _repositiry.onIncomingBookingsAPI(status, fromdate, todate);
    if (model != null) _incoming.sink.add(model);
  }

  void dispose() {
    _incoming.close();
  }
}

final incomingBookingsBloc = IncomingBookingsBloc();
