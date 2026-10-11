import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final getYesNoAnswer = GetYesNoAnswer();
  final chatScrollController = ScrollController();

  List<Message> messageList = [
    Message(text: 'Hola amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();

    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBOttom();
  }

  Future<void> sendMessage(String text) async {
    if (text.length == 0) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();
    moveScrollToBOttom();
  }

  Future<void> moveScrollToBOttom() async {
    await Future.delayed(const Duration(milliseconds: 300));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
