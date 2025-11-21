// ignore_for_file: non_constant_identifier_names
import 'package:imechano_admin/ui/model/view_parts_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ViewPartsDataBloc {
  final viewpartsdata = PublishSubject<ViewPartsModel>();
  final _repositiry = Repository();

  Stream<ViewPartsModel> get ViewpartsStream => viewpartsdata.stream;

  Future onViewPartsDataSink(String job_number) async {
    final ViewPartsModel model = await _repositiry.onViewDataAPI(job_number);
    viewpartsdata.sink.add(model);
  }

  void dispose() {
    viewpartsdata.close();
  }
}

final viewPartsDataBloc = ViewPartsDataBloc();
