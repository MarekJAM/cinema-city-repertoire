import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_city/utils/theme_context_extensions.dart';
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
        Center(
          child: SizedBox(
            width: 300,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitWidth,
              errorWidget: (context, url, error) {
                return const Center(
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    size: 50,
                  ),
                );
              },
            ),
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
