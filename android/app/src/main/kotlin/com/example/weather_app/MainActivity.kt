package com.example.weather_app

import io.flutter.embedding.android.FlutterActivity
import androidx.core.view.WindowCompat // Import WindowCompat


class MainActivity: FlutterActivity() {
    override fun onPostResume() {
        super.onPostResume()
        WindowCompat.setDecorFitsSystemWindows(window, false) // Now it should work
    }
}
