import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'ErrorImageWidget.dart';
import 'ImageShimmerPlaceholder.dart';

class CustomImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final bool progressBarEnabled;

  const CustomImage(this.url, {Key? key, this.fit = BoxFit.cover, this.progressBarEnabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: url ?? "",
        useOldImageOnUrlChange: true,
        fit: fit,
        placeholder: (context, url) => ImageShimmerPlaceholder(progressBarEnabled: progressBarEnabled),
        errorWidget: (context, url, error) => const ErrorImageWidget());
  }
}
