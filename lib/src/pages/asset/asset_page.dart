import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../models/tree.dart';
import 'asset_controller.dart';
import 'widgets/filter_button.dart';
import 'widgets/search_field.dart';
import 'widgets/tree_tile.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> with Loader, Messages {
  late final ReactionDisposer statusDisposer;
  final AssetController controller = AssetController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case AssetStateStatus.initial:
            break;
          case AssetStateStatus.loading:
            showLoader();
            break;
          case AssetStateStatus.loaded:
            hideLoader();
            break;
          case AssetStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? '');
        }
      });
      controller.fetch(id);
      // controller.fetch('662fd0ee639069143a8fc387');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Observer(
        builder: (_) => controller.tree.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/amicoazul.svg',
                      height: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Não indentificamos nenhuma empresa!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Color(0XFFEAEEF2)),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SearchField(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            FilterButton(
                              iconUrl: 'assets/svg/bolt.svg',
                              label: 'Sensor de Energia',
                              selected:
                                  controller.assetStatus == AssetStatus.energy,
                              onTap: () async {
                                await controller
                                    .setAssetStatus(AssetStatus.energy);
                              },
                            ),
                            const SizedBox(width: 8),
                            FilterButton(
                              iconUrl: 'assets/svg/exclamationCircle.svg',
                              label: 'Crítico',
                              selected: controller.assetStatus ==
                                  AssetStatus.critical,
                              onTap: () async {
                                await controller
                                    .setAssetStatus(AssetStatus.critical);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.tree.length,
                      itemBuilder: (_, index) {
                        final Tree item = controller.tree[index];
                        return TreeTile(item);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
