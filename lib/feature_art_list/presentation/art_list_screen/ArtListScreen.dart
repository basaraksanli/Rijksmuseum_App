import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rijksmuseum_app/core/presentation/BasePage.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/bloc/art_list_screen_bloc.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/widgets/art_list_item.dart';

import '../../../core/util/constants/localization_constant.dart';
import '../../../di/AppModule.dart';

class ArtListScreen extends BasePage {
  const ArtListScreen({Key? key}) : super(key: key);

  @override
  BasePageState createState() => _ArtListScreenState();
}

class _ArtListScreenState extends BasePageState<ArtListScreen> {
  late ArtListScreenBloc _artListScreenBloc;
  late final ScrollController _scrollController;
  late RefreshController _refreshController;

  @override
  void didChangeDependencies() {
    _artListScreenBloc = ArtListScreenBloc(locator());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
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
        _artListScreenBloc.isNewItemsLoading != true &&
        _artListScreenBloc.noItemsToLoad != true) {
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
          _artListScreenBloc.add(StartFetchMoreItems());
        }
        if (state is ArtListScreenNoItemsToLoadError) {
          showErrorMessage(LC.thereIsNoItemLeftToShow.tr());
        }
        if (state is ArtListScreenNetworkError) {
          showErrorMessage(LC.couldNotFetchNewItems.tr());
        }
      },
      buildWhen: (pre, cur) {
        return cur is ArtListItemsLoaded || cur is ArtListScreenLoading;
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
        } else {
          return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: _onRefresh,
              header: const WaterDropHeader(),
              child: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  void _onRefresh() async {
    _artListScreenBloc.add(LoadArtItems());
    _refreshController.refreshCompleted();
  }
}
