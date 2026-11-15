import 'package:lista_loja/model/post.dart';
import 'package:lista_loja/service/post_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ajudante para buscar apenas os posts do usuario logado no SharedPreferences
class PostHelper {
  Future<List<Post>> getPostsByUser() async {
    PostService _service = PostService();
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("logged") != null && prefs.getBool("logged")!) {
      return _service.fetchPosts(userId: prefs.getInt("userId"));
    }

    return List<Post>.empty();
  }
}
