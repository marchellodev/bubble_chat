import 'package:bubble_chat/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:pusher_client/pusher_client.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String id;

  const ChatPage(this.id, {Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final _server = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b666669');
  // late IO.Socket socket;

  void load() {
    // showLoadingDialog(context);

    PusherOptions options = PusherOptions(
      cluster: 'eu',
    );

    PusherClient pusher = PusherClient(
        '0c57d77781b8ac392473',
        options,
        enableLogging: true,
        autoConnect: true
    );

    Channel channel = pusher.subscribe(widget.id);

    channel.bind("message-received", (PusherEvent? event) {
      print(event?.data);
    });

    // pusher.unsubscribe("private-orders");

    // pusher.connect();

    // socket = IO.io('wss://hack22.code.edu.eu.org/socket.io');
    // socket.onConnect((_) {
    //   Navigator.pop(context);
    //   socket.emit('init', widget.id);
    // });
    // socket.on('msg', (data) {
    //
    //   final textMessage2 = types.TextMessage(
    //     author: _server,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     id: const Uuid().v4(),
    //     text: data.toString(),
    //   );
    //
    //   _addMessage(textMessage2);
    // });
    // socket.onDisconnect((_) => showErrorDialog(context));
  }

  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      load();
    }.call();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    // socket.emit('msg', message.text);

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Chat',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Chat(
          messages: _messages,
          // onAttachmentPressed: _handleAtachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
    );
  }
}
