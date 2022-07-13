import 'package:bwciptv/api.dart';
import 'package:bwciptv/data.dart';
import 'package:bwciptv/player_screen.dart';
import 'package:bwciptv/provider.dart';
import 'package:flutter/material.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedChannel = Provider.of<ChannelProvider>(context).link;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map((e) => InkWell(
                          onTap: () {
                            Provider.of<ChannelProvider>(context, listen: false)
                                .updateChannel(e["link"]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.red)),
                            child: Column(
                              children: [
                                Text(e["name"]),
                                Text("Channels : ${e["channels"]}")
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(child: loadChannels(selectedChannel))
          ],
        )),
      ),
    );
  }

  loadChannels(link) {
    return FutureBuilder(
      future: Api.loadChannels(link),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            List<M3uGenericEntry> updatedData = [];
            for (var element in snapshot.data as List<M3uGenericEntry>) {
              if (element.attributes.isNotEmpty) {
                updatedData.add(element);
              }
            }
            return ListView.builder(
              itemCount: updatedData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                    data: updatedData[index],
                                  )));
                    },
                    child: Row(
                      children: [
                        Image.network(
                          updatedData[index].attributes['tvg-logo'] ??
                              "https://jonkuhrt.files.wordpress.com/2020/01/error-404-message.png",
                          width: 100,
                          height: 100,
                        ),
                        Expanded(child: Text(updatedData[index].title)),
                      ],
                    ));
              },
            );
          }
          return const Text("Channel not working");
        } else {
          return const Center(child: Text("Loading.."));
        }
      },
    );
  }
}
