package np.com.nepalipatro
import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.applovin.mediation.MaxAd
import com.applovin.mediation.MaxAdRevenueListener
import com.applovin.mediation.MaxError
import com.applovin.mediation.nativeAds.MaxNativeAdListener
import com.applovin.mediation.nativeAds.MaxNativeAdLoader
import com.applovin.mediation.nativeAds.MaxNativeAdView
import com.applovin.mediation.nativeAds.MaxNativeAdViewBinder
import com.applovin.sdk.AppLovinSdk
import io.flutter.plugin.platform.PlatformView

class NativeViewAppLovin(context: Context, id: Int, creationParams: Map<String?, Any?>?) :
    PlatformView, MaxAdRevenueListener {
    private var ctx: Context?=context
    private var rootView: View
    private var view: ViewGroup

    override fun getView(): View {
        return rootView

    }
    override fun dispose() {}
    private var nativeAdLoader: MaxNativeAdLoader? = null
    private var loadedNativeAd: MaxAd? = null
    init {
        createNativeAdLoader()
        loadNativeAd()
        val inflater = LayoutInflater.from(context)
        rootView = inflater.inflate(R.layout.applovin_native_ad_layout, null, true)
        view = rootView.findViewById(R.id.frameLayout)

    }

    private fun createNativeAdLoader() {
//        AppLovinSdk.getInstance(ctx).settings.testDeviceAdvertisingIds = arrayListOf("488059ce-989b-4d9a-adcb-10ca1ad1abe1")
        nativeAdLoader = MaxNativeAdLoader("b8baf4d7051afc7f", ctx)
        nativeAdLoader!!.setRevenueListener(this)
        nativeAdLoader!!.setNativeAdListener(NativeAdListener())

    }

    private fun loadNativeAd() {
        nativeAdLoader?.loadAd(createNativeAdView())
    }

    private inner class NativeAdListener : MaxNativeAdListener() {
        override fun onNativeAdLoaded(nativeAdView: MaxNativeAdView?, nativeAd: MaxAd) {
            // Clean up any pre-existing native ad to prevent memory leaks.
            if (loadedNativeAd != null) {
                nativeAdLoader?.destroy(loadedNativeAd)
            }

            // Save ad for cleanup.
            loadedNativeAd = nativeAd
//                val rootView = findViewById<ViewGroup>(R.id.frameLayout)
            view.addView(nativeAdView)

        }

        override fun onNativeAdLoadFailed(adUnitId: String, error: MaxError) {
            Log.d("error", error.message)
        }

        override fun onNativeAdClicked(nativeAd: MaxAd) {}
    }
    private fun createNativeAdView(): MaxNativeAdView {
        val binder: MaxNativeAdViewBinder =
            MaxNativeAdViewBinder.Builder(R.layout.native_ad_applovin)
                .setMediaContentViewGroupId(R.id.native_ad_attribution)
                .setTitleTextViewId(R.id.title_text_view)
                .setBodyTextViewId(R.id.body_text_view)
                .setIconImageViewId(R.id.ad_image_view)
                .setMediaContentViewGroupId(R.id.media_view_container)
                .setOptionsContentViewGroupId(R.id.options_view)
                .setCallToActionButtonId(R.id.native_cta_button)
                .build()
        return MaxNativeAdView(binder, ctx)
    }

    override fun onAdRevenuePaid(ad: MaxAd?) {

    }
}
