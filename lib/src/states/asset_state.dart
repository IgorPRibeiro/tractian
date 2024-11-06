import 'package:tractian/src/models/assets_model.dart';
import 'package:tractian/src/models/location_model.dart';

enum TypeFilter { energy, critic }

class LocationStateModel {
  final String name;
  final String id;
  final List<dynamic>? child;

  LocationStateModel({
    required this.name,
    this.child,
    required this.id,
  });

  factory LocationStateModel.fromJson(
      Map<String, dynamic> json, bool isLocation) {
    final locationName = json.keys.first;
    final locationData = json[locationName] as List;

    List<dynamic>? children;

    if (locationData.isNotEmpty) {
      children = locationData.map((itemJson) {
        if (isLocation) {
          return LocationModel.fromJson(itemJson);
        } else {
          return AssetsModel.fromJson(itemJson);
        }
      }).toList();
    }

    return LocationStateModel(
      name: locationName,
      child: children,
      id: locationName,
    );
  }
}

class AssetState {
  final String? search;
  final TypeFilter? typeFilter;
  final List<LocationStateModel>? locations;
  final List<Map<String, dynamic>>? renderList;
  final List<Map<String, dynamic>>? initialRenderList;



  AssetState({
    this.search,
    this.typeFilter,
    required this.locations,
    this.renderList,
    this.initialRenderList,

  });

  factory AssetState.init() {
    return AssetState(search: null, typeFilter: null, locations: const [], renderList: null, initialRenderList:null );
  }

  AssetState copyWith(
      {String? search,
      TypeFilter? typeFilter,
      List<LocationStateModel>? locations,
      List<Map<String, dynamic>>? renderList,
      List<Map<String, dynamic>>? initialRenderList

      }) {
    return AssetState(
        search: search ?? this.search,
        typeFilter: typeFilter == null ? null : typeFilter ?? this.typeFilter,
        locations: locations ?? this.locations,
        renderList: renderList ??  this.renderList,
        initialRenderList: initialRenderList ??  this.initialRenderList

    );
  }
}
