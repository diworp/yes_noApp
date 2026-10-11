import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/_my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message.dart';
import 'package:yes_no_app/presentation/widgets/chat/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://www.activision.com/content/dam/atvi/callofduty/cod-touchui/warzone/common/wz-boxart.jpg',
            ),
          ),
        ),
        title: const Text('Toxic Squad'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messageList[index];
                  return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble(message : message)
                      : MyMessageBubble(message: message);
                },
              ),
            ),
            SizedBox(height: 25),
            MessageFieldBox(
              onValue:chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

extension on T Function<T>() {
  void operator <(ChatProvider other) {}
}
