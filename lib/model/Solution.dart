import 'package:equatable/equatable.dart';
import 'package:treninoo/model/TrainSolution.dart';

class Solution extends Equatable {
  final List<TrainSolution> trains;
  final double? price;

  Solution({
    required this.trains,
    required this.price,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      trains: (json['trains'] as List)
          .map((f) => TrainSolution.fromJson(f))
          .toList(),
      price: json['price'] != null
          ? num.parse("${json['price']}").toDouble()
          : null,
    );
  }

  @override
  List<Object?> get props => [trains];
}
