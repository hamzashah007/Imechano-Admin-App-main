// ignore_for_file: non_constant_identifier_names

import 'package:imechano_admin/ui/model/pickup_request_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PickupRequestBloc {
  final pickupRequest = PublishSubject<PickupRequestModel>();
  final _repository = Repository();

  Stream<PickupRequestModel> get PickupRequestStream => pickupRequest.stream;

  // ignore: non_constant_identifier_names
  Future PickupRequestSinck(
    String customer_id,
  ) async {
    print("123123123");

    final PickupRequestModel? model =
        await _repository.onPickupRequestApi(customer_id);
    pickupRequest.sink.add(model!);
  }

  void dispose() {
    pickupRequest.close();
  }
}

final pickupRequestBloc = PickupRequestBloc();
