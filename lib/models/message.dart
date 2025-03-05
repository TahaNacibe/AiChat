class Message {
  String sender;
  String message;
  DateTime? sendDate;
  
  Message({
    required this.sender,
    required this.message,
    this.sendDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      message: json['message'],
      sendDate: DateTime.parse(json['sendDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
      'sendDate':sendDate?.toIso8601String(),
    };
  }
}
