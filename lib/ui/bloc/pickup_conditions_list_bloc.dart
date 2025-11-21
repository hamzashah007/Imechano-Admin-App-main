import 'package:imechano_admin/ui/model/pickup_conditions_list_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../repository/repository.dart';

class PickupConditionsListBloc {
  // ignore: non_constant_identifier_names
  final pickupConditionsList = PublishSubject<PickupConditionsListModel>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<PickupConditionsListModel> get ConditionsListStream => pickupConditionsList.stream;

  // ignore: non_constant_identifier_names
  Future pickupConditionsListSink(dynamic booking_id) async {
    print("get pickup conditions");
    try {
      final PickupConditionsListModel? model = await _repository.onListCondition(
          booking_id);
      print(model);
      pickupConditionsList.sink.add(model!);
    }catch(ex){
      print('ex!!!!! $ex');
    }
  }

  void dispose() {
    pickupConditionsList.close();
  }
}

final pickupConditionsListBloc = PickupConditionsListBloc();