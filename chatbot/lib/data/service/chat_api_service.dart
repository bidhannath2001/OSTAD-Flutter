import 'dart:convert';

import 'package:chatbot/core/constants/app_strings.dart';
import 'package:chatbot/data/model/message_model.dart';
import 'package:http/http.dart' as http;

class ChatApiService {
  Future<String> fetchAssistantReply(List<MessageModel> message) async {
    final response = await http
        .post(
          Uri.parse('${AppStrings.baseUrl}/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppStrings.apiKey}',
          },
          body: jsonEncode({
            'model': AppStrings.model,
            'max_tokens': 1024,
            'messages': [
              {"role": "system", "content": AppStrings.systemPrompt},
              ...message.map((m) => m.toApi()),
            ],
          }),
        )
        .timeout(Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch assistant reply: ${response.statusCode}',
      );
    }
    final data = jsonDecode(response.body);
    return (data['choices'][0]['message']['content'] as String).trim();
  }
}
