import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/provider/weather_provider.dart';

class WeatherBackgroundWidget extends StatefulWidget {
  const WeatherBackgroundWidget({super.key});

  @override
  State<WeatherBackgroundWidget> createState() =>
      _WeatherBackgroundWidgetState();
}

class _WeatherBackgroundWidgetState extends State<WeatherBackgroundWidget> {
  late final VideoPlayerController videoController;
  @override
  void initState() {
    videoController = VideoPlayerController.asset(
        "${Provider.of<WeatherProvider>(context, listen: false).weatherBackground}"
      //"assets/light_rain.mp4"
    )
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            videoController.play();
            videoController.setLooping(true);
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                        width: videoController.value.size.width,
                        height: videoController.value.size.height,
                        child: VideoPlayer(videoController))),
              ),
            ]
          ),
        );
      });
  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}
