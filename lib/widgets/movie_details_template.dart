import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsTemplate extends StatefulWidget {
  final String title;
  final String plot;
  final String releaseDate;
  //final String runtime;
  final String backgroundImageUrl;
  final String? director;
  final String? trailerUrl;
  final List<String>? genres;
  final VoidCallback? onBack;

  const MovieDetailsTemplate({
    super.key,
    required this.title,
    required this.plot,
    required this.releaseDate,
    //required this.runtime,
    required this.backgroundImageUrl,
    this.director,
    this.trailerUrl,
    this.genres,
    this.onBack,
  });

  @override
  State<MovieDetailsTemplate> createState() => _MovieDetailsTemplateState();
}

class _MovieDetailsTemplateState extends State<MovieDetailsTemplate> {
  void _showTrailer(BuildContext context, String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    if (videoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid trailer URL')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.cyanAccent,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.network(
          widget.backgroundImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
        ),

        // Overlay
        Container(color: Colors.black.withOpacity(0.6)),

        // Movie content
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white70, size: 18),
                    const SizedBox(width: 6),
                    Text(widget.releaseDate,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(width: 20),
                    const Icon(Icons.timer, color: Colors.white70, size: 18),
                    const SizedBox(width: 6),
                    // Text(widget.runtime,
                    //     style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                if (widget.director != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white70, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Directed by: ${widget.director}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
                if (widget.genres != null && widget.genres!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: -6,
                    children: widget.genres!
                        .map((g) => Chip(
                              label: Text(g,
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor:
                                  Colors.cyanAccent.withOpacity(0.2),
                            ))
                        .toList(),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  "Plot",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.plot,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (widget.trailerUrl != null) ...[
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () =>
                        _showTrailer(context, widget.trailerUrl ?? ''),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Watch Trailer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(180, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        Positioned(
          top: 32,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: widget.onBack ?? () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
