import 'dart:async';
import 'dart:io';

import 'package:chatbot/core/constants/app_strings.dart';
import 'package:flutter/widgets.dart';

import '../../data/model/message_model.dart';
import '../../data/service/chat_api_service.dart';

class ChatProvider extends ChangeNotifier{

  ChatProvider({required ChatApiService apiService}): _apiService = apiService;

  final ChatApiService _apiService;
  final List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void>sendMessage(String text)async{
    if(text.trim().isEmpty) return;
    _messages.add(MessageModel(role: 'user', text: text, time: DateTime.now()));
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final replyText = await _apiService.fetchAssistantReply(_messages);

    try{
      _messages.add(MessageModel(role: 'assistant', text: replyText, time: DateTime.now()));
    }on TimeoutException catch(e){
      _errorMessage = AppStrings.errorTimeout;
    }on SocketException catch(e) {
      _errorMessage = AppStrings.errorNoInternet;
    }catch(e,stack){
      _errorMessage = AppStrings.errorGeneral;
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat(){
    _messages.clear();
    _errorMessage = null;
    notifyListeners();
  }
}