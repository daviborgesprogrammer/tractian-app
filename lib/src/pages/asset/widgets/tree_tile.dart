// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/asset_const.dart';
import '../../../models/tree.dart';

class TreeTile extends StatefulWidget {
  final Tree item;
  const TreeTile(
    this.item, {
    super.key,
  });

  @override
  State<TreeTile> createState() => _TreeTileState();
}

class _TreeTileState extends State<TreeTile> {
  @override
  Widget build(BuildContext context) {
    return buildCeil(item: widget.item);
  }

  Widget buildCeil({required Tree item, int level = 0}) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: List.generate(
                level,
                (_) => const Padding(
                  padding: EdgeInsets.only(left: 12, right: 4),
                  // child: Container(
                  //   height: 30,
                  //   width: 1,
                  //   color: const Color(0X1F000000),
                  // ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: SvgPicture.asset(
                          SvgConstant.arrowIcon,
                          height: 10,
                          colorFilter: ColorFilter.mode(
                            item.subTree != null && item.subTree!.isNotEmpty
                                ? const Color(0XFF17192D)
                                : Colors.transparent,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Image.asset(
                        switch (item.treeType) {
                          TreeType.location => SvgConstant.locationIcon,
                          TreeType.asset => SvgConstant.assetIcon,
                          TreeType.component => SvgConstant.componentIcon,
                          _ => SvgConstant.locationIcon,
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        item.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0XFF17192D),
                        ),
                      ),
                    ),
                    item.sensorType != null && item.sensorType == 'vibration'
                        ? const Icon(
                            Icons.circle,
                            size: 8,
                            color: Color(0XFFED3833),
                          )
                        : item.sensorType != null && item.sensorType == 'energy'
                            ? const Icon(
                                Icons.bolt,
                                size: 16,
                                color: Color(0XFF52C41A),
                              )
                            : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (item.subTree != null && item.subTree!.isNotEmpty)
          ...item.subTree!.map((st) => buildCeil(item: st, level: level + 1)),
      ],
    );
  }
}
