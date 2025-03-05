import 'package:eva/utils/transform_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> requestResponseFromApi(
  String message,
  String memory,
) async {
  print("the message content are : ${message}");
  try {
    const String personality = "okey";
    String roleMessage =
        "you're $personality ${memory.isNotEmpty ? memory : ""} if you see an important detail or information in the convertion that need to be remembered then phrase it into a short sentence and return it in a separate part {message: message, memoryUpdate:memoryUpdate} always respond in json format";
    const apiKey = "";

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey",
    );

    //* get the request done
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "role": "model",
            "parts": [
              {"text": roleMessage},
            ],
          },
          {
            "role": "user",
            "parts": [
              {"text": message},
            ],
          },
        ],
      }),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic>? message = getMessageFromResponse(
        json.decode(res.body),
      );
      if (message != null) {
        return {"success": true, "message": message};
      } else {
        return {
          "success": false,
          "message": "failed to get the message instant",
        };
      }
    }

    return {"success": false, "message": "all process terminated with error"};
  } catch (e) {
    return {"success": false, "message": e.toString()};
  }
}
