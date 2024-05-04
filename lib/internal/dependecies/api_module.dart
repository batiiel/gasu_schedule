import 'package:gagu_schedule/data/api/apiUtil.dart';
import 'package:gagu_schedule/data/api/service/servie_client.dart';
import 'package:gagu_schedule/data/api/service/sql_service.dart';

class ApiModule {
  static late ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    _apiUtil = ApiUtil(ServiceClient(), FavoriteService());
    return _apiUtil;
  }
}
