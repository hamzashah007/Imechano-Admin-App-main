import 'package:imechano_admin/ui/model/garage_profile_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GarageProfileAPIBloc {
  final _GarageProfile = PublishSubject<GarageProfileModel>();
  final _repositiry = Repository();

  Stream<GarageProfileModel> get GarageProfileStream => _GarageProfile.stream;

  Future ongarageprofileblocSink() async {
    final GarageProfileModel model = await _repositiry.onGarageProfileApi();
    _GarageProfile.sink.add(model);
  }

  void dispose() {
    _GarageProfile.close();
  }
}

final garageProfileAPIBloc = GarageProfileAPIBloc();
