
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/converter_provider.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
   late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<ConverterProvider>().inputText,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      clipBehavior: Clip.antiAlias,
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: AppStrings.inputLabel,
        hintText: AppStrings.inputHint,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        contentPadding: .symmetric(
          horizontal: 16,vertical: 14,
      ),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            context.read<ConverterProvider>().updateInput('');
            setState(() {});
          },
        )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          context.read<ConverterProvider>().updateInput(value);
        });
      },
    );
  }
}