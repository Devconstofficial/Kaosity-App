import 'dart:developer';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get_storage/get_storage.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  ViewVideoController controller = Get.put(ViewVideoController());

  WebSocketService._internal();

  IO.Socket? _socket;
  final String _url = "http://192.168.1.2:3000";
  //15.235.208.156:3000 hosted socket url
  IO.Socket? get socket => _socket;

  bool get isConnected => _socket != null && _socket!.connected;

  Future<void> connect() async {
    if (_socket != null && _socket!.connected) {
      log("WebSocket is already connected.");
      return;
    }

    try {
      final String? authToken = GetStorage().read('authToken');
      if (authToken == null || authToken.isEmpty) {
        log("Auth token is missing. Please log in.");
        return;
      }

      _socket = IO.io(
        _url,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'accesstoken': authToken}) 
            .build(),
      );

      _socket!.on('connect', (_) {
        log("WebSocket connected to $_url");
      });

      _socket!.on('disconnect', (_) {
        log("WebSocket connection closed.");
      });

      _socket!.on('error', (error) {
        log("WebSocket error: $error");
      });

     
      _socket!.on('messageRecieved', (data) {
        controller.addReceivedMessage(data);
        log("Message received: $data");
        // log('added');
      });

      _socket!.on('userJoined', (data) {
        log("User joined: $data");
      
      });

      _socket!.on('error', (data) {
        log("Error received: $data");
        
      });
    } catch (e) {
      log("Failed to connect to WebSocket: $e");
    }
  }

  void joinLiveChat(String videoId) {
    if (!isConnected) {
      log("WebSocket is not connected. Cannot join live chat.");
      return;
    }

    try {
      _socket!.emit('joinLiveChat', {'videoId': videoId});
      log("Emitted joinLiveChat with videoId: $videoId");
    } catch (e) {
      log("Failed to emit joinLiveChat: $e");
    }
  }

  void sendMessage(String text) {
    if (!isConnected) {
      log("WebSocket is not connected. Cannot send message.");
      return;
    }

    try {
      _socket!.emit('sendMessage', {'text': text});
      log("Emitted sendMessage with text: $text");
    } catch (e) {
      log("Failed to emit sendMessage: $e");
    }
  }

  void leaveLiveChat() {
    if (!isConnected) {
      log("WebSocket is not connected. Cannot leave live chat.");
      return;
    }

    try {
      _socket!.emit('leaveLiveChat');
      log("Emitted leaveLiveChat.");
    } catch (e) {
      log("Failed to emit leaveLiveChat: $e");
    }
  }

  void disconnect() {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
      log("WebSocket disconnected.");
    }
  }
}
