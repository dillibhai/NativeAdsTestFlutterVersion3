// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/banner.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:version3applovin/widgets/applovinAdWidget.dart';
import 'package:version3applovin/api/fetchapi.dart';
import 'package:get/get.dart';

class AppLovinAdView extends StatelessWidget {
  AppLovinAdView({Key? key}) : super(key: key);
  final fetchfeeds = Get.find<FetchApiController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Lovin Implementation"),
      ),
      body: Obx(
        () => fetchfeeds.isDataLoaded.value == true
            ? CustomScrollView(
                scrollDirection: Axis.vertical,
                semanticChildCount: 4,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: fetchfeeds.feed?.length,
                      // ignore: body_might_complete_normally_nullable
                      (context, i) {
                        if (i % 2 == 0) {
                          return Column(
                            children: [
                              newsData(i),
                              const AppLovinAdWidget(),
                            ],
                          );
                        }
                        return newsData(i);
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
          "435ee2924f1eda51"),
    );
  }

  Widget newsData(index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CachedNetworkImage(
              placeholder: (context, url) =>
                  Image.asset("assets/images/placeholder.png"),
              imageUrl: fetchfeeds.feed?[index].image.toString() ?? ""),
          Text(fetchfeeds.feed?[index].description.toString() ?? ""),
        ],
      ),
    );
  }
}
