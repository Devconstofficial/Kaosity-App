import 'dart:async'; // Import this package for Timer

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/models/comment_model.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:video_player/video_player.dart';

class ViewVideoController extends GetxController {
  // Video Controller
  late VideoPlayerController videoController;
  var isPlaying = false.obs;
  var isFullScreen = false.obs;
  var isSmallVideo = false.obs;

  // Puzzle
  var isEnabled = false.obs;
  var isExpanded = false.obs;
  var isChallengeActive = false.obs;
  var isPuzzleActive = false.obs;
  var showPuzzleStart = false.obs;
  var puzzleCompleted = false.obs;
  var timerRunning = false.obs;
  var timeLeft = 600.obs;
  var userAnswers = <String, String>{}.obs;
  var showSuccess = false.obs;
  var showFailure = false.obs;
  var showProgress = false.obs;
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, FocusNode> focusNodes = {};

  // Comments
  var comments = <Comment>[].obs;
  final TextEditingController commentController = TextEditingController();

  var currentPosition = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    initializeVideo();

    comments.addAll([
      Comment(
          username: "Alice",
          message: "Great video!",
          icon: kStatusIcon,
          nameColor: kGreenShadeColor),
      Comment(
          username: "Bob",
          message: "Interesting topic!",
          icon: kStatus1Icon,
          nameColor: kBlueShadeColor),
      Comment(
          username: "Charlie",
          message: "Loved it! Keep it up!",
          icon: kStatus2Icon,
          nameColor: kRedShadeColor),
    ]);
    Future.delayed(const Duration(seconds: 3), () {
      Timer(const Duration(seconds: 4), () {
        isEnabled.value = true;
        Timer(const Duration(seconds: 3), () {
          isChallengeActive.value = true;
        });
      });
    });
  }

  void initializeVideo() {
    videoController = VideoPlayerController.asset(
      'assets/video.mp4',
    )..initialize().then((_) {
        update();
      });

    videoController.addListener(() {
      currentPosition.value = videoController.value.position;

      if (videoController.value.position >= videoController.value.duration) {
        isPlaying.value = false;
        videoController.seekTo(Duration.zero);
      }

      update();
    });
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
      isPlaying.value = false;
    } else {
      videoController.play();
      isPlaying.value = true;
    }
  }

  void togglePuzzle() {
    isPuzzleActive.value = true;
    showPuzzleStart.value = false;
    if (isPuzzleActive.value) startTimer();
  }

  void startTimer() {
    timerRunning.value = true;
    timeLeft.value = 600;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!timerRunning.value) {
        timer.cancel();
      } else if (timeLeft.value > 0) {
        timeLeft.value--;
        if (timeLeft.value == 0) {
          timer.cancel();
          checkPuzzleCompletion();
        }
      }
    });
  }

  void runRemainingTimer() {
    timerRunning.value = true;
    timeLeft.value = timeLeft.value;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!timerRunning.value) {
        timer.cancel();
      } else if (timeLeft.value > 0) {
        timeLeft.value--;
        if (timeLeft.value == 0) {
          timer.cancel();
        }
      }
    });
  }

  void submitAnswer(String clue, String answer) {
    userAnswers[clue] = answer;

    checkPuzzleCompletion();
  }

  void checkPuzzleCompletion() {
    final correctAnswers = {
      '0-0': 'P', '0-1': 'H', '0-2': 'O', '0-3': 'N',
      '0-4': 'E', // PHONE (1 Down)
      '1-4': 'L', '2-4': 'E', '3-4': 'V', '4-4': 'E',
      '5-4': 'N', // ELEVEN (2 Down)
      '2-1': 'T', '2-2': 'A', '2-3': 'P', // TAPE (3 Down)
      '3-2': 'W', '3-3': 'A', '3-5': 'E', // WAVE (4 Across)
      '4-0': 'M', '4-1': 'O', '4-2': 'V', '4-3': 'I',
      '4-5': 'S', // MOVIES (5 Across)
      '5-2': 'P', '5-3': 'E' // PEN (6 Across)
    };

    bool allCorrect = correctAnswers.entries.every((entry) {
      return userAnswers[entry.key]?.toUpperCase() == entry.value;
    });

    if (allCorrect) {
      puzzleCompleted.value = true;
      timerRunning.value = false;
      showSuccess.value = true;
    } else if (timeLeft.value == 0) {
      showFailure.value = !allCorrect;
      showSuccess.value = allCorrect;
    }
  }

  void addComment() {
    if (commentController.text.isNotEmpty) {
      comments.add(Comment(
          username: "User",
          message: commentController.text,
          isUser: true,
          nameColor: kGreenShadeColor,
          icon: kStatusIcon));
      commentController.clear();
    }
  }

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;

    if (isFullScreen.value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  void toggleVideoSize() {
    isSmallVideo.value = true;
    Get.back();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}
