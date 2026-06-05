import 'package:chatbot/presentation/screen/widgets/chat_input_field.dart';
import 'package:chatbot/presentation/screen/widgets/empty_chat.dart';
import 'package:chatbot/presentation/screen/widgets/message_bubble.dart';
import 'package:chatbot/presentation/screen/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom(){
    if(_scrollController.hasClients){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(microseconds: 300), curve: Curves.easeOut);
    }
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final provider = context.read<ChatProvider>();
    provider.addListener((){
      WidgetsBinding.instance.addPostFrameCallback((_){
        _scrollToBottom();
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 12,
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(color: Colors.white, shape: .circle),
              child: Icon(
                Icons.smart_toy_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            Text(
              AppStrings.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                  SizedBox(width: 4),
                Text('Online', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Consumer<ChatProvider>(
        builder: (context,provider,child) {
          return Column(
            children: [
              Expanded(
                child: provider.messages.isEmpty && !provider.isLoading? EmptyChat(): ListView.builder(
                  controller: _scrollController,
                    itemCount: provider.messages.length + (provider.isLoading?1:0),
                    itemBuilder: (context,index){
                      if(index == provider.messages.length){
                        return TypingIndicator();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MessageBubble(message: provider.messages[index]),
                      );
                    }),
              ),
              ChatInputField(onSend: provider.sendMessage, isLoading: provider.isLoading),
            ],
          );
        }
      ),
    );
  }
}
