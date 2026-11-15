import 'package:flutter/material.dart';
import 'package:lista_loja/helper/comment_helper.dart';
import 'package:lista_loja/helper/login_helper.dart';
import 'package:lista_loja/model/comment.dart';
import 'package:lista_loja/screens/login_screen.dart';

// tela que mostra os comentarios vinculados ao post clicado
class CommentScreen extends StatefulWidget {
  final int postId;

  const CommentScreen(this.postId, {super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentHelper _helper = CommentHelper();
  final LoginHelper _loginHelper = LoginHelper();
  late Future<List<Comment>> _commentsList;

  @override
  void initState() {
    super.initState();
    // verifica se o usuario esta logado todas as vezes que iniciar a tela
    _loginHelper.isUserLogged().then((logged) {
      if (!logged && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
    _commentsList = _helper.getAllComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comment of Post ${widget.postId}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // botao de logout na AppBar
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await _loginHelper.logout();
              if (await _loginHelper.isUserLogged() == false && context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Comment>>(
        future: _commentsList,
        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.hasData) {
            List<Comment> comments = snapshot.data!;
            return ListView.separated(
              itemCount: comments.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "${comments[index].name} - ${comments[index].email}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(comments[index].body),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
