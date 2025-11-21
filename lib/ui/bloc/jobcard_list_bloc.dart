// ignore_for_file: non_constant_identifier_names
import 'package:imechano_admin/ui/model/jobcard_list_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class JobcardListBloc {
  final _JobcardList = PublishSubject<JobcardlistModel>();
  final _repositiry = Repository();

  Stream<JobcardlistModel> get JobcardListStream => _JobcardList.stream;

  Future onJobcardListSink({String? garageId}) async {
    final JobcardlistModel model =
        await _repositiry.onJobcardListAPI(garageId: garageId);

    print(model.toJson());
    _JobcardList.sink.add(model);
  }

  void dispose() {
    _JobcardList.close();
  }
}

final jobcardListBloc = JobcardListBloc();
