class AppStrings {
  static const String appName = 'AI Chat Bot';
  static const String inputHint = 'Type a message...';
  static const String imageGenInputHint = 'Describe an image...';
  static const String emptyChat =
      'Start a conversation!\nSend a message below.';

  static const String errorNoInternet =
      'No internet connection. Please check and try again.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorGeneral = 'Something went wrong. Please try again.';

  // Chat API
  static const String apiKey = 'API KEY';
  static const String baseUrl = 'https://openrouter.ai/api/v1';
  static const String model = 'google/gemini-3.1-flash-lite';
  static const String systemPrompt =
      'You are a helpful and friendly AI assistant.';

}