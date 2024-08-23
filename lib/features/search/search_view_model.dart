// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/models/search_model.dart';
import 'package:itatiaia_app/features/index.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/index.dart';

abstract class SearchViewModel extends State<Search> {
  final repository = SearchRepository(ApiConnector());
  final _debounce = Debounce();
  SearchModel searchModel = SearchModel(payload: []);
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  String query = '';

  List<SearchPayload> listOfResult = [];

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _debounce.dispose();
  }

  _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      loadMore();
    }
  }

  void onSearch(String value) {
    _debounce(
      () {
        query = value;
        listOfResult.clear();
        requestList();
      },
    );
  }

  requestList() async {
    context.loaderOverlay.show();
    try {
      searchModel = await repository.query(query);
      listOfResult.addAll(searchModel.payload ?? []);
      scrollController.animateTo(0,
          duration: Durations.medium2, curve: Curves.bounceIn);
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }

  loadMore() async {
    context.loaderOverlay.show();
    isLoading = true;
    try {
      if ((searchModel.currentPage == searchModel.totalPages)) {
        return;
      }

      searchModel = await repository.query(query,
          offset: (searchModel.currentPage ?? 0) + 1);

      listOfResult.addAll(searchModel.payload ?? []);
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      context.loaderOverlay.hide();
      isLoading = false;
      setState(() {});
    }
  }

  onSelectedItem(SearchPayload model) {
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(
          url: 'https://www.itatiaia.com.br${model.url}?hidemenu=true',
          title: model.editorialName ?? ''),
    );
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }
}
