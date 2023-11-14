import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../i18n/strings.g.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final String imageUrl;
  final String? videoUrl;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  SliverHeader({
    required this.imageUrl,
    required this.minExtent,
    required this.maxExtent,
    this.videoUrl,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: 300,
            errorBuilder: (context, exception, stackTrace) {
              return const Center(
                child: Text(
                  'Brak plakatu',
                  textAlign: TextAlign.center,
                ),
              );
            },
            frameBuilder: (
              BuildContext context,
              Widget child,
              int? frame,
              bool wasSynchronouslyLoaded,
            ) {
              return AnimatedCrossFade(
                firstChild: SizedBox(
                  height: maxExtent,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                secondChild: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: child,
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                crossFadeState:
                    frame == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        if (videoUrl != null)
          Positioned(
            right: 10,
            bottom: 5,
            child: ElevatedButton(
              onPressed: () async {
                if (await canLaunchUrlString(videoUrl!)) {
                  await launchUrlString(videoUrl!);
                } else {
                  throw 'Could not launch $videoUrl';
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
              ),
              child: Text(t.filmDetails.seeTrailer),
            ),
          )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
