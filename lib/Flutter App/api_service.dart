import 'dart:developer';

import 'package:http/http.dart' as http;

import 'UserModel.dart';
import 'constant.dart';
//import 'package:rest_api_example/constants.dart';
//import 'package:rest_api_example/model/user_model.dart';

class ApiService {
  Future<List<ProfileDetailsJson>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProfileDetailsJson> _model = profileDetailsJsonFromJson(
            response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

}
