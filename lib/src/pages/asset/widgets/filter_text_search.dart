import 'package:flutter/material.dart';

class FilterTextSearch extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClearText;
  const FilterTextSearch({
    this.onChanged,
    this.onClearText,
    super.key,
  });

  @override
  State<FilterTextSearch> createState() => _FilterTextSearchState();
}

class _FilterTextSearchState extends State<FilterTextSearch> {
  final searchController = TextEditingController();
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
          controller: searchController,
          textAlignVertical: TextAlignVertical.center,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0XFF8E98A3),
              size: 14,
            ),
            suffixIcon:
                widget.onClearText == null || searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          widget.onClearText!();
                        },
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
