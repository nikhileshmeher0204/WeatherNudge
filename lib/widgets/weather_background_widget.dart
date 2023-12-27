import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WeatherBackgroundWidget extends StatefulWidget {
  const WeatherBackgroundWidget({super.key});

  @override
  State<WeatherBackgroundWidget> createState() => _WeatherBackgroundWidgetState();
}

class _WeatherBackgroundWidgetState extends State<WeatherBackgroundWidget> {
  late final VideoPlayerController videoController;
  @override
  void initState() {
    videoController = VideoPlayerController.asset("assets/moving_clouds.mp4")..initialize().then((_){
      videoController.play();
      videoController.setLooping(true);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) => VideoPlayer(videoController);
}
