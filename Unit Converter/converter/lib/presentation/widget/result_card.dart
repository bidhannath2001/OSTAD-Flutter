import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/converter_provider.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConverterProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 2,
          child: Container(
            padding: .all(20),
            width: .infinity,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.resultLabel,
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.result,
                      style: TextStyle(fontSize: 26, fontWeight: .w600, color: Theme.of(context).primaryColor),
                    ),

                    provider.inputText.isNotEmpty? Text(
                      provider.toUnit,
                      style: TextStyle(fontSize: 26, fontWeight: .w600, color: Theme.of(context).primaryColor),

                    ):Container(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
