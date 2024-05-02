package com.example.colorword_new

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

  /*  lateinit var intent:Any
    @RequiresApi(Build.VERSION_CODES.O)
    fun startService()
    {
        intent = Intent(this,AppService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent as Intent)
        }else
        {
            startService(intent as Intent)
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "com.example.messages")
                .setMethodCallHandler { call, result ->

                    if (call.method == "startService") {
                        startService()
                    }
                }

    }
*//*    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.i("NativeMsg", "MainActivity configureFlutterEngine  Çalıştı")

*//**//*
        val CHANNEL = "action_process_text"
        flutterEngine.dartExecutor.binaryMessenger.send(CHANNEL,"")

*//**//*

    }*/

}


