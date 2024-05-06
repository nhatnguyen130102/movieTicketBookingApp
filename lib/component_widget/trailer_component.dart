import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../style/style.dart';

class TrailerComponent extends StatefulWidget {
  late String trailerID;
  TrailerComponent({required this.trailerID, super.key});

  @override
  State<TrailerComponent> createState() => _TrailerComponentState();
}

class _TrailerComponentState extends State<TrailerComponent> {
  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(widget.trailerID);
    String videoId = uri.queryParameters['v'] ?? '';
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId, // Replace with your YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
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

