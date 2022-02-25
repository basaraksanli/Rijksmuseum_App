import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseum_app/core/presentation/widgets/custom_image.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/art_object.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_detail_screen/art_detail_screen.dart';
import 'package:rijksmuseum_app/feature_art_list/util/art_list_sizes.dart';

import '../../../../core/util/constants/localization_constant.dart';

class ArtListItem extends StatelessWidget {
  final ArtObject artObject;

  const ArtListItem(this.artObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ArtDetailScreen(artObject.id)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: SizedBox(
              height: ArtListSizes.listItemHeight,
              child: Row(
                children: [
                  SizedBox(
                      width: ArtListSizes.listImageWidth,
                      child: CustomImage(artObject.thumbnail)),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            artObject.title,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const Divider(
                            height: ArtListSizes.horizontalDividerHeight,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Center(
                                  child: Text(
                                LC.artist.tr() + ": ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                              Expanded(
                                child: AutoSizeText(
                                  artObject.principalOrFirstMaker,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: ArtListSizes.horizontalDividerHeight,
          )
        ],
      ),
    );
  }
}
