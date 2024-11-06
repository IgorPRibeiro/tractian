import 'package:flutter/material.dart';
import 'package:tractian/src/models/assets_model.dart';
import 'package:tractian/src/models/location_model.dart';
import 'package:tractian/src/repository/asset_repository.dart';
import 'package:tractian/src/repository/location_repository.dart';
import 'package:tractian/src/states/asset_state.dart';

class Asset {
  final String name;
  final String id;
  final List<Asset> child;

  Asset({
    required this.name,
    required this.id,
    required this.child,
  });
}

class AssetsStore extends ValueNotifier<AssetState> {
  AssetsStore() : super(AssetState.init());
  final assetsRepository = AssetRepository();
  final locationRepository = LocationRepository();

  Future<List<Map<String, dynamic>>> getGeralDataAsset(String idCompanies) async {
    final listLocations = await locationRepository.getLocations(idCompanies);
    final listAssets = await assetsRepository.getAssets(idCompanies);
    var assets = assetsFormat(listAssets);
    var locations = locationsFormat(assets, listLocations);
    value = value.copyWith(renderList: locations);
    return locations;
  }

  List<Map<String, dynamic>> locationsFormat(
      List<Map<String, dynamic>> assetsArray, List<LocationModel> locationsArray) {
    final List<Map<String, dynamic>> showAssets = locationsArray.map((item) {

      var assetLocation = assetsArray.firstWhere(
            (i) => i['locationId'] == item.id,
        orElse: () => {
          'gatewayId': null,
          'id': '',
          'locationId': null,
          'name': '',
          'parentId': null,
          'sensorId': null,
          'sensorType': null,
          'status': null,
          'child': [],
        },
      );


      final hasValidAsset = assetLocation['id'] != null && assetLocation['id']!.isNotEmpty;


      return {
        ...item.toMap(),
        'isLocation': true,
        'child': hasValidAsset ? [assetLocation] : []
      };
    }).toList();


    final List<Map<String, dynamic>> realLocations = showAssets.where(
          (item) => item['parentId'] == null,
    ).toList();


    final List<Map<String, dynamic>> finish = realLocations.map((item) {
      var childLocations = showAssets.where((i) => i['parentId'] == item['id']).toList();


      return {
        ...item,
        'child': childLocations.isNotEmpty ? childLocations : (item['child'] ?? []),
      };
    }).toList();


    return finish;
  }




  List<Map<String, dynamic>> assetsFormat(List<AssetsModel> assets) {
    final assetsWithLocations =
    assets.where((item) => item.locationId != null).toList();

    final assetsWithParents =
    assets.where((item) => item.parentId != null).toList();

    final assetsWithoutLocations =
    assets.where((item) => item.locationId == null).toList();

    List<Map<String, dynamic>> arraAssetsFormatado3 = [];

    for (var item in assetsWithoutLocations) {
      var exclusiveAssets = assetsWithParents.firstWhere(
            (i) => i.parentId == item.id,
        orElse: () => const AssetsModel(
          gatewayId: null,
          id: '',
          locationId: null,
          name: '',
          parentId: null,
          sensorId: null,
          sensorType: null,
          status: null,
        ),
      );

      if (exclusiveAssets.id.isNotEmpty) {
        var childArray = (arraAssetsFormatado3.firstWhere(
              (c) => c['id'] == exclusiveAssets.id,
          orElse: () => {'child': []},
        )['child'] as List)
          ..add(item.toMap());

        arraAssetsFormatado3.add({...exclusiveAssets.toMap(), 'child': childArray});
      } else {
        arraAssetsFormatado3.add({...item.toMap(), 'child': []});
      }
    }


    final assetsLocation = assetsWithLocations.map((item) {
      return {...item.toMap(), 'child': []};
    }).toList();

    final filteredLocations = assetsLocation.map((item) {
      var ch = arraAssetsFormatado3.where((i) => i['parentId'] == item['id']).toList();

      if (ch.isNotEmpty) {
        return {...item, 'child': ch};
      } else {
        var c = arraAssetsFormatado3.where((i) => i['parentId'] == null).toList();
        return c.isNotEmpty ? {...item, 'child': c} : item;
      }
    }).toList();

    return filteredLocations.toList();
  }


}
