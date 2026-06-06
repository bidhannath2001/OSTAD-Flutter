import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/converter_provider.dart';
import '../widget/category_selector.dart';
import '../widget/input_field.dart';
import '../widget/result_card.dart';
import '../widget/unit_dropdown.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            crossAxisAlignment: .start,
            children: [
              CategorySelector(),
              Text(
                AppStrings.enterValue,
                style: TextStyle(fontSize: 14, fontWeight: .w600),
              ),
              InputField(),
              Text(
                AppStrings.fromLabel,
                style: TextStyle(fontSize: 14, fontWeight: .w600),
              ),
              UnitDropdown(
                selectedUnit: provider.fromUnit,
                units: provider.currentUnits,
                onChanged: (value) {
                  context.read<ConverterProvider>().updateFromUnit(value!);
                },

              ),

              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () => context.read<ConverterProvider>().swap(),
                  icon: Icon(
                    Icons.swap_horizontal_circle,
                    color: Colors.blue,
                    size: 48,
                  ),
                ),
              ),

              Text(
                AppStrings.toLabel,
                style: TextStyle(fontSize: 14, fontWeight: .w600),
              ),
              UnitDropdown(
                selectedUnit: provider.toUnit,
                units: provider.currentUnits,
                onChanged: (value) {
                  context.read<ConverterProvider>().updateToUnit(value!);
                },
              ),

              ResultCard(),
            ],
          ),
        ),
      ),
    );
  }
}
