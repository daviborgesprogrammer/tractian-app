import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget {
  final String iconUrl;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const FilterButton({
    super.key,
    required this.iconUrl,
    required this.label,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: const Color(0XFFD8DFE6)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 16, 8),
          child: Row(
            children: [
              SvgPicture.asset(
                iconUrl,
                colorFilter: ColorFilter.mode(
                  selected ? Colors.white : const Color(0XFF77818C),
                  BlendMode.srcIn,
                ),
                height: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : const Color(0XFF77818C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
