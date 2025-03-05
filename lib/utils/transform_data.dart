import 'dart:convert';

import 'package:eva/models/message.dart'; // Required for jsonDecode

Map<String, dynamic>? getMessageFromResponse(Map<String, dynamic> jsonData) {
  if (jsonData.isNotEmpty) {

    var contentParts = jsonData["candidates"][0]["content"]["parts"];
    if (contentParts.isNotEmpty) {
      dynamic textData = contentParts[0]["text"]; // Might be a String with ```json formatting

      // Clean up textData if it's a String with markdown formatting
      if (textData is String) {
        textData = textData.trim(); // Remove leading/trailing spaces
        if (textData.startsWith("```json")) {
          textData = textData.replaceAll("```json", "").replaceAll("```", "").trim();
        }

        try {
          textData = jsonDecode(textData); // Parse cleaned JSON string
        } catch (e) {
          return null;
        }
      }

      if (textData is Map<String, dynamic>) {
        // Extract values safely
        String message = textData["message"] ?? "No message found";
        String? memoryUpdate = textData["memoryUpdate"] ?? "None"; // Nullable

        return {
          "messageContent": Message(
            sender: "model",
            message: message,
            sendDate: DateTime.now(),
          ),
          "memoryUpdate": memoryUpdate,
        };
      } else {
        return null;
      }
    }
  }
  return null;
}
