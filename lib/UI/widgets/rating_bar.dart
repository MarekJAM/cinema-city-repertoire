import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({required this.rating, required this.maxRating, this.iconSize = 12, super.key});

  final double rating;
  final double maxRating;
  final double iconSize;

  final double _height = 8;
  final double _width = 55;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                borderRadius: const .all(.circular(3)),
                color: Colors.grey[700],
              ),
            ),
            ClipRRect(
              child: Align(
                alignment: .centerLeft,
                widthFactor: rating / maxRating,
                child: Container(
                  height: _height,
                  width: _width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(.circular(3)),
                    gradient: LinearGradient(
                      begin: .topLeft,
                      end: .bottomRight,
                      colors: [Colors.red, Colors.yellow, Colors.green],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 10, fontWeight: .bold)),
      ],
    );
  }
}

class RatingBarSkeleton extends StatelessWidget {
  const RatingBarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      child: Column(
        children: [
          SizedBox(height: 2),
          Row(
            children: [
              SizedBox(width: 55, height: 8, child: Bone.text()),
              SizedBox(width: 4),
              Bone.text(width: 15, fontSize: 8),
            ],
          ),
        ],
      ),
    );
  }
}
