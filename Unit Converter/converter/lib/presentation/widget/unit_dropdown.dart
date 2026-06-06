import 'package:flutter/material.dart';

class UnitDropdown extends StatelessWidget {
  const UnitDropdown({
    super.key,
    required this.selectedUnit,
    required this.units,
    required this.onChanged,
  });
  final String selectedUnit;
  final List<String> units;
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedUnit,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      items: units
          .map(
            (unit) => DropdownMenuItem<String>(
          value: unit,
          child: Text(unit, overflow: TextOverflow.ellipsis),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}