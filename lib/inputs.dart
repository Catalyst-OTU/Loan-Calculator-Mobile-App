import 'package:flutter/material.dart';
import 'resources/app_colors.dart';
class inputs extends StatelessWidget {
  final input_label;
  final hint_text;
  IconData prefix_icon;
  TextInputType input_type;
  TextEditingController controller_name;
  final Function(String)? onChanged;
  inputs({
    super.key,this.input_label,
    this.hint_text,
    required this.prefix_icon,
    required this.controller_name,
    required this.input_type,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            controller: controller_name,
            keyboardType: input_type,
            decoration: InputDecoration(
                prefixIcon: Icon(prefix_icon,color: AppColors.menutabs,),
                labelText: input_label,
                hintText: hint_text,
                border: const OutlineInputBorder(

                ),
            ),
           onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $input_label';
            }
            return null; // Input is valid
          },
        ),
      );


  }


}