import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static final AudioPlayerHandler _singleton = AudioPlayerHandler._internal();

  AudioPlayerHandler._internal() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  factory AudioPlayerHandler() {
    return _singleton;
  }

  final _player = AudioPlayer();

  bool isPlaying() => _player.playing;

  Future<void> prepareToPlay(MediaItem item) async {
    if (await mediaItem.isEmpty) {
      mediaItem.add(item);
    } else {
      mediaItem.sink.add(item);
    }
    _player.setAudioSource(AudioSource.uri(Uri.parse(item.id)));
  }

  Future<void> volume(double volume) => _player.setVolume(volume);

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle);
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
