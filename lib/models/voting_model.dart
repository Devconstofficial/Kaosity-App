import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VotingOption {
  final String name;
  final String image;
  RxInt percentage;
  RxBool isSelected;

  VotingOption({
    required this.name,
    required this.image,
    required this.percentage,
    required this.isSelected,
  });
}
