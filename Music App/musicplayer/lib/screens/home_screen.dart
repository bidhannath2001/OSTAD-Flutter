// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/music_equalizer%20.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Song> _playList = [
    Song(
      title: "3-second synth melody",
      artist: "Sample MP3",
      url: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3",
      duration: 3,
    ),
    Song(
      title: "6-second synth melody",
      artist: "Sample MP3",
      url: "https://samplelib.com/lib/preview/mp3/sample-6s.mp3",
      duration: 6,
    ),
    Song(
      title: "9-second synth melody",
      artist: "Sample MP3",
      url: "https://samplelib.com/lib/preview/mp3/sample-9s.mp3",
      duration: 9,
    ),
    Song(
      title: "12-second synth melody",
      artist: "Sample MP3",
      url: "https://samplelib.com/lib/preview/mp3/sample-12s.mp3",
      duration: 12,
    ),
    Song(
      title: "19-second synth melody",
      artist: "Sample MP3",
      url: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3",
      duration: 19,
    ),
  ];

  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _hasStarted = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  void _listenToPlay() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      _nextMusic();
    });
  }

  Future<void> _playMusic(int index) async {
    _currentIndex = index;
    _hasStarted = true;
    final song = _playList[index];
    setState(() {
      _duration = Duration(seconds: song.duration);
      _position = Duration.zero;
    });
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(_playList[index].url));
  }

  Future<void> _togglePlayPause() async {
    if (!_hasStarted) {
      _hasStarted = true;
      await _playMusic(_currentIndex);
    } else if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  Future<void> _nextMusic() async {
    _currentIndex == _playList.length - 1 ? _currentIndex = 0 : _currentIndex++;
    await _playMusic(_currentIndex);
  }

  Future<void> _previousMusic() async {
    _currentIndex == 0 ? _currentIndex = _playList.length - 1 : _currentIndex--;
    await _playMusic(_currentIndex);
  }

  String _getDurationString(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seceonds = duration.inSeconds - minutes * 60;
    return '$minutes:${seceonds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _listenToPlay();
  }

  @override
  Widget build(BuildContext context) {
    final Song song = _playList[_currentIndex];
    final double maxSecond = max(_duration.inSeconds.toDouble(), 1);
    final double currentSecond = _position.inSeconds.toDouble().clamp(
      0,
      maxSecond,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("Music Player"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: Colors.white10,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      song.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: Colors.white),
                    ),
                    Text(
                      song.artist,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://picsum.photos/200",
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SleekCircularSlider(
                          key: ValueKey(_currentIndex),
                          min: 0,
                          max: maxSecond,
                          initialValue: currentSecond,
                          appearance: CircularSliderAppearance(
                            // animationEnabled: false,
                            startAngle: 270,
                            angleRange: 360,
                            customWidths: CustomSliderWidths(
                              trackWidth: 4,
                              progressBarWidth: 6,
                              handlerSize: 10,
                            ),
                            customColors: CustomSliderColors(
                              trackColor: Colors.white24,
                              progressBarColor: Colors.orange,
                              dotColor: Colors.orange,
                            ),
                            infoProperties: InfoProperties(
                              modifier: (double value) {
                                final position = Duration(
                                  seconds: value.toInt(),
                                );
                                // _audioPlayer.seek(position);

                                return _getDurationString(position);
                              },
                              mainLabelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onChange: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ],
                    ),
                    // Slider(
                    //   min: 0,
                    //   value: currentSecond,
                    //   max: maxSecond,
                    //   onChanged: (value) async {
                    //     final position = Duration(seconds: value.toInt());
                    //     _audioPlayer.seek(position);
                    //   },
                    //   activeColor: Colors.orange,
                    //   inactiveColor: Colors.grey,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getDurationString(_position),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _getDurationString(_duration),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: _previousMusic,
                            icon: Icon(Icons.skip_previous),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: _togglePlayPause,
                            icon: _isPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: _nextMusic,
                            icon: Icon(Icons.skip_next),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _playList.length,
                itemBuilder: (context, index) {
                  final music = _playList[index];
                  final bool isSelected = index == _currentIndex;
                  return ListTile(
                    title: Text(
                      music.title,
                      style: isSelected
                          ? TextStyle(color: Colors.orange)
                          : TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      music.artist,
                      style: isSelected
                          ? TextStyle(color: Colors.orange)
                          : TextStyle(color: Colors.white),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: (_isPlaying && isSelected)
                          ? const MusicEqualizer()
                          : Icon(
                              Icons.play_arrow,
                              // size: 18,
                              color: isSelected ? Colors.orange : Colors.white,
                            ),
                    ),

                    onTap: () {
                      if (index == _currentIndex) {
                        _togglePlayPause();
                      } else {
                        _playMusic(index);
                      }
                    },
                    selected: isSelected,
                    selectedTileColor: Colors.white10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String url;
  final int duration;
  Song({
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
  });
}
