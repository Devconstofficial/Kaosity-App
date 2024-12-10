import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kaosity_app/utils/const.dart';

import '../../../services/websocket_services.dart';
import '../../../utils/app_colors.dart';

class VideoService {
  final box = GetStorage();


  Future<List<dynamic>> fetchVideos() async {
  try {
    
    const url = '$server_url/user/videos';
    final authToken = box.read<String?>('authToken');
    final headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };
    log('Fetching videos from: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    log('Response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['videos'];
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (e) {
    log('Error fetching videos: $e');
    throw Exception('Error fetching videos: $e');
  }
}

Future<void> voteParticipant(String videoId, String participantId) async {
    try {
      
      final url = '$server_url/user/videos/$videoId/vote';
      final authToken = box.read<String?>('authToken');
      final headers = {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      };

      final body = json.encode({'participantId': participantId});
      log('Voting for participant at: $url');
      final response = await http.put(Uri.parse(url), headers: headers, body: body);

      log('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('Vote successful: ${data['message']}');
        Get.snackbar("Success", "Congratulations, you've voted successfully!!",
            backgroundColor: kWhiteColor, colorText: kBlackColor);
      } else if (response.statusCode == 409) {
        throw Exception('You have already voted for this video.');

      } else {
        throw Exception('Failed to vote: ${response.body}');
      }
    } catch (e) {
      log('Error voting for participant: $e');
      throw Exception('Error voting for participant: $e');
    }
  }

}
