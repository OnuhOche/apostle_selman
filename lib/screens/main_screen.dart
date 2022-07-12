import 'dart:io';

import "package:flutter/material.dart";
import 'package:apostle_selman/models/item_models.dart';
import 'package:just_audio/just_audio.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int? _playingIndex;

  List<Item> items = [
    Item(
      name: "Financial Dominion 1",
      imagePath: "selman_images/selman5.webp",
      audioPath: "selman_audios/selman1.mp3",
    ),
    Item(
      name: "Financial Dominion 2",
      imagePath: "selman_images/Selman2.webp",
      audioPath: "selman_audios/selman2.mp3",
    ),
    Item(
      name: "Financial Dominion 3",
      imagePath: "selman_images/selman4.webp",
      audioPath: "selman_audios/selman3.mp3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apostle Selman's Sermons")
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(items[index].imagePath))),
                child: ListTile(
                  leading: BorderedText(
                    strokeWidth: 4,
                    strokeColor: Colors.black,
                    child: Text(
                      items[index].name,
                      style: GoogleFonts.lato(
                          fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: IconButton(
                    icon: _playingIndex == index
                        ? FaIcon(Icons.stop_circle_outlined, size: 40)
                        : FaIcon(Icons.play_circle_outline, size: 40),
                    onPressed: () async {
                      if (_playingIndex == index) {
                        setState(() {
                          _playingIndex = null;
                        });

                        audioPlayer.stop();
                      } else {
                        try {
                          await audioPlayer.setAsset(items[index].audioPath);

                          audioPlayer.play();

                          setState(() {
                            _playingIndex = index;
                          });
                        } on SocketException {
                          print("No internet connection");
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}