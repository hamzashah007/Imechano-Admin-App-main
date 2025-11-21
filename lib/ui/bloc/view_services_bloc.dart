import 'package:imechano_admin/ui/model/view_service_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ViewServicesDataBloc {
  final viewservicesdata = PublishSubject<ViewServiceModel>();
  final _repositiry = Repository();

  Stream<ViewServiceModel> get ViewServicesStream => viewservicesdata.stream;

  Future onViewServicesDataSink(String jobNumber) async {
    final ViewServiceModel model =
        await _repositiry.onViewServicesAPI(jobNumber);
    viewservicesdata.sink.add(model);
  }

  void dispose() {
    viewservicesdata.close();
  }
}

final viewServicesDataBloc = ViewServicesDataBloc();
