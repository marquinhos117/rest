import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lista_loja/model/post.dart';

// servico para buscar os posts do usuario na api 
class PostService {
  Future<List<Post>> fetchPosts({int? userId}) async {
    final String url = userId != null
        ? 'https://jsonplaceholder.typicode.com/posts?userId=$userId'
        : 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));
    List<Post> posts = List<Post>.empty(growable: true);

    if (response.statusCode == 200) {
      List resList = jsonDecode(response.body);

      for (var mPost in resList) {
        posts.add(Post.fromJson(mPost));
      }
    }

    return posts;
  }
}
