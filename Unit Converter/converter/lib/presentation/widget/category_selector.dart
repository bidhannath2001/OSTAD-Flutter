import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/converter_provider.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: List.generate(provider.categories.length, (index) {
          final category = provider.categories[index];
          final isSelected = provider.selectedCategoryIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.read<ConverterProvider>().selectCategory(index),
              child: Container(
                alignment: .center,
                padding: .all(10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w600,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
