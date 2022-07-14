import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/newsModel.dart';

class FetchApiController extends GetxController {
  late List<FeedModel>? feed = [];
  List<dynamic> fd = [];
  RxBool isDataLoaded = false.obs;

  Future<dynamic> fetchFeed() async {
    final response = await http.get(Uri.parse(
        'https://api-news.nepalipatro.com.np/api/feeds?lang=en&filter[category]'));
    if (response.statusCode == 200) {
      // var list =
      //     Feed.fromJson(jsonDecode(response.body)).toJson().entries.toList();

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse["feeds"];

      // jsonResponse.map((json) => FeedModel.fromJson(json)).toList();

      var list = feedModelFromJson(jsonEncode(data));

      feed = list;
      isDataLoaded.value = true;
    } else {
      throw Exception('Failed to load data');
    }
  }


}
