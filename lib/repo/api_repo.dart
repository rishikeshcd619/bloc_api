import 'package:coinone/https/api_provider.dart';

class ApiRepository {
  final apiProvider = ApiProvider();
  Future<dynamic> getData() => apiProvider.getData();
}
