import 'package:flutter/material.dart';
import 'package:tractian/src/pages/assets_page.dart';
import 'package:tractian/src/stores/companies_store.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = CompaniesStore();

  @override
  void initState() {
    super.initState();
    store.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.getCompanies();
    });
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    store.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/svgs/logo.svg',
          ),
        ),
        backgroundColor: const Color.fromRGBO(23, 25, 45, 1),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: store.value.companies.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: store.value.companies.length,
                  itemBuilder: (context, index) {
                    final company = store.value.companies[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AssetsPage.routeName,
                            arguments: ScreenArguments(company.id),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(33, 136, 255, 1),
                          fixedSize: const Size(317, 76),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svgs/companies.svg'),
                              const SizedBox(width: 10),
                              Text(
                                "${company.name} unit",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
