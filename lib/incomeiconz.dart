import 'package:flutter/material.dart';
class IncomeIconz extends StatelessWidget {
  IncomeIconz({
    super.key,required this.Iconz,required this.Icon_text,
  });
  IconData Iconz;
  String Icon_text;
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
            elevation: 5,
            child: InkWell(
              onTap: () {
                print(Icon_text);
              },
              child: SizedBox(
                width: 80,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconz,size: 40,),
                    Text(Icon_text)
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
