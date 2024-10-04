import 'package:chat/br/ind/freedom/caian/chat/components/auth_form.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/models/auth_form_data.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _handleSubmit(AuthFormData authFormData) async {
    try {
      if (!mounted) return;

      setState(() => _isLoading = true);

      if (authFormData.isLogin) {
        //Login
        await AuthService().login(authFormData.email, authFormData.password);
      } else {
        //Signup
        await AuthService().signup(
          authFormData.name,
          authFormData.email,
          authFormData.password,
          authFormData.image,
        );
      }
    } catch (e) {
      //Tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _messengerKey,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Stack(children: [
            Center(
              child: SingleChildScrollView(
                child: AuthForm(
                  onSubmit: _handleSubmit,
                  messengerKey: _messengerKey, // Passa a key para AuthForm
                ),
              ),
            ),
            if (_isLoading)
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
