import 'dart:ui';

class Comment {
  final String username;
  final String icon;
  final String message;
  final bool isUser;
  final Color nameColor;

  Comment({
    required this.username,
    required this.message,
    this.isUser = false,
    required this.icon,
    required this.nameColor,
  });
}
