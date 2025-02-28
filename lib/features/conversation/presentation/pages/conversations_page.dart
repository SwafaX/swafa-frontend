import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:swafa_app_frontend/features/message/presentation/pages/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        )),
        child: BlocBuilder<ConversationsBloc, ConversationsState>(
          builder: (context, state) {
            if (state is ConversationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ConversationsLoaded) {
              return ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagePage(
                            conversationId: conversation.id,
                            receiver: conversation.participantName,
                          ),
                        ),
                      );
                    },
                    child: _buildMessageTile(
                      conversation.participantName,
                      conversation.lastMessage,
                      conversation.lastMessageTime.toString(),
                    ),
                  );
                },
              );
            } else if (state is ConversationsError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('No conversations found'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageTile(String name, String message, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            'https://i.pinimg.com/736x/bd/6b/82/bd6b82154b54c573b47be372c8c00d45.jpg'),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildRecentContact(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/2c/f1/0e/2cf10e90359b48d39cf4ea235e9e6591.jpg'),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
