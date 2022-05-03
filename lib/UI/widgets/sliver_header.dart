import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final String imageUrl;
  final String videoUrl;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  SliverHeader({
    @required this.imageUrl,
    @required this.videoUrl,
    this.minExtent,
    @required this.maxExtent,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: 300,
            frameBuilder: (
              BuildContext context,
              Widget child,
              int frame,
              bool wasSynchronouslyLoaded,
            ) {
              return AnimatedCrossFade(
                firstChild: Container(
                  height: maxExtent,
                  child: Container(
                    child: const Center(
                      child: const CircularProgressIndicator(),
                    ),
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
        Positioned(
          right: 10,
          bottom: 5,
          child: ElevatedButton(
            child: const Text('Zobacz zwiastun'),
            onPressed: () async {
              if (await canLaunch(videoUrl)) {
                await launch(videoUrl);
              } else {
                throw 'Could not launch $videoUrl';
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
            ),
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
