import 'package:imechano_admin/ui/model/pickup_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PickupDeatilsAPIBloc {
  final _PickupDetails = PublishSubject<PickupdetailsModel>();
  final _repositiry = Repository();

  Stream<PickupdetailsModel> get PickupDetailsStream => _PickupDetails.stream;

  Future onpickupdetailsblocSink(String pickupId) async {
    final PickupdetailsModel model =
        await _repositiry.onPickupdetailsAPI(pickupId);
    _PickupDetails.sink.add(model);
  }

  void dispose() {
    _PickupDetails.close();
  }
}

final pickupDeatilsAPIBloc = PickupDeatilsAPIBloc();
