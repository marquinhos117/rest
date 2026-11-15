import 'package:flutter/material.dart';
import 'package:lista_loja/helper/login_helper.dart';
import 'package:lista_loja/helper/post_helper.dart';
import 'package:lista_loja/model/post.dart';
import 'package:lista_loja/screens/comment_screen.dart';
import 'package:lista_loja/screens/login_screen.dart';

// tela principal que lista apenas os posts criados pelo usuario logado
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> _posts;
  final PostHelper _helper = PostHelper();
  final LoginHelper loginHelper = LoginHelper();

  @override
  void initState() {
    super.initState();
    // verifica se o usuario esta logado todas as vezes que iniciar a tela
    loginHelper.isUserLogged().then((logged) {
      if (!logged && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
    _posts = _helper.getPostsByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API REST - HOME",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          // botao de logout na AppBar que apaga os dados no SharedPreferences e volta pro login
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await loginHelper.logout();
              if (await loginHelper.isUserLogged() == false && context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data!;
            return ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // ao clicar no post abre a tela de comentarios passando o id do post
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(posts[index].id),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      posts[index].title,
                      style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                    ),
                    subtitle: Text(
                      posts[index].body.replaceAll('\n', ' '),
                      textAlign: TextAlign.justify,
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
