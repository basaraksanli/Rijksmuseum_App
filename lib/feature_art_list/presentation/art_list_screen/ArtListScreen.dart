import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum_app/core/presentation/BasePage.dart';
import 'package:rijksmuseum_app/feature_art_list/domain/use_case/ArtUseCases.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/bloc/art_list_screen_bloc.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/widgets/art_list_item.dart';

import '../../../di/AppModule.dart';

class ArtListScreen extends BasePage {
  const ArtListScreen({Key? key}) : super(key: key);

  @override
  BasePageState createState() => _ArtListScreenState();
}

class _ArtListScreenState extends BasePageState<ArtListScreen> {
  late ArtListScreenBloc _artListScreenBloc;
  late ArtUseCases _artUseCases;
  late final ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    _artUseCases = locator.get<ArtUseCases>();
    _artListScreenBloc = ArtListScreenBloc(_artUseCases);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _artListScreenBloc.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 10 &&
        _artListScreenBloc.isNewItemsLoading != true) {
      _artListScreenBloc.isNewItemsLoading = true;
      _artListScreenBloc.add(LoadMoreItems());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _artListScreenBloc,
      listener: (context, state) {
        if (state is MoreArtListItemsLoading) {
          _artListScreenBloc.add(StartFetchItems());
        }
      },
      buildWhen: (pre, cur) {
        return cur is ArtListItemsLoaded ||
            cur is ArtListScreenNetworkError ||
            cur is ArtListScreenLoading;
      },
      builder: (context, state) {
        if (state is ArtListItemsLoaded) {
          return SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                ListView.builder(
                  itemCount: state.artObjectList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return ArtListItem(state.artObjectList[index]);
                  },
                ),
                BlocBuilder(
                    bloc: _artListScreenBloc,
                    builder: (context, state) {
                      return Visibility(
                          visible: state is MoreArtListItemsLoading,
                          child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CircularProgressIndicator()));
                    })
              ]));
        } else if (state is ArtListScreenNetworkError) {
          return const Text("Error");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
