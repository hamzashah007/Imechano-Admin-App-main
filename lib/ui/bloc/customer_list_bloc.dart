import 'package:imechano_admin/ui/model/customer_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CustomerListBloc {
  final customerList = PublishSubject<CustomerListModel>();
  final _repository = Repository();

  Stream<CustomerListModel> get CustomerListStream => customerList.stream;

  Future customerListSinck(String? status) async {
    print("123123123");

    final CustomerListModel? model =
        await _repository.onCustomerListApi(status!);
    customerList.sink.add(model!);
  }

  void dispose() {
    customerList.close();
  }
}

final customerListBloc = CustomerListBloc();
