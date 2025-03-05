import 'package:eva/components/chat_app_bar.dart';
import 'package:eva/components/message_section.dart';
import 'package:eva/models/message.dart';
import 'package:eva/services/api.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messagesList = [];
  bool isWaitingResponse = false;
  String _memory = "";
  final TextEditingController _messageController = TextEditingController();

  //* functions
  Future<void> sendMessageToTheApi() async {
    if (_messageController.text.isNotEmpty) {
      //* create the message
      setState(() {
        Message userMessage = Message(
          message: _messageController.text,
          sender: "user",
          sendDate: DateTime.now(),
        );
        messagesList.add(userMessage);
        isWaitingResponse = true;
      });

      //* send the message
      Map<String, dynamic> res = await requestResponseFromApi(
        _messageController.text,
        _memory,
      );
      _messageController.clear();
      setState(() {
        if (res["success"]) {
          messagesList.add(res["message"]["messageContent"]);
          if (res["message"]["memoryUpdate"] != "None") {
            _memory += res["message"]["memoryUpdate"];
          }
        }
        isWaitingResponse = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatPageAppBar(null, "taha"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //* Messages container
          MessageBody(
            messagesList: messagesList,
            isWaitingResponse: isWaitingResponse,
          ),
          //* Input and messages felid
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),

                //* Send button
                suffix: GestureDetector(
                  onTap: () async => {sendMessageToTheApi()},
                  child: Icon(
                    Ionicons.send,
                    color: Colors.indigo.shade400,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
