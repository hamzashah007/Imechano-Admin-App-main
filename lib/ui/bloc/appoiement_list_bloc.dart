// ignore_for_file: non_constant_identifier_names

import 'package:imechano_admin/ui/model/appoiement_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AppointmentListBloc {
  final _AppointmentList = PublishSubject<AppoiementListModel>();
  final _repositiry = Repository();

  Stream<AppoiementListModel> get AppointmentListStream =>
      _AppointmentList.stream;

  Future onAppointmentListSink(String fromdate, String todate) async {
    final AppoiementListModel? model =
        await _repositiry.onAppointmentListApi(fromdate, todate);
    if (model != null) _AppointmentList.sink.add(model);
  }

  void dispose() {
    _AppointmentList.close();
  }
}

final appointmentListBloc = AppointmentListBloc();
