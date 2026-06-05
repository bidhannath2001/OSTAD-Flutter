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
  static const String apiKey = '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';
  static const String baseUrl = 'https://openrouter.ai/api/v1';
  static const String model = 'google/gemini-3.1-flash-lite';
  static const String systemPrompt =
      'You are a helpful and friendly AI assistant.';

  // // Image Generation API
  // static const String imageGenApiKey =
  //     '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';
  // static const String imageGenBaseUrl = 'https://openrouter.ai/api/v1';
  // static const String imageGenModel = 'google/gemini-2.5-flash-image';
}