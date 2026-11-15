import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lista_loja/model/comment.dart';

// servico para buscar os comentarios de um post na api
class CommentService {
  Future<List<Comment>> getComments(int postId) async {
    final String url =
        'https://jsonplaceholder.typicode.com/comments?postId=$postId';
    final response = await http.get(Uri.parse(url));
    List<Comment> comments = List<Comment>.empty(growable: true);

    if (response.statusCode == 200) {
      List resList = jsonDecode(response.body);

      for (var mComment in resList) {
        comments.add(Comment.fromJson(mComment));
      }
    }

    return comments;
  }
}
