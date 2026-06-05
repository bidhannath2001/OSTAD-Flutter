import 'package:chatbot/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.role, required super.text, required super.time});
  Map<String, String>toApi()=>{
    'role': role,
    'content':text,
  };
}