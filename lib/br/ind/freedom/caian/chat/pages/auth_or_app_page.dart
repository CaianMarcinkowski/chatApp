import 'package:chat/br/ind/freedom/caian/chat/core/models/chat_user.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/auth/auth_service.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/br/ind/freedom/caian/chat/pages/auth_page.dart';
import 'package:chat/br/ind/freedom/caian/chat/pages/chat_page.dart';
import 'package:chat/br/ind/freedom/caian/chat/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    try {
      await Firebase.initializeApp();
      Provider.of<ChatNotificationService>(context, listen: false).init();
      print("Firebase inicializado com sucesso!");
    } catch (e) {
      print("Erro ao inicializar o Firebase: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const ChatPage() : const AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
