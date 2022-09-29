import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final url;
  const VideoPlayerWidget(this.url, {Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
      //'http://devapi.fansinc.io/storage/9492871cefc860621b86a113f10e3516.mp4',
      //'https://fansinc.io/assets/images/fansic.mp4',
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );

    /*  _controller.addListener(() {
      setState(() {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      });
    }); */

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    // _controller.setLooping(true);
    /*  _controller = VideoPlayerController.network(
      // widget.url,
      'https://fansinc.io/assets/images/fansic.mp4',
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      }); */
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  //16/9
                  // Use the VideoPlayer widget to display the video.
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_controller),
                      // ClosedCaption(text: _controller.value.caption.text),
                      //_ControlsOverlay(controller: _controller),
                      VideoProgressIndicator(_controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            //video player progress bar
                            backgroundColor: Colors.redAccent,
                            playedColor: Colors.red,
                            bufferedColor: Colors.grey,
                          )),
                    ],
                  ),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
              /*  Container(
              // padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    // ClosedCaption(text: _controller.value.caption.text),
                    //_ControlsOverlay(controller: _controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              ),
            ), */
              ),

          // Expanded(child: VideoPlayer(_controller)),
          IconButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              icon: _controller.value.isPlaying
                  ? const Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ))
        ],
      ),
    );
  }
}
