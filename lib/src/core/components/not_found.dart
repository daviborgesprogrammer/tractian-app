import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ui/asset_const.dart';

class NotFound extends StatelessWidget {
  final String label;
  const NotFound({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgConstant.emptyBox,
            height: 200,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Não indetificamos nenhuma empresa!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
