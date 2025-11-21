import 'package:imechano_admin/ui/model/pickup_schedule_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PickupScheduleListBloc {
  final _pickupScheduleList = PublishSubject<PickupScheduleListModel>();
  final _repositiry = Repository();

  Stream<PickupScheduleListModel> get pickupScheduleListStream =>
      _pickupScheduleList.stream;

  Future onpickupScheduleListSink(String userId) async {
    final PickupScheduleListModel model =
        await _repositiry.onPickupScheduleListApi(userId);
    _pickupScheduleList.sink.add(model);
  }

  void dispose() {
    _pickupScheduleList.close();
  }
}

final pickupScheduleListBloc = PickupScheduleListBloc();
