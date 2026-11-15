import 'package:lista_loja/model/user.dart';
import 'package:lista_loja/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ajudante para controlar o login e salvar os dados no SharedPreferences
class LoginHelper {
  Future<User?> login(String username, String password) async {
    UserService _service = UserService();
    User? user = await _service.getUserByUsername(username);

    // se encontrou o usuario na api, salva os dados no SharedPreferences
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("logged", true);
      await prefs.setInt("userId", user.id);
      await prefs.setString("userName", user.name);
      await prefs.setString("user", userToJson(user));
      return user;
    } else {
      await logout();
      return null;
    }
  }

  // verifica se tem usuario logado salvo no SharedPreferences
  Future<bool> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged") == null ? false : prefs.getBool("logged")!;
  }

  // apaga os dados do usuario logado no SharedPreferences
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("logged", false);
    await prefs.remove("userId");
    await prefs.remove("userName");
    await prefs.remove("user");
  }
}
