import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

import '../../core/components/not_found.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../models/company.dart';
import 'home_controller.dart';
import 'widgets/company_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  late final ReactionDisposer statusDisposer;
  final HomeController controller = HomeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case HomeStatus.initial:
            break;
          case HomeStatus.loading:
            showLoader();
            break;
          case HomeStatus.loaded:
            hideLoader();
            break;
          case HomeStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? '');
        }
      });
      controller.fetchCompanies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/svg/logo_tractian.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 126,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Observer(
          builder: (_) => controller.companies.isEmpty
              ? const NotFound(
                  label: 'Não indetificamos nenhuma empresa!',
                )
              : ListView.builder(
                  itemCount: controller.companies.length,
                  itemBuilder: (context, index) {
                    final Company(:name, :id) = controller.companies[index];
                    return CompanyTile(title: name ?? '', id: id ?? '');
                  },
                ),
        ),
      ),
    );
  }
}
