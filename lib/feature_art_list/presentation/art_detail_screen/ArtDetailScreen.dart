import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rijksmuseum_app/core/presentation/BasePage.dart';
import 'package:rijksmuseum_app/core/presentation/widgets/CustomImage.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/ArtUseCases.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_detail_screen/bloc/art_detail_bloc.dart';

import '../../../core/util/constants/localization_constant.dart';
import '../../../di/AppModule.dart';

class ArtDetailScreen extends BasePage {
  final String _id;

  const ArtDetailScreen(this._id, {Key? key}) : super(key: key);

  @override
  BasePageState createState() => _ArtDetailState();
}

class _ArtDetailState extends BasePageState<ArtDetailScreen> {
  late ArtDetailBloc _artDetailBloc;
  late ArtUseCases _artUseCases;

  @override
  void didChangeDependencies() {
    _artUseCases = locator.get<ArtUseCases>();
    _artDetailBloc = ArtDetailBloc(widget._id, _artUseCases);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _artDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _artDetailBloc,
      builder: (context, state) {
        if (state is ArtDetailLoaded) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: AutoSizeText(state.artObject.title,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                leading: IconButton(
                  splashRadius: 20,
                  icon: const Icon(Ionicons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: CustomImage(
                          state.artObject.largeImage,
                          fit: BoxFit.contain,
                          progressBarEnabled: true,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: AutoSizeText(LC.details.tr(),
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              LC.productionLocation.tr() + " :",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (state.artObject.productionPlaces.isNotEmpty)
                              for (int i = 0;
                                  i < state.artObject.productionPlaces.length;
                                  i++)
                                Text(state.artObject.productionPlaces[i])
                            else
                              Text(LC.noLocationIndicated.tr())
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              LC.creator.tr() + " :",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              state.artObject.principalOrFirstMaker,
                              maxLines: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          LC.description.tr() + " :",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Text(state.artObject.description.isNotEmpty
                              ? state.artObject.description
                              : LC.noDescriptionAvailable.tr()),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return  Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
