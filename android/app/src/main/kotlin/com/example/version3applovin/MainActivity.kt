package com.example.version3applovin
import android.content.Context
import android.os.Bundle
import com.applovin.sdk.AppLovinSdk
import com.applovin.sdk.AppLovinSdkConfiguration
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import np.com.nepalipatro.NativeViewAppLovin

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initializeApplovinSdk()
        nativeAdDisplay()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)


        val factory = NativeAdWrapper(layoutInflater, context)

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "NpNativeAd", factory)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
//        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "NpNativeAd")
    }


    private fun initializeApplovinSdk (){
        AppLovinSdk.getInstance( context ).setMediationProvider( "max" )
        AppLovinSdk.getInstance( context ).initializeSdk({ configuration: AppLovinSdkConfiguration ->
        }
        )
    }
    private fun nativeAdDisplay(){
        flutterEngine?.platformViewsController?.registry?.registerViewFactory("<platform-view-type>", NativeViewFactory())
    }
}
 class  NativeViewFactory :PlatformViewFactory(StandardMessageCodec.INSTANCE){
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams=args as Map<String?, Any?>?
        return NativeViewAppLovin(context!!,viewId,creationParams)
    }
}

