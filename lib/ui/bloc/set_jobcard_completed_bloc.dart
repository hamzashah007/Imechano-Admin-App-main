
import 'package:imechano_admin/ui/model/set_jobcard_completed_model.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';


class SetJobCardCompletedBloc {
  final setJobCardCompleted = PublishSubject<SetJobCardCompletedModel>();
  final _repositiry = Repository();

  Stream<SetJobCardCompletedModel> get SetJobCardCompletedStream => setJobCardCompleted.stream;

  Future onSetJobCardCompletedSink(String jobNumber) async {
    final SetJobCardCompletedModel model = await _repositiry.onSetJobCardCompletedApi(jobNumber);
    setJobCardCompleted.sink.add(model);
  }

  void dispose() {
    setJobCardCompleted.close();
  }
}

final setJobCardCompletedBloc = SetJobCardCompletedBloc();
