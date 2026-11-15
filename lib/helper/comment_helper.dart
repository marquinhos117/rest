import 'package:lista_loja/model/comment.dart';
import 'package:lista_loja/service/comment_service.dart';

// ajudante para buscar os comentarios de um post especifico
class CommentHelper {
  final CommentService _service = CommentService();

  Future<List<Comment>> getAllComments(int postId) {
    return _service.getComments(postId);
  }
}
