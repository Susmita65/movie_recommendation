import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  final String  keyName;
  const PlayVideoFromNetwork({Key? key, required this.keyName}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Hold On'),
            content: const Text('Do you want to exit from video?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black
                ),
                onPressed: () => Navigator.of(context).pop(true),

                child: const Text('Yes'),
              ),

            ],
          ),
    ) ?? false;
  }
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.keyName}'),
      podPlayerConfig: PodPlayerConfig(
          autoPlay: true,
          isLooping: true,
          wakelockEnabled: true,

      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                      height: 270,
                      child: PodVideoPlayer(controller: controller)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
