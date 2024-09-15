import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0XFFEAEFF3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0XFF8E98A3),
              size: 14,
            ),
            isDense: true,
            hintText: 'Buscar Ativo ou Local',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0XFF8E98A3),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
