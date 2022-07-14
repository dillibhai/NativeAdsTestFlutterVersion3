import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:version3applovin/api/fetchapi.dart';

class NewsDataWidget extends StatelessWidget {
  NewsDataWidget({Key? key, required this.index, required this.newsData})
      : super(key: key);
  final int index;
  // final newsData = Get.find<FetchApiController>();
  final FetchApiController newsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CachedNetworkImage(
              placeholder: (context, url) =>
                  Image.asset("assets/images/placeholder.png"),
              imageUrl: newsData.feed?[index].image.toString() ?? ""),
          Text(newsData.feed?[index].description.toString() ?? ""),
        ],
      ),
    );
  }
}
