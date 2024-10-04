import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat/br/ind/freedom/caian/chat/core/models/chat_user.dart';
import 'package:chat/br/ind/freedom/caian/chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = ChatUser(
    id: '123',
    name: 'João',
    email: 'joao@gmail.com',
    imageUrl: 'assets/images/avatar-default.png',
  );

  static Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _streamController;

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _streamController = controller;

    _updateUser(_defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;

    _streamController?.add(_currentUser);
  }

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
      String name, String email, String password, File? image) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar-default.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }
}
