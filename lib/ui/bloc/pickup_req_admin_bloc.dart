// import 'package:imechano_admin/ui/model/pickup_req_model.dart';
// import 'package:imechano_admin/ui/repository/repository.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:rxdart/subjects.dart';

// class PickuprequestadminBloc {
//   // ignore: non_constant_identifier_names
//   final Pickuprequestbyadmin = PublishSubject<PickuprequestadminModel>();
//   final _repository = Repository();

//   // ignore: non_constant_identifier_names
//   Stream<PickuprequestadminModel> get PickupRequestadminStream =>
//       Pickuprequestbyadmin.stream;

//   // ignore: non_constant_identifier_names
//   Future PickupRequestadminSinck(String booking_id) async {
//     final PickuprequestadminModel? model =
//         await _repository.onAdminPickupNotificationApi(booking_id);
//     Pickuprequestbyadmin.sink.add(model!);
//   }

//   void dispose() {
//     Pickuprequestbyadmin.close();
//   }
// }

// final pickuprequestadminBloc = PickuprequestadminBloc();
