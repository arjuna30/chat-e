import 'package:chat_e/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageSender;
  final String messageText;
  final CrossAxisAlignment crossAxisAlignment;
  final Color bubbleColor;
  final Color textColor;
  final BorderRadius borderRadius;

  MessageBubble(
      {this.messageText,
      this.messageSender,
      this.crossAxisAlignment,
      this.bubbleColor,
      this.textColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(messageSender),
          Material(
            color: bubbleColor,
            elevation: 5.0,
            borderRadius: borderRadius,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Text(
                messageText,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
