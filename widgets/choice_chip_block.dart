import 'package:flutter/material.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

class ChoiceChipBlock<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) labelBuilder;
  final void Function(T, bool) onSelectionChanged;

  ChoiceChipBlock({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.labelBuilder,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _ChoiceChipBlockState<T> createState() => _ChoiceChipBlockState<T>();
}

class _ChoiceChipBlockState<T> extends State<ChoiceChipBlock<T>> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Spacing between chips
      children: widget.items.map((item) {
        bool isSelected = widget.selectedItems.contains(item);
        return ChoiceChip(
          label: Text(widget.labelBuilder(item)),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              widget.onSelectionChanged(item, selected);
            });
          },
          selectedColor: Colors.blue, // Adjust as needed
          backgroundColor: Colors.grey, // Adjust as needed
          labelStyle: TextStyle(color: UIConstants().textLightMode),
        );
      }).toList(),
    );
  }
}
