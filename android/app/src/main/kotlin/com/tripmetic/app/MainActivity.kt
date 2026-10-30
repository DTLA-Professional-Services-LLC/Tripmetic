package com.tripmetic.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ensureBroadcastNotificationChannel()
    }

    /** Launcher badges track delivered notifications — clear when the user opens the app. */
    override fun onResume() {
        super.onResume()
        clearDeliveredNotifications()
    }

    private fun clearDeliveredNotifications() {
        val manager = getSystemService(NotificationManager::class.java) ?: return
        manager.cancelAll()
    }

    private fun ensureBroadcastNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager = getSystemService(NotificationManager::class.java) ?: return
        val channelId = "tripmetic_broadcasts"
        if (manager.getNotificationChannel(channelId) != null) return
        val channel = NotificationChannel(
            channelId,
            "Tripmetic broadcasts",
            NotificationManager.IMPORTANCE_HIGH,
        ).apply {
            description = "Announcements from Tripmetic"
            enableVibration(true)
        }
        manager.createNotificationChannel(channel)
    }
}
