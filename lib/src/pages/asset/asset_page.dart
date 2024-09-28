import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../core/components/not_found.dart';
import '../../core/ui/helpers/debouncer.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../models/tree.dart';
import 'asset_controller.dart';
import 'widgets/filter_section.dart';
import 'widgets/tree_tile.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> with Loader, Messages {
  late final ReactionDisposer statusDisposer;
  final AssetController controller = AssetController();
  final debouncer = Debouncer(milliseconds: 500);

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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Assets'),
      ),
      body: Observer(
        builder: (_) => controller.tree.isEmpty &&
                controller.assetStatus == AssetStatus.none
            ? const NotFound(label: 'Não encontramos nenhum item!')
            : Column(
                children: [
                  FilterSection(
                    onSearchChanged: (value) {
                      debouncer.call(() async {
                        await controller.setQuery(value);
                      });
                    },
                    buttonSelected: controller.assetStatus,
                    onSearchTap: (value) async {
                      await controller.setAssetStatus(value);
                    },
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
