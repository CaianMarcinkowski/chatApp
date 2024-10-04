import 'dart:async';
import 'dart:math';

import 'package:chat/br/ind/freedom/caian/chat/core/models/chat_message.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/models/chat_user.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  //Lista estatica
  static final List<ChatMessage> _msgs = [
    //   ChatMessage(
    //     id: '1',
    //     text: 'Uma nova mensagem no chat',
    //     createdAt: DateTime.now(),
    //     userId: '12387',
    //     userName: 'Marquinhos',
    //     userImageUrl: 'assets/images/avatar-default.png',
    //   ),
    //   ChatMessage(
    //     id: '2',
    //     text: 'Mais uma nova mensagem no chat',
    //     createdAt: DateTime.now(),
    //     userId: '123',
    //     userName: 'João',
    //     userImageUrl: 'assets/images/avatar-default.png',
    //   ),
    //   ChatMessage(
    //     id: '3',
    //     text: 'Mais uma nova mensagem no chat denovo',
    //     createdAt: DateTime.now(),
    //     userId: '1456',
    //     userName: 'Ana',
    //     userImageUrl: 'assets/images/avatar-default.png',
    //   ),
  ];

  //Controller para adicionar nova mensagem
  static MultiStreamController<List<ChatMessage>>? _controller;
  //Stream de dados
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);

    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
