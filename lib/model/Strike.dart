import 'package:equatable/equatable.dart';

class Strike extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final String? category;
  final String? where;

  Strike({
    this.startDate,
    this.endDate,
    this.description,
    this.category,
    this.where,
  });

  factory Strike.fromJson(Map<String, dynamic> json) {
    print(json);
    return Strike(
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'],
      category: json['category'],
      where: json['where'],
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        description,
        category,
        where,
      ];
}
