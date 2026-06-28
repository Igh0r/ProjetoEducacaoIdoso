class AppConfig {
  const AppConfig({
    required this.assistantApiBaseUrl,
    required this.assistantChatPath,
    required this.assistantTimeout,
    required this.appVersion,
    required this.environmentName,
  });

  factory AppConfig.fromEnvironment() => const AppConfig(
        assistantApiBaseUrl: String.fromEnvironment('ASSISTANT_API_BASE_URL'),
        assistantChatPath: String.fromEnvironment('ASSISTANT_CHAT_PATH', defaultValue: '/assistant/chat'),
        assistantTimeout: Duration(seconds: int.fromEnvironment('ASSISTANT_TIMEOUT_SECONDS', defaultValue: 20)),
        appVersion: String.fromEnvironment('APP_VERSION', defaultValue: '1.0.0'),
        environmentName: String.fromEnvironment('APP_ENVIRONMENT', defaultValue: 'development'),
      );

  final String assistantApiBaseUrl;
  final String assistantChatPath;
  final Duration assistantTimeout;
  final String appVersion;
  final String environmentName;

  bool get hasRemoteAssistant => assistantApiBaseUrl.trim().isNotEmpty;

  Uri assistantChatUri() {
    final base = Uri.parse(assistantApiBaseUrl.trim());
    final path = assistantChatPath.startsWith('/') ? assistantChatPath : '/$assistantChatPath';
    return base.replace(path: path);
  }
}

const appConfig = AppConfig.fromEnvironment();
