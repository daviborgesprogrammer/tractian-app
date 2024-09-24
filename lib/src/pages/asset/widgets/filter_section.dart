import 'package:flutter/material.dart';

import '../../../core/ui/asset_const.dart';
import '../asset_controller.dart';
import 'filter_button.dart';
import 'filter_text_search.dart';

class FilterSection extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<AssetStatus>? onSearchTap;
  final AssetStatus buttonSelected;
  const FilterSection({
    super.key,
    this.onSearchChanged,
    this.onSearchTap,
    this.buttonSelected = AssetStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0XFFEAEEF2)),
        ),
      ),
      child: Column(
        children: [
          FilterTextSearch(
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilterButton(
                iconUrl: SvgConstant.boltIcon,
                label: 'Sensor de Energia',
                selected: buttonSelected == AssetStatus.energy,
                onTap: onSearchTap != null
                    ? () => onSearchTap!(AssetStatus.energy)
                    : null,
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  FilterButton(
                    iconUrl: SvgConstant.criticalIcon,
                    label: 'Crítico',
                    selected: buttonSelected == AssetStatus.critical,
                    onTap: onSearchTap != null
                        ? () => onSearchTap!(AssetStatus.critical)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    // return Column(
    //   children: [

    //     FilterTextSearch(),
    //   ],
    // );
  }
}
