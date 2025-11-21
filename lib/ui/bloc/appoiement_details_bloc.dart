// ignore_for_file: non_constant_identifier_names

import 'package:imechano_admin/ui/model/appoinment_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AppoinmentDeatilsAPIBloc {
  final _AppoinmentDetails = PublishSubject<AppoinmentDetailsModel>();
  final _repositiry = Repository();

  Stream<AppoinmentDetailsModel> get AppoinmentDetailsStream =>
      _AppoinmentDetails.stream;

  Future onappoinmentdetailsblocSink(String appoiement_id) async {
    final AppoinmentDetailsModel model =
        await _repositiry.onAppointmentdetailsAPI(appoiement_id);
    _AppoinmentDetails.sink.add(model);
  }

  void dispose() {
    _AppoinmentDetails.close();
  }
}

final appoinmentDeatilsAPIBloc = AppoinmentDeatilsAPIBloc();
