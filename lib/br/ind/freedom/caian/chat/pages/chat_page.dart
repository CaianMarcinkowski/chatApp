import 'package:chat/br/ind/freedom/caian/chat/components/messages.dart';
import 'package:chat/br/ind/freedom/caian/chat/components/new_message.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/auth/auth_service.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/br/ind/freedom/caian/chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat de mensagens',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Sair')
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return NotificationPage();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      //Botão para testar as notificações
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Provider.of<ChatNotificationService>(context, listen: false).add(
      //     ChatNotification(
      //       title: 'Nova notificações',
      //       description: 'Descrição',
      //     ),
      //   );
      // }),
    );
  }
}
