import 'package:chat_e/components/message_bubble.dart';
import 'package:chat_e/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText;
  User loggedInUser;
  bool isMe;

  final messageTextController = TextEditingController();

  void getUser() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        loggedInUser = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: kPrimaryColor,
        title: Text('Chat Room'),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: SpinKitDoubleBounce(
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                }
                List<MessageBubble> messageWidgets = [];
                final messages = snapshot.data.docs.reversed;
                for (var message in messages) {
                  final messageSender = message.get('sender');
                  final messageText = message.get('message');

                  isMe = (loggedInUser.email == messageSender);
                  // if (loggedInUser.email == messageSender) {
                  //   isMe = true;
                  // }

                  final messageWidget = MessageBubble(
                    messageSender: messageSender,
                    messageText: messageText,
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    bubbleColor: isMe ? kPrimaryColor : kSecondaryColor,
                    textColor: Colors.white,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender': loggedInUser.email,
                          'message': value,
                          'timestamp': FieldValue.serverTimestamp()
                        });
                      },
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        hintText: 'Enter a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Send',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    ),
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'sender': loggedInUser.email,
                        'message': messageText,
                        'timestamp': FieldValue.serverTimestamp()
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
