package app.bitblik

import android.content.Intent
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "app.bitblik/offer_monitoring")
            .setMethodCallHandler { call, result ->
                try {
                    when (call.method) {
                        "start" -> {
                            val title = call.argument<String>("title")
                            val body = call.argument<String>("body")
                            if (title == null || body == null) {
                                result.error("invalid_arguments", "title and body are required", null)
                            } else {
                                ContextCompat.startForegroundService(this, Intent(this, OfferMonitoringService::class.java)
                                    .putExtra("title", title).putExtra("body", body))
                                result.success(null)
                            }
                        }
                        "stop" -> {
                            stopService(Intent(this, OfferMonitoringService::class.java))
                            result.success(null)
                        }
                        else -> result.notImplemented()
                    }
                } catch (error: RuntimeException) {
                    result.error("offer_monitoring_service", error.javaClass.simpleName, null)
                }
            }
    }
}
