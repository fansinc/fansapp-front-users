//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final bool? autoPlay;
  final String? videoId;
  final VoidCallback? fullScreenPressed;

  const YoutubePlayerWidget({
    Key? key,
    @required this.autoPlay,
    @required this.videoId,
    @required this.fullScreenPressed,
  })  : assert(videoId != '', 'Please send a valid youtube url'),
        super(key: key);
  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  YoutubePlayerController? _youtubePlayerController;
  final int _isFullScreen = 0;
  bool initialized = false;
  // bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        autoPlay: false,
      ),
    )..addListener(listener);
    _youtubePlayerController!.setVolume(100);
    initialized = true;
  }

  void listener() {
    // if (_isPlayerReady && mounted && !_youtubePlayerController.value.isFullScreen) {
    //   setState(() {
    //     _videoMetaData = _youtubePlayerController.metadata;
    //   });
    // }
  }

  @override
  void deactivate() {
    _youtubePlayerController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: _isFullScreen,
      child: Stack(
        children: [
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: widget.videoId!,
              //'zn2GwbPG-tc', //Add videoID.
              flags: const YoutubePlayerFlags(
                hideControls: false,
                controlsVisibleAtStart: true,
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.green,
          ),
          /* YoutubePlayerBuilder(
            onExitFullScreen: () {
              // print('Exit FullScreen');
              // widget.fullScreenPressed();
              if (_isPlayerReady) {
                _youtubePlayerController!.play();
              }
            },
            onEnterFullScreen: () {
              //print('Enter FullScreen');
              // widget.fullScreenPressed();
              if (_isPlayerReady) {
                _youtubePlayerController!.play();
              }
            },
            player: 
            YoutubePlayer(
              controller: _youtubePlayerController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.green,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _youtubePlayerController!.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                _youtubePlayerController!.pause();
                //print('Video ended');
              },
            ),
            builder: (_, player) => player,
          ), */
        ],
      ),
    );
  }
}
