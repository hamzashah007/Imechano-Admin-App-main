import 'package:imechano_admin/ui/model/customer_data_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CustomerDataAPIBloc {
  final _CustomerData = PublishSubject<CustomerDataModel>();
  final _repositiry = Repository();

  Stream<CustomerDataModel> get CustomerDataStream => _CustomerData.stream;

  Future oncustomerdatablocSink(String page) async {
    final CustomerDataModel model = await _repositiry.oncustomerdataAPI(page);
    _CustomerData.sink.add(model);
  }

  void dispose() {
    _CustomerData.close();
  }
}

final customerdataaPIbloc = CustomerDataAPIBloc();
