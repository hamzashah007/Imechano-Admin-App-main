import 'package:imechano_admin/ui/model/admin_notification_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AdminNotificationListBloc {
  final _notificationList = PublishSubject<AdminNotificationListModel>();
  final _repositiry = Repository();

  Stream<AdminNotificationListModel> get notificationListStream =>
      _notificationList.stream;

  Future onnotificationListSink() async {
    final AdminNotificationListModel model =
        await _repositiry.onAdminNotificationListApi();
    _notificationList.sink.add(model);
  }

  void dispose() {
    _notificationList.close();
  }
}

final adminNotificationListBloc = AdminNotificationListBloc();
