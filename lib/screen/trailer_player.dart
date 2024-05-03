//Class này lấy Id từ video trên youtube để chạy
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../style/style.dart';

void main() {
  runApp(MyYoutube());
}

class MyYoutube extends StatelessWidget {
  // Create a YoutubePlayerController instance
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'KEUjWxdXdEk', // Replace with your YouTube video ID
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: HeroIcon(
              HeroIcons.chevronLeft,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(color: black),
          child: Center(
            // Use YoutubePlayer widget to display the YouTube video
            child: YoutubePlayer(
              controller: _controller, // Pass the controller instance
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red, // Customize progress indicator color
              progressColors: ProgressBarColors(
                playedColor: Colors.red, // Customize played part color
                handleColor: Colors.red, // Customize seek bar handle color
              ),
              onReady: () {
                print('Video is ready.'); // Callback when video is ready
              },
              onEnded: (metaData) {
                print('Video ended.'); // Callback when video ends
              },
            ),
          ),
        ),
      ),
    );
  }
}
