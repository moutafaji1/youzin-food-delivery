package com.example.youzine_food

import android.app.ActivityManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Bundle
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setCustomTaskDescription()
    }

    override fun onResume() {
        super.onResume()
        setCustomTaskDescription()
    }

    private fun setCustomTaskDescription() {
        try {
            val icon: Bitmap = BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                // Android 9+ (API 28+)
                val taskDescription = ActivityManager.TaskDescription(
                    "YouZin Food",
                    R.mipmap.ic_launcher,
                    ContextCompat.getColor(this, android.R.color.white)
                )
                setTaskDescription(taskDescription)
            } else {
                // Android 8 and below
                val taskDescription = ActivityManager.TaskDescription(
                    "YouZin Food",
                    icon,
                    ContextCompat.getColor(this, android.R.color.white)
                )
                setTaskDescription(taskDescription)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
