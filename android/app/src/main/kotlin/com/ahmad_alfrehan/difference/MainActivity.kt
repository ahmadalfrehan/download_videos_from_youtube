package com.ahmad_alfrehan.difference
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private var data : String="";
    private val CHANNEL = "youTubeDownloader"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getData") {
                getIntentData();
                result.success(data);
                data = "";
            }
        }
    }

    private fun getIntentData(){
        if(intent?.action==Intent.ACTION_SEND){
            if(intent.type == "text/plain"){
                intent.getStringExtra(Intent.EXTRA_TEXT)?.let { intentData ->
                    data = intentData
                }
            }
        }
    }
}
