package com.tripmetic.app

import android.app.ActivityOptions
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import java.util.Locale
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Home / lock-screen currency ladder widget backed by [HomeWidgetPlugin]
 * SharedPreferences written from Flutter.
 */
class CurrencyWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (id in appWidgetIds) {
            try {
                updateSafe(context, appWidgetManager, id)
            } catch (e: Exception) {
                Log.e(TAG, "CurrencyWidget update failed for id=$id", e)
                try {
                    val views = buildFallbackViews(context)
                    bindClickHandlers(context, views)
                    appWidgetManager.updateAppWidget(id, views)
                } catch (inner: Exception) {
                    Log.e(TAG, "CurrencyWidget fallback failed", inner)
                }
            }
        }
    }

    private fun updateSafe(
        context: Context,
        appWidgetManager: AppWidgetManager,
        widgetId: Int,
    ) {
        val views = RemoteViews(context.packageName, R.layout.currency_widget)

        try {
            val prefs = HomeWidgetPlugin.getData(context)
            val baseCode = prefs.getString(KEY_BASE_CODE, null)?.trim().orEmpty()
            val targetCode = prefs.getString(KEY_TARGET_CODE, null)?.trim().orEmpty()
            val rateCaption = prefs.getString(KEY_RATE_CAPTION, null)?.trim().orEmpty()
            val ladder1 = prefs.getString(KEY_LADDER_1, null)?.trim().orEmpty()
            val ladder20 = prefs.getString(KEY_LADDER_20, null)?.trim().orEmpty()
            val ladder100 = prefs.getString(KEY_LADDER_100, null)?.trim().orEmpty()

            val ready = baseCode.isNotEmpty() && targetCode.isNotEmpty()
            if (!ready) {
                applyPlaceholderContent(context, views)
            } else {
                views.setTextViewText(R.id.base_code, baseCode)
                views.setTextViewText(R.id.target_code, targetCode)
                views.setTextViewText(R.id.ladder_base_1, "1 $baseCode")
                views.setTextViewText(R.id.ladder_base_20, "20 $baseCode")
                views.setTextViewText(R.id.ladder_base_100, "100 $baseCode")
                views.setTextViewText(
                    R.id.ladder_target_1,
                    ladder1.ifEmpty { approxLadder(baseCode, targetCode, 1.0) },
                )
                views.setTextViewText(
                    R.id.ladder_target_20,
                    ladder20.ifEmpty { approxLadder(baseCode, targetCode, 20.0) },
                )
                views.setTextViewText(
                    R.id.ladder_target_100,
                    ladder100.ifEmpty { approxLadder(baseCode, targetCode, 100.0) },
                )
                views.setTextViewText(
                    R.id.rate_caption,
                    rateCaption.ifEmpty {
                        approxRateCaption(baseCode, targetCode)
                            ?: context.getString(R.string.widget_currency_setup_hint)
                    },
                )
            }
        } catch (e: Exception) {
            Log.w(TAG, "Could not read HomeWidget preferences", e)
            applyPlaceholderContent(context, views)
        }

        bindClickHandlers(context, views)
        appWidgetManager.updateAppWidget(widgetId, views)
    }

    private fun bindClickHandlers(context: Context, views: RemoteViews) {
        bindLaunchIntent(
            context,
            views,
            R.id.widget_root,
            Uri.parse(URI_SELECT_TARGET),
            REQUEST_SELECT_ROOT,
        )
        bindLaunchIntent(
            context,
            views,
            R.id.pair_row,
            Uri.parse(URI_SELECT_BASE),
            REQUEST_SELECT_BASE,
        )
        bindLaunchIntent(
            context,
            views,
            R.id.action_change,
            Uri.parse(URI_SELECT_TARGET),
            REQUEST_SELECT_CHANGE,
        )
        bindBackgroundRefresh(context, views, R.id.action_refresh)
    }

    private fun bindBackgroundRefresh(context: Context, views: RemoteViews, viewId: Int) {
        val pendingIntent =
            HomeWidgetBackgroundIntent.getBroadcast(
                context,
                Uri.parse(URI_REFRESH),
            )
        views.setOnClickPendingIntent(viewId, pendingIntent)
    }

    private fun bindLaunchIntent(
        context: Context,
        views: RemoteViews,
        viewId: Int,
        uri: Uri,
        requestCode: Int,
    ) {
        val intent = Intent(context, MainActivity::class.java).apply {
            data = uri
            action = HomeWidgetLaunchIntent.HOME_WIDGET_LAUNCH_ACTION
        }
        var flags = PendingIntent.FLAG_UPDATE_CURRENT
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            flags = flags or PendingIntent.FLAG_IMMUTABLE
        }

        val pendingIntent =
            if (Build.VERSION.SDK_INT < 34) {
                PendingIntent.getActivity(context, requestCode, intent, flags)
            } else {
                val options = ActivityOptions.makeBasic()
                if (Build.VERSION.SDK_INT >= 35) {
                    options.setPendingIntentCreatorBackgroundActivityStartMode(
                        ActivityOptions.MODE_BACKGROUND_ACTIVITY_START_ALLOWED,
                    )
                } else {
                    options.pendingIntentBackgroundActivityStartMode =
                        ActivityOptions.MODE_BACKGROUND_ACTIVITY_START_ALLOWED
                }
                PendingIntent.getActivity(context, requestCode, intent, flags, options.toBundle())
            }
        views.setOnClickPendingIntent(viewId, pendingIntent)
    }

    private fun approxLadder(baseCode: String, targetCode: String, amount: Double): String {
        val rate = rateBaseToTarget(baseCode, targetCode) ?: return PLACEHOLDER_AMOUNT
        return String.format(Locale.US, "%.2f %s", amount * rate, targetCode)
    }

    private fun rateBaseToTarget(baseCode: String, targetCode: String): Double? {
        val usdToBase = if (baseCode == "USD") 1.0 else BUNDLED_USD_TO[baseCode]
        val usdToTarget = if (targetCode == "USD") 1.0 else BUNDLED_USD_TO[targetCode]
        if (usdToBase == null || usdToTarget == null || usdToBase == 0.0) return null
        return usdToTarget / usdToBase
    }

    private fun approxRateCaption(baseCode: String, targetCode: String): String? {
        val mult = rateBaseToTarget(baseCode, targetCode) ?: return null
        return if (mult >= 1.0) {
            "1 $baseCode = ${String.format(Locale.US, "%.4f", mult)} $targetCode"
        } else {
            "1 $targetCode = ${String.format(Locale.US, "%.4f", 1.0 / mult)} $baseCode"
        }
    }

    private fun applyPlaceholderContent(context: Context, views: RemoteViews) {
        val base = DEFAULT_BASE_CODE
        val target = DEFAULT_TARGET_CODE
        views.setTextViewText(R.id.base_code, base)
        views.setTextViewText(R.id.target_code, target)
        views.setTextViewText(R.id.ladder_base_1, "1 $base")
        views.setTextViewText(R.id.ladder_base_20, "20 $base")
        views.setTextViewText(R.id.ladder_base_100, "100 $base")
        views.setTextViewText(R.id.ladder_target_1, approxLadder(base, target, 1.0))
        views.setTextViewText(R.id.ladder_target_20, approxLadder(base, target, 20.0))
        views.setTextViewText(R.id.ladder_target_100, approxLadder(base, target, 100.0))
        views.setTextViewText(
            R.id.rate_caption,
            approxRateCaption(base, target)
                ?: context.getString(R.string.widget_currency_setup_hint),
        )
    }

    private fun buildFallbackViews(context: Context): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.currency_widget)
        applyPlaceholderContent(context, views)
        return views
    }

    companion object {
        private const val TAG = "CurrencyWidget"

        const val URI_SELECT_BASE = "tripmetic://currency-widget/select?slot=0"
        const val URI_SELECT_TARGET = "tripmetic://currency-widget/select?slot=1"
        const val URI_REFRESH = "tripmetic://currency-widget/refresh"

        private const val DEFAULT_BASE_CODE = "USD"
        private const val DEFAULT_TARGET_CODE = "EUR"
        private const val PLACEHOLDER_AMOUNT = "—"

        private const val KEY_BASE_CODE = "currency_widget_base_code"
        private const val KEY_TARGET_CODE = "currency_widget_target_code"
        private const val KEY_RATE_CAPTION = "currency_widget_rate_caption"
        private const val KEY_LADDER_1 = "currency_widget_ladder_1"
        private const val KEY_LADDER_20 = "currency_widget_ladder_20"
        private const val KEY_LADDER_100 = "currency_widget_ladder_100"

        private const val REQUEST_SELECT_ROOT = 1001
        private const val REQUEST_SELECT_BASE = 1002
        private const val REQUEST_SELECT_CHANGE = 1004
        private val BUNDLED_USD_TO =
            mapOf(
                "EUR" to 0.85911,
                "GBP" to 0.79,
                "JPY" to 151.2,
                "PHP" to 56.43,
                "DOP" to 59.5,
                "MXN" to 16.5,
                "CAD" to 1.38,
                "AUD" to 1.53,
                "CHF" to 0.88,
                "CNY" to 7.2,
                "INR" to 83.0,
                "VND" to 24500.0,
            )
    }
}
