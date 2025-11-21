import 'package:imechano_admin/ui/model/cust_job_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CustJobListAPIBloc {
  final _CustomerJobList = PublishSubject<CustomerJobListModel>();
  final _repositiry = Repository();
  String? delivery_time;

  Stream<CustomerJobListModel> get CustomerJobListStream =>
      _CustomerJobList.stream;

  Future oncustomerjobblocSink(String jobNumber) async {
    final CustomerJobListModel model =
        await _repositiry.onCustJobListAPI(jobNumber);
    _CustomerJobList.sink.add(model);
    delivery_time = model.data!.first.delivery_time;
  }

  Future loadJobCardData(String jobNumber) async {
    return await _repositiry.onCustJobListAPI(jobNumber);

  }

  void dispose() {
    _CustomerJobList.close();
  }
}

final custJobListAPIBloc = CustJobListAPIBloc();
