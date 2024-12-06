import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaosity_app/models/comment_model.dart';
import 'package:kaosity_app/models/voting_model.dart';
import 'package:kaosity_app/utils/app_colors.dart';
import 'package:kaosity_app/utils/app_images.dart';
import 'package:kaosity_app/utils/const.dart';
import 'package:video_player/video_player.dart';

import '../../../services/websocket_services.dart';

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
  var timeLeft = 240.obs;
  var userAnswers = <String, String>{}.obs;
  var showSuccess = false.obs;
  var showFailure = false.obs;
  var showProgress = false.obs;
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, FocusNode> focusNodes = {};
  var showVoting = false.obs;
  var votingTimer = 106.obs;
  var showResults = false.obs;
  var votingOptions = <VotingOption>[].obs;
  var totalVotes = 0.obs;
  var showThirdPuzzle = false.obs;
  var showMemoryPuzzleStart = false.obs;
  var memorySequence = <int>[].obs;
  var userSequence = <int>[].obs;
  var roundNumber = 1.obs;
  var totalRounds = 3;
  var currentRoundSequenceIndex = 0.obs;
  var isUserTurn = false.obs;
  var highlightedTile = (-1).obs;
  var tileColors = [
    [kBlueShade6Color, kBlueShade7Color],
    [kYellowShadeColor, kYellowShade1Color],
    [kGreenShade6Color, kGreenShade7Color],
    [kPurpleShade1Color, kPurpleShade2Color]
  ];
  var puzzleTimer = 124.obs;
  var puzzleTimerRunning = false.obs;
  var showPuzzleSuccess = false.obs;
  var showPuzzleFailure = false.obs;
  var userFailed = false.obs;
  var showMemoryProgress = false.obs;
  var fistPuzzleTrigger = false.obs;
  var secondPuzzleTrigger = false.obs;
  var thirdPuzzleTrigger = false.obs;

  // Comments
  var comments = <Comment>[].obs;
  final TextEditingController commentController = TextEditingController();
  final List<Color> nameColors = [kGreenShadeColor, kBlueShadeColor, kRedShadeColor];
  final List<String> icons = [kStatus1Icon, kStatus2Icon, kStatusIcon];
  int _currentColorIndex = 0;
  int _currentIconIndex = 0;

  var currentPosition = Duration.zero.obs;

  @override
  void onInit() async{
    super.onInit();
    
    initializeVideo();
    
    // _listenForMessages();

    

    votingOptions.addAll([
      VotingOption(
        name: "Ben",
        image: kUser1,
        percentage: 23.obs,
        isSelected: false.obs,
      ),
      VotingOption(
        name: "Courtney",
        image: kUser2,
        percentage: 89.obs,
        isSelected: false.obs,
      ),
      VotingOption(
        name: "Lisa",
        image: kUser3,
        percentage: 12.obs,
        isSelected: false.obs,
      ),
      VotingOption(
        name: "Adam",
        image: kUser4,
        percentage: 12.obs,
        isSelected: false.obs,
      ),
    ]);
  }
  void _listenForMessages() {
    WebSocketService().socket?.on('messageRecieved', (data) {
      if (data != null && data is Map<String, dynamic>) {
        addReceivedMessage(data);
      }
    });
  }

  void addReceivedMessage(Map<String, dynamic> data) {
    final comment = Comment(
      username: data['name'],
      message: data['text'],
      icon: icons[_currentIconIndex],
      nameColor: nameColors[_currentColorIndex],
    );

    comments.add(comment);
    _currentColorIndex = (_currentColorIndex + 1) % nameColors.length;
    _currentIconIndex = (_currentIconIndex + 1) % icons.length;
  }

  void initializeVideo() {
  videoController = VideoPlayerController.networkUrl(
    Uri.parse('$video_url/user${GetStorage().read('path')}'),
  )..initialize().then((_) {
      update();
    });

  videoController.addListener(() {
    currentPosition.value = videoController.value.position;

    // Crossword Puzzle Logic
    if (currentPosition.value >= const Duration(seconds: 33) &&
        currentPosition.value < const Duration(seconds: 250) &&
        !isEnabled.value) {
      _startPuzzleLogic();
    }

    if (currentPosition.value >= const Duration(seconds: 250) &&
        currentPosition.value < const Duration(seconds: 267) &&
        !fistPuzzleTrigger.value) {
      fistPuzzleTrigger.value = true;
      if (showPuzzleStart.value) {
        showPuzzleStart.value = false;
      } else if (isPuzzleActive.value) {
        showFailure.value = true;
      }
    }

    // Puzzle 2 - Choose A Person
    if (currentPosition.value >= const Duration(seconds: 284) &&
        currentPosition.value <= const Duration(seconds: 390) &&
        !secondPuzzleTrigger.value) {
      secondPuzzleTrigger.value = true;
      showProgress.value = false;
      showVoting.value = true;
      _startVotingTimer();
    }

    // Puzzle 3 - Memory Game
    if (currentPosition.value >= const Duration(seconds: 814) &&
        currentPosition.value < const Duration(seconds: 874) &&
        !thirdPuzzleTrigger.value) {
      thirdPuzzleTrigger.value = true;
      showMemoryPuzzleStart.value = true;
    }

    if (currentPosition.value >= const Duration(seconds: 874) &&
        currentPosition.value <= const Duration(seconds: 938) &&
        !thirdPuzzleTrigger.value) {
      thirdPuzzleTrigger.value = true;
      showMemoryPuzzleStart.value = true;
    }

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
    timeLeft.value = 240;
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

  void _startPuzzleLogic() {
    Future.delayed(const Duration(seconds: 0), () {
      Timer(const Duration(seconds: 1), () {
        isEnabled.value = true;
        Timer(const Duration(seconds: 1), () {
          isChallengeActive.value = true;
          showPuzzleStart.value = true;
        });
      });
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
      '0-1': 'J', '1-1': 'L', // JLO (1 Down)
      '0-3': 'T', '1-3': 'H', '2-3': 'I', '3-3': 'R', '4-3': 'T',
      '5-3': 'Y', '6-3': 'S', '7-3': 'I', '8-3': 'X', // THIRTYSIX (2 Down)
      '3-5': 'J', '4-5': 'A', '5-5': 'W', '6-5': 'S', // JAWS (3 Down)
      '2-0': 'M', '2-1': 'O', '2-2': 'N', '2-4': 'C',
      '2-5': 'A', // MONICA (4 Across)
      '4-0': 'T', '4-1': 'A', '4-2': 'F', '4-4': 'T', // TAFT (5 Across)
      '7-2': 'M', '7-4': 'I', '7-5': 'C', '7-6': 'H', '7-7': 'E',
      '7-8': 'L', // MICHELE (6 Across)
    };

    bool allCorrect = correctAnswers.entries.every((entry) {
      return userAnswers[entry.key]?.toUpperCase() == entry.value;
    });

    if (allCorrect) {
      puzzleCompleted.value = true;
      timerRunning.value = false;
      showSuccess.value = true;
    } else if (timeLeft.value == 0) {
      showFailure.value = true;
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

  void _startVotingTimer() {
    timerRunning.value = true;
    votingTimer.value = 106;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (votingTimer.value > 0) {
        votingTimer.value--;
      } else {
        timer.cancel();
        timerRunning.value = false;
        showVoting.value = false;
        showResults.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          showResults.value = false;
          showMemoryPuzzleStart.value = true;
        });
      }
    });
  }

  void voteForOption(VotingOption option) {
    for (var opt in votingOptions) {
      opt.isSelected.value = false;
    }

    option.isSelected.value = true;

    totalVotes.value++;
  }

  void startMemoryPuzzle() async {
    resetPuzzleState();
    _startPuzzleTimer();

    isUserTurn.value = false;
    highlightedTile.value = -1;

    for (int i = 0; i < 4; i++) {
      userSequence.add(i);
    }

    await Future.delayed(const Duration(seconds: 3), () {
      userSequence.clear();
      highlightedTile.value = -1;
    });

    Future.delayed(const Duration(milliseconds: 500), _startRound);
  }

  void _startPuzzleTimer() {
    puzzleTimerRunning.value = true;
    puzzleTimer.value = 124;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (puzzleTimer.value <= 0 || !puzzleTimerRunning.value) {
        timer.cancel();
        _endPuzzle(success: false);
      } else {
        puzzleTimer.value--;
      }
    });
  }

  final List<List<int>> predefinedSequences = [
    [2, 3, 1, 0], // Sequence for round 1
    [1, 0, 3, 2], // Sequence for round 2
    [0, 1, 3, 2], // Sequence for round 3
  ];

  void _startRound() {
    memorySequence.clear();
    userSequence.clear();
    currentRoundSequenceIndex.value = 0;
    isUserTurn.value = false;

    for (int i = 0; i < 4; i++) {
      memorySequence.add(predefinedSequences[roundNumber.value - 1][i]);
    }

    _showSequence();
  }

  void _showSequence() async {
    isUserTurn.value = false;
    highlightedTile.value = -1;

    for (int i = 0; i < memorySequence.length; i++) {
      highlightedTile.value = memorySequence[i];
      await Future.delayed(const Duration(seconds: 1));
      highlightedTile.value = -1;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    isUserTurn.value = true;
  }

  void submitTile(int tileIndex) {
    if (!isUserTurn.value) return;

    if (!userSequence.contains(tileIndex)) {
      userSequence.add(tileIndex);
    }

    highlightedTile.value = tileIndex;

    if (userSequence.length == memorySequence.length) {
      isUserTurn.value = false;
      Future.delayed(const Duration(milliseconds: 500), _checkUserSequence);
    }
  }

  void _checkUserSequence() {
    bool isCorrect = true;

    for (int i = 0; i < memorySequence.length; i++) {
      if (memorySequence[i] != userSequence[i]) {
        isCorrect = false;
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      userFailed.value = !isCorrect;

      if (isCorrect) {
        _onRoundSuccess();
      } else {
        _onRoundFailure();
      }
    });
  }

  void _onRoundSuccess() {
    if (roundNumber.value >= totalRounds) {
      _endPuzzle(success: true);
    } else {
      roundNumber.value++;
      Future.delayed(const Duration(seconds: 2), _startRound);
    }
  }

  void _onRoundFailure() {
    Future.delayed(const Duration(seconds: 2), _startRound);
  }

  void _endPuzzle({required bool success}) {
    isUserTurn.value = false;
    puzzleTimerRunning.value = false;
    showThirdPuzzle.value = false;
    showPuzzleSuccess.value = success;
    showPuzzleFailure.value = !success;
    showMemoryProgress.value = true;

    Future.delayed(const Duration(seconds: 2), resetPuzzleState);
  }

  void resetPuzzleState() {
    roundNumber.value = 1;
    memorySequence.clear();
    userSequence.clear();
    highlightedTile.value = -1;
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}
