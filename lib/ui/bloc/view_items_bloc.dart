import 'package:rxdart/rxdart.dart';

import '../model/view_items_model.dart';
import '../repository/repository.dart';

class ViewItemsDataBloc {
  final viewItemsdata = PublishSubject<ViewItemsModel>();
  final _repositiry = Repository();

  Stream<ViewItemsModel> get ViewItemsStream => viewItemsdata.stream;

  Future onViewItemsDataSink(String jobNumber) async {
    // final ViewItemsModel model = await _repositiry.onViewItemsAPI(jobNumber);
    final ViewItemsModel? model = await _repositiry.onViewItemsAPI(jobNumber);
    if (model != null) {
      viewItemsdata.sink.add(model);
    }
  }

  void dispose() {
    viewItemsdata.close();
  }
}

final viewItemsDataBloc = ViewItemsDataBloc();
