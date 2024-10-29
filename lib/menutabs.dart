import 'package:flutter/material.dart';
import 'resources/app_colors.dart';

class menutabs extends StatelessWidget {
  menutabs({
    super.key,
    required this.iconz,
    required this.menutext,
    required this.bottm_sheet,

  });

  IconData iconz;
  String menutext;
  Function bottm_sheet;


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceheight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          await bottm_sheet();
        },
        child: Card(
          color: AppColors.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          elevation: 5.0, // Elevation for shadow effect
          child: SizedBox(
            width: deviceWidth*0.40,
            //width: 160,
            height: deviceheight* 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconz, size: deviceWidth*0.20, color: AppColors.menutabs),
                Text(
                  menutext,
                  style: const TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    //fontSize: AppFontSize.TextFontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
