import 'package:flutter/material.dart';
import 'package:lista_loja/helper/login_helper.dart';
import 'package:lista_loja/model/user.dart';
import 'package:lista_loja/screens/home_screen.dart';

// tela de login para entrar com o username do jsonplaceholder
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginHelper _helper = LoginHelper();

  @override
  void initState() {
    super.initState();
    // verifica se ja tem usuario logado salvo no SharedPreferences ao abrir a tela
    _helper.isUserLogged().then((logged) {
      if (logged && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API REST",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // campo para digitar o username (usar Bret, Antonette, Samantha)
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preenchimento obrigatório!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // campo para digitar a senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preenchimento obrigatório!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // botao de logar
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                    ),
                    child: const Text(
                      "Logar",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user = await _helper.login(
                          _usernameController.text.trim(),
                          _passwordController.text,
                        );
                        if (!context.mounted) return;

                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Usuário não encontrado!'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
