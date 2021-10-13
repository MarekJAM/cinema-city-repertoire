import 'package:flutter/material.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final String imageUrl;
  final double minExtent;
  final double maxExtent;

  SliverHeader({
    @required this.imageUrl,
    this.minExtent,
    @required this.maxExtent,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
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
                child: Center(
                  child: CircularProgressIndicator(),
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
            crossFadeState: frame == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
