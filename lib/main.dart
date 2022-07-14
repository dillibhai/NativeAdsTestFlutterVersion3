import 'package:flutter/material.dart';
import 'package:version3applovin/api/fetchapi.dart';
import 'package:get/get.dart';
import 'package:version3applovin/google_ad_view.dart';
import 'package:version3applovin/widgets/google_ads_widget.dart';
import 'applovinAdView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainBtn(),
    );
  }
}

class MainBtn extends StatefulWidget {
  const MainBtn({Key? key}) : super(key: key);

  @override
  State<MainBtn> createState() => _MainBtnState();
}

class _MainBtnState extends State<MainBtn> {
  @override
  void initState() {
    final FetchApiController controller = Get.put(FetchApiController());
    super.initState();
    controller.fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AppLovinAdView()));
                  },
                  child: const Text("Applovin Native ads")),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  GoogleAdView()));
                  },
                  child: const Text("Google Native ads")),
            ),
          ],
        ),
      ),
    );
  }
}
