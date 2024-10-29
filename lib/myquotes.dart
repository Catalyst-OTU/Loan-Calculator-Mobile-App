
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'resources/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class myquotes extends StatefulWidget {
  const myquotes({super.key});

  @override
  State<myquotes> createState() => _myquotesState();
}

class _myquotesState extends State<myquotes> {
  final String videoUrl = "https://www.youtube.com/watch?v=fGoFE3DS6sk";
  final String thumbnailUrl = "https://img.youtube.com/vi/fGoFE3DS6sk/0.jpg";

  // Function to launch URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); // Convert string to Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.textColor,
        height: 770,
        // decoration: BoxDecoration(
        //   color: AppColors.textColor,
        //   //border: Border.all(color: AppColors.menutabs),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text on the left
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Title(color: Colors.black, child: const Text("Supporting Women in Business: Closing The finacial Gap In Ghana",style: TextStyle(fontSize: 21),),),
              ),
              // Image or Video on the right
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(videoUrl); // Launch the video URL
                  },
                  child: CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Menaye Finance Initiative helps every woman learn about money and grow her business.",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Join us as we explore an impactful einitiative aimed at empowering women entrepreneurs in Ghana by bridging the gender gap in business.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
