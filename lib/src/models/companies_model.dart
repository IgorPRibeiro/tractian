import 'package:equatable/equatable.dart';

class CompaniesModel extends Equatable {
  final String name;
  final String id;

  const CompaniesModel({
    required this.name, 
    required this.id
  });

  factory CompaniesModel.init() {
    return const CompaniesModel(name: '', id: '');
  }

  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      name: json['name'] as String,
      id: json['id'] as String,
    );
  }

  @override
  List<Object?> get props => [name, id];

}