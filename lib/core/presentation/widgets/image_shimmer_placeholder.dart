import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerPlaceholder extends StatelessWidget {
  final bool progressBarEnabled;

  const ImageShimmerPlaceholder({Key? key, this.progressBarEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Shimmer.fromColors(
          child: Container(
            color: Colors.grey,
          ),
          baseColor: Colors.blueGrey,
          highlightColor: Colors.grey),
      if (progressBarEnabled) const Center(child: CircularProgressIndicator()),
    ]);
  }
}
