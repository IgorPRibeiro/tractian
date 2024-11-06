import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const LocationModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory LocationModel.init() {
    return const LocationModel(name: '', id: '', parentId: null);
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      id: json['id'] as String,
      parentId: json['parentId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  @override
  List<Object?> get props => [name, id, parentId];
}
