import 'package:imechano_admin/ui/model/Garage_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GarageDeatilsAPIBloc {
  final _GarageDetails = PublishSubject<GarageDetailsModel>();
  final _repositiry = Repository();

  Stream<GarageDetailsModel> get GarageDetailsStream => _GarageDetails.stream;

  Future onGaragedetailsblocSink(String garageId) async {
    final GarageDetailsModel model =
        await _repositiry.onGaragedetailsAPI(garageId);
    _GarageDetails.sink.add(model);
  }

  void dispose() {
    _GarageDetails.close();
  }
}

final garageDeatilsAPIBloc = GarageDeatilsAPIBloc();
