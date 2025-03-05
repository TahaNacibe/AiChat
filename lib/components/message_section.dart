import 'package:eva/components/loading_chat.dart';
import 'package:eva/models/message.dart';
import 'package:eva/utils/date_formater.dart';
import 'package:flutter/material.dart';

class MessageBody extends StatefulWidget {
  final List<Message> messagesList;
  final bool isWaitingResponse;
  const MessageBody({
    super.key,
    required this.messagesList,
    required this.isWaitingResponse,
  });

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  ScrollController listController = ScrollController();
  double bottomPadding = 45;

  @override
  void didUpdateWidget(covariant MessageBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Ensure scrolling occurs after the new message is added
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isWaitingResponse ||
          widget.messagesList.length > oldWidget.messagesList.length) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    if (listController.hasClients) {
      listController.animateTo(
        listController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int listLength =
        widget.messagesList.length + (widget.isWaitingResponse ? 1 : 0);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: bottomPadding),
      controller: listController,
      itemCount: listLength,
      itemBuilder: (context, index) {
        if (widget.isWaitingResponse && index == listLength - 1) {
          return loadingChat();
        } else {
          return messageBody(widget.messagesList[index]);
        }
      },
    );
  }
}

//* message widget
Widget messageBody(Message message) {
  //* message border radius
  BorderRadiusGeometry messageBorderRadius =
      message.sender == "model"
          ? BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
          : BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          );

  //* message color
  Color messageColor =
      message.sender == "model" ? Colors.grey.shade500 : Colors.indigo.shade300;

  //* max width for messages
  double maxWidth = 250;

  //* manage the date display state
  bool isDateShowing = false;

  Widget dateOfMessage() {
    if (isDateShowing) {
      return Text(
        formatDate(message.sendDate!),
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
      );
    } else {
      return SizedBox.square();
    }
  }

  //* ui tree
  return StatefulBuilder(
    builder: (context, setState) {
      return Align(
        alignment:
            message.sender == "model"
                ? Alignment.centerLeft
                : Alignment.centerRight,
        child: GestureDetector(
          onTap:
              () => {
                setState(() {
                  isDateShowing = !isDateShowing;
                }),
              },
          child: Column(
            children: [
              dateOfMessage(),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: messageBorderRadius,
                    color: messageColor,
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
