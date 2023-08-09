import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoScreen extends StatefulWidget {
  final String video;

  const VideoScreen({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ChewieController? _chewieController;

  late VideoPlayerController videoPlayerController;

  Future initVideo() async {
    videoPlayerController = VideoPlayerController.network(widget.video);
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }
  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    videoPlayerController.pause();
    videoPlayerController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: Center(
        child: _chewieController != null ? AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: _chewieController!,
          ),

        ) : const CircularProgressIndicator(color: Colors.deepOrange,)
      ),
    );
  }
}
