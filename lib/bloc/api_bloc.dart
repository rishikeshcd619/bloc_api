import 'dart:async';
import 'package:coinone/repo/api_repo.dart';

class ApiBloc {
  final _apiRepo = ApiRepository();
  final StreamController _apiController = StreamController<dynamic>.broadcast();
  Sink get _apiSink => _apiController.sink;
  Stream<dynamic> get apiStream => _apiController.stream;

  ApiBloc() {
    getUsers();
  }

  getUsers() async {
    _apiSink.add(await _apiRepo.getData());
  }

  dispose() {
    _apiController.close();
  }
}
