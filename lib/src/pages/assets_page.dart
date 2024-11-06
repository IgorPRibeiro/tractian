import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian/src/stores/assets_store.dart';

class ScreenArguments {
  final String idCompanies;

  ScreenArguments(this.idCompanies);
}

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  static const routeName = '/assets';

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  ScreenArguments? args;
  final store = AssetsStore();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    store.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (args == null) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments;
      if (routeArgs is ScreenArguments) {
        args = routeArgs;
        store.getGeralDataAsset(args!.idCompanies);
      }
    }
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    store.removeListener(_listener);
    super.dispose();
  }

  Widget _buildAssetTree(List<dynamic> assets) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return _buildAssetItem(asset);
      },
    );
  }

  Widget _buildAssetItem(dynamic asset, {double indent = 0}) {
    final children = asset['child'];
    List<dynamic> childrenList = [];

    if (children is List) {
      childrenList = children;
    } else if (children is Map) {
      childrenList = [children];
    }

    final icon = asset['isLocation'] == true
        ? SvgPicture.asset('assets/svgs/location.svg')
        : asset['sensorId'] != null
            ? SvgPicture.asset('assets/svgs/codepen.svg')
            : SvgPicture.asset('assets/svgs/cube.svg');

    final iconStatus;
    if (asset.containsKey('status') && asset['status'] != null) {
      iconStatus = asset['status'] == "operating"
          ? SvgPicture.asset('assets/svgs/bolt.svg')
          : SvgPicture.asset('assets/svgs/ellipse.svg');
    } else {
      iconStatus = SizedBox(width: 8);
    }


    List<Widget> itemList = [
      Padding(
        padding: EdgeInsets.fromLTRB(indent, 6, 0, 6),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                asset['name'] ?? 'Sem nome',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 8),
            iconStatus
          ],
        ),
      ),
    ];

    for (var child in childrenList) {
      itemList.add(_buildAssetItem(child, indent: indent + 12));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: itemList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Muda a cor do ícone
        ),
        title: const Text(
          'Assets',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(23, 25, 45, 1),
      ),
      body: store.value?.renderList == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Buscar Ativo ou Local',
                        fillColor: const Color.fromRGBO(234, 239, 243, 1),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/search.svg',
                            height: 12,
                            width: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: 200, // Defina a largura do botão
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 6, 0, 6),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/energy.svg'),
                                  const SizedBox(width: 8),
                                  const Text("Sensor de Energia"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 6, 16, 6),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/exclamation.svg'),
                                  const SizedBox(width: 8),
                                  const Text("Crítico"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    store.value!.renderList!.isNotEmpty
                        ? _buildAssetTree(store.value!.renderList!)
                        : const Text('Nenhum asset disponível'),
                  ],
                ),
              ),
            ),
    );
  }
}
