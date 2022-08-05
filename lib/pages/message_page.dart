import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  static final routePage = '/message';
  @override
  State<MessagePage> createState() => _MessagePageState();
}

late User signInUser;
String? messageSend;

class _MessagePageState extends State<MessagePage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  //  getMasseges() async {
  //  await for(var snapchots in  _firestore.collection('messages').snapshots()){
  //     for(var message in snapchots.docs){
  //       print(message.data());
  //     }
  //   }
  // }
  final messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
        backgroundColor: Color(0xFFFFC107),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // delete();
              // setState(() {});
              _auth.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SnapData(firestore: _firestore),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messagecontroller,
                        onChanged: (value) {
                          messageSend = value;
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Cairo',
                            color: Color(0xFFFFC107),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFFC107),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: '   Message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Color(0xFFFFC107),
                      ),
                      onPressed: () {
                        messagecontroller.clear();
                        _firestore.collection('messages').add({
                          'text': messageSend,
                          'sender': signInUser.email,
                          'time': FieldValue.serverTimestamp(),
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void delete() async {
    await _firestore.collection('messages').get().then((value) {
      value.docs.forEach((element) {
        _firestore.collection('messages').doc(element.id).delete();
      });
    });
  }
}

class SnapData extends StatelessWidget {
  const SnapData({
    Key? key,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageDsign> messagesList = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFFFC107),
              ),
            );
          }
          final message = snapshot.data!.docs.reversed;
          for (var m in message) {
            final messageText = m.get('text');
            final messageSender = m.get('sender');

            final currentUser = signInUser.email;

            final messageWidget = MessageDsign(
              messageSender: messageSender,
              messageText: messageText,
              isMe: currentUser == messageSender,
            );
            messagesList.add(messageWidget);
          }
          return Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListView(
                reverse: true,
                children: messagesList,
              ),
            ),
          );
        });
  }
}

class MessageDsign extends StatelessWidget {
  const MessageDsign({
    Key? key,
    required this.messageSender,
    required this.messageText,
    required this.isMe,
  }) : super(key: key);

  final bool isMe;
  final String messageSender;
  final String messageText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Text('$messageSender'),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color:
                isMe ? Color(0xFFFFC107) : Color.fromARGB(255, 241, 241, 241),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$messageText',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Cairo',
                  color: Color.fromARGB(255, 37, 37, 37),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
