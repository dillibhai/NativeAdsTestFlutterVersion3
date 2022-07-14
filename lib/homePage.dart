// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/banner.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:version3applovin/api/fetchapi.dart';
import 'package:get/get.dart';
import 'package:version3applovin/widgets/applovinAdWidget.dart';
import 'package:version3applovin/widgets/newsDataWidget.dart';

class AppLovinAdView extends StatelessWidget {
  AppLovinAdView({Key? key}) : super(key: key);
  final newsData = Get.find<FetchApiController>();
  @override
  Widget build(BuildContext context) {
    const String appLovinadUnitIdBanner = "435ee2924f1eda51";
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Lovin Implementation"),
      ),
      body: Obx(
        () => newsData.isDataLoaded.value == true
            ? CustomScrollView(
                scrollDirection: Axis.vertical,
                semanticChildCount: 4,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: newsData.feed?.length,
                      // ignore: body_might_complete_normally_nullable
                      (context, i) {
                        if (i % 2 == 0) {
                          return Column(
                            children: [
                              NewsDataWidget(
                                index: i,
                                newsData: newsData,
                              ),
                              const AppLovinAdWidget(),
                            ],
                          );
                        }
                        return NewsDataWidget(
                          index: i,
                          newsData: newsData,
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: BannerMaxView(
        // ignore: avoid_print
        (AppLovinAdListener? event) => print(event),
        BannerAdSize.banner,
        appLovinadUnitIdBanner,
      ),
    );
  }
}
