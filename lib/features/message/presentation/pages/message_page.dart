import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_bloc.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_event.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessagePage extends StatefulWidget {
  final String conversationId;
  final String receiver;
  const MessagePage(
      {super.key, required this.conversationId, required this.receiver});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  String userId = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageBloc>(context)
        .add(LoadMessagesEvent(conversationId: widget.conversationId));
    fetchUserId();
  }

  void fetchUserId() async {
    userId = await _storage.read(key: 'accessToken') ?? '';
    setState(() {
      userId = userId;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      BlocProvider.of<MessageBloc>(context).add(
        SendMessageEvent(
          conversationId: widget.conversationId,
          content: content,
        ),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/bd/6b/82/bd6b82154b54c573b47be372c8c00d45.jpg',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.receiver,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MessageLoadedState) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isSentMessage = message.senderId == userId;
                      if (isSentMessage) {
                        print('hello 1 - ${userId}');
                        return _buildSentMessage(context, message.content);
                      } else {
                        print('hello 2 - ${userId}');
                        return _buildReceivedMessage(context, message.content);
                      }
                    },
                  );
                } else if (state is MessageErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const Center(
                  child: Text('No messages found'),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: DefaultColors.secondary500,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: DefaultColors.primary500,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
