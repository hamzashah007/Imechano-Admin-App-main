import 'package:imechano_admin/ui/model/customer_details_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CustomerDeatilsAPIBloc {
  final _CustomerDetails = PublishSubject<CustomerDetailsModel>();
  final _repositiry = Repository();

  Stream<CustomerDetailsModel> get CustomerDetailsStream =>
      _CustomerDetails.stream;

  Future oncustomerdetailsblocSink(String customerId) async {
    final CustomerDetailsModel model =
        await _repositiry.oncustomerdetailsAPI(customerId);
    _CustomerDetails.sink.add(model);
  }

  void dispose() {
    _CustomerDetails.close();
  }
}

final customerDeatilsAPIBloc = CustomerDeatilsAPIBloc();
