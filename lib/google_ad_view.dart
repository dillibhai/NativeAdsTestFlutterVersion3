import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:version3applovin/widgets/google_ads_widget.dart';
import 'package:version3applovin/widgets/newsDataWidget.dart';

import 'api/fetchapi.dart';

class GoogleAdView extends StatefulWidget {
  GoogleAdView({Key? key}) : super(key: key);

  @override
  State<GoogleAdView> createState() => _GoogleAdViewState();
}

class _GoogleAdViewState extends State<GoogleAdView> {
  final newsData = Get.find<FetchApiController>();
  static final String testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Native Ad V3"),
        ),
        body: Obx(() => newsData.isDataLoaded.value == true
            ? CustomScrollView(
                scrollDirection: Axis.vertical,
                semanticChildCount: 4,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: newsData.feed?.length, (context, i) {
                      if (i % 2 == 0) {
                        return Column(
                          children: [
                            NewsDataWidget(index: i, newsData: newsData),
                            GoogleAdsNativeWidget(
                              testAdUnitId: testAdUnitId,
                            )
                          ],
                        );
                      }
                      return NewsDataWidget(
                        index: i,
                        newsData: newsData,
                      );
                    }),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              )));
  }
}
