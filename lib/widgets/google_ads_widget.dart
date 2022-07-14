import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsNativeWidget extends StatefulWidget {
  GoogleAdsNativeWidget({Key? key, required this.testAdUnitId})
      : super(key: key);
  final String testAdUnitId;

  @override
  State<GoogleAdsNativeWidget> createState() => _GoogleAdsNativeWidgetState();
}

class _GoogleAdsNativeWidgetState extends State<GoogleAdsNativeWidget> {
  final String factoryId = "NpNativeAd";
  NativeAd? _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();
  @override
  void initState() {
    super.initState();
    _nativeAd = NativeAd(
      nativeAdOptions:
          NativeAdOptions(mediaAspectRatio: MediaAspectRatio.landscape),
      adUnitId: widget.testAdUnitId,
      factoryId: factoryId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          nativeAdCompleter.completeError(error);
        },
        onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
    _nativeAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: FutureBuilder<NativeAd>(
        future: nativeAdCompleter.future,
        builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
          Widget child;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              child = Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Theme.of(context).scaffoldBackgroundColor,
                height: 325,
                child: const Center(
                  child: Text("AD"),
                ),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                child = SizedBox(
                  height: 325,
                  child: AdWidget(ad: snapshot.data!),
                );
              } else {
                child = Container();
              }
          }
          return child;
        },
      ),
    );
  }
}
