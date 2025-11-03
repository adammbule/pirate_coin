import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:Piratecoin/widgets/theme_widget.dart'; // for kBackgroundColor, kPirateGradient, etc.

class MovieDetailsTemplate extends StatefulWidget {
  final String title;
  final String plot;
  final String releaseDate;
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
                flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
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
    final hasTrailer =
        widget.trailerUrl != null && widget.trailerUrl!.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.network(
            widget.backgroundImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
          ),

          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xAA0F2027),
                  Color(0xCC203A43),
                  Color(0xFF2C5364)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with gradient text
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        kPirateGradient.createShader(bounds),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Release date & director
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.cyanAccent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        widget.releaseDate,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      ),
                      if (widget.director != null) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.person,
                            color: Colors.cyanAccent, size: 18),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "Dir. ${widget.director!}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Genres
                  if (widget.genres != null && widget.genres!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: widget.genres!
                          .map(
                            (g) => Chip(
                              label: Text(
                                g,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  Colors.cyanAccent.withOpacity(0.15),
                              side: const BorderSide(color: Colors.cyanAccent),
                            ),
                          )
                          .toList(),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Plot
                  Text(
                    "Plot Summary",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.plot,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 100), // leave room for FAB
                ],
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 32,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 22,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: widget.onBack ?? () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),

      // Floating Play Button
      floatingActionButton: hasTrailer
          ? FloatingActionButton.extended(
              onPressed: () => _showTrailer(context, widget.trailerUrl!),
              icon: const Icon(Icons.play_arrow, size: 24),
              label: const Text(
                "Watch Trailer",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            )
          : null,
    );
  }
}
