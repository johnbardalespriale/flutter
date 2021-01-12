import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  Duration videoLength;
  Duration videoPosition;
  double volume = 0;
  bool widgetVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
            videoLength = _controller.value.duration;
          }))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videoLength = _controller.value.duration;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_controller.value.initialized) ...[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (widgetVisible == true) {
                        widgetVisible = false;
                      } else {
                        widgetVisible = true;
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: widgetVisible,
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: widgetVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Icon(_controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () => setState(() {
                            /* _controller.value.isPlaying
                                ? widgetVisible = true
                                : widgetVisible = false;*/

                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          }),
                        ),
                      ),
                      Text(
                          '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(_controller.value.duration)}'),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(animatedVolumeIcon(volume)),
                      ),
                      Flexible(
                        child: Slider(
                          value: volume,
                          min: 0,
                          max: 1,
                          onChanged: (changeVolume) {
                            setState(() {
                              volume = changeVolume;
                              _controller.setVolume(changeVolume);
                            });
                          },
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.loop,
                              color: _controller.value.isLooping
                                  ? Colors.green
                                  : Colors.black),
                          onPressed: () {
                            _controller
                                .setLooping(!_controller.value.isLooping);
                          }),
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String convertToMinutesSeconds(Duration duration) {
    final parsedMinutes = duration.inMinutes % 60;

    final minutes =
        parsedMinutes < 10 ? '0$parsedMinutes' : parsedMinutes.toString();

    final parsedSeconds = duration.inSeconds % 60;

    final seconds =
        parsedSeconds < 10 ? '0$parsedSeconds' : parsedSeconds.toString();

    return '$minutes:$seconds';
  }

  IconData animatedVolumeIcon(double volume) {
    if (volume == 0)
      return Icons.volume_mute;
    else if (volume < 0.5)
      return Icons.volume_down;
    else
      return Icons.volume_up;
  }
}
