import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  final dynamic data;
  const PlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            data.link,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
                aspectRatio: 16 / 9,
                autoPlay: true,
                controlsConfiguration: BetterPlayerControlsConfiguration(
                    enableProgressBar: false,
                    enableProgressText: false,
                    enableSkips: false)),
          ),
        ),
      ),
    );
  }
}
