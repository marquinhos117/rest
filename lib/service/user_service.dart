import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lista_loja/model/user.dart';

// servico para buscar o usuario na api
class UserService {
  Future<User?> getUserByUsername(String username) async {
    final String url =
        'https://jsonplaceholder.typicode.com/users?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List rList = jsonDecode(response.body);

      if (rList.isNotEmpty) {
        User rUser = User.fromJson(rList.first);
        return rUser;
      } else {
        return null;
      }
    } else {
      throw Exception("Falha na conexão com o servidor!");
    }
  }
}
