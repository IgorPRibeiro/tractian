import 'package:equatable/equatable.dart';

class AssetsModel extends Equatable {
  final String? gatewayId;
  final String id;
  final String? locationId;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  const AssetsModel({
    required this.gatewayId,
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'gatewayId': gatewayId,
      'id': id,
      'locationId': locationId,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory AssetsModel.fromJson(Map<String, dynamic> json) {
    return AssetsModel(
      name: json['name'] as String,
      id: json['id'] as String,
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
    name,
    id,
    gatewayId,
    locationId,
    name,
    parentId,
    sensorId,
    sensorType,
    status,
  ];
}
