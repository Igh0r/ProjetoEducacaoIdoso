class AssistantResponse {
  const AssistantResponse({required this.answer, this.policyVersion});
  final String answer;
  final String? policyVersion;

  factory AssistantResponse.fromJson(Map<String, Object?> json) {
    final answer = json['answer'];
    final policyVersion = json['policyVersion'];
    return AssistantResponse(answer: answer is String ? answer : '', policyVersion: policyVersion is String ? policyVersion : null);
  }
}
