package com.tripmetic.app

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.text.format.DateFormat
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.time.ZoneId
import java.util.Locale

/**
 * Home screen widget backed by [HomeWidgetPlugin] SharedPreferences
 * (`HomeWidgetPreferences`), written from Flutter via `home_widget`.
 *
 * Uses [android.widget.TextClock] so times update every minute without periodic
 * [AppWidgetManager] refreshes. City names remain [android.widget.TextView].
 */
class DualClockWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (id in appWidgetIds) {
            try {
                updateSafe(context, appWidgetManager, id)
            } catch (e: Exception) {
                Log.e(TAG, "DualClockWidget update failed for id=$id", e)
                try {
                    appWidgetManager.updateAppWidget(id, buildFallbackViews(context))
                } catch (inner: Exception) {
                    Log.e(TAG, "DualClockWidget fallback failed", inner)
                }
            }
        }
    }

    private fun updateSafe(
        context: Context,
        appWidgetManager: AppWidgetManager,
        widgetId: Int,
    ) {
        val prefs = try {
            HomeWidgetPlugin.getData(context)
        } catch (e: Exception) {
            Log.w(TAG, "Could not read HomeWidget preferences", e)
            appWidgetManager.updateAppWidget(widgetId, buildFallbackViews(context))
            return
        }

        val rawC1 = prefs.getString(KEY_CITY1_NAME, null)
        val rawZ1 = prefs.getString(KEY_CITY1_TZ, null)
        val rawC2 = prefs.getString(KEY_CITY2_NAME, null)
        val rawZ2 = prefs.getString(KEY_CITY2_TZ, null)

        val city1 = rawC1?.trim().orEmpty()
        val city2 = rawC2?.trim().orEmpty()
        val tz1Raw = rawZ1?.trim().orEmpty()
        val tz2Raw = rawZ2?.trim().orEmpty()

        val views = RemoteViews(context.packageName, R.layout.widget_dual_clock)

        val ready =
            city1.isNotEmpty() &&
                city2.isNotEmpty() &&
                tz1Raw.isNotEmpty() &&
                tz2Raw.isNotEmpty() &&
                isValidZoneId(tz1Raw) &&
                isValidZoneId(tz2Raw)

        if (!ready) {
            applyPlaceholderContent(context, views)
            appWidgetManager.updateAppWidget(widgetId, views)
            return
        }

        views.setTextViewText(R.id.city1_name, city1)
        views.setTextViewText(R.id.city2_name, city2)

        val locale = Locale.getDefault()
        val pat12 =
            DateFormat.getBestDateTimePattern(locale, "jm")
        val pat24 =
            DateFormat.getBestDateTimePattern(locale, "Hm")
        val patDate =
            DateFormat.getBestDateTimePattern(locale, "EEEMMMd")

        bindClockColumn(views, R.id.clock1_time, R.id.date1, tz1Raw, pat12, pat24, patDate)
        bindClockColumn(views, R.id.clock2_time, R.id.date2, tz2Raw, pat12, pat24, patDate)

        appWidgetManager.updateAppWidget(widgetId, views)
    }

    private fun bindClockColumn(
        views: RemoteViews,
        timeViewId: Int,
        dateViewId: Int,
        zoneId: String,
        pat12: String,
        pat24: String,
        patDate: String,
    ) {
        views.setString(timeViewId, "setTimeZone", zoneId)
        views.setCharSequence(timeViewId, "setFormat12Hour", pat12)
        views.setCharSequence(timeViewId, "setFormat24Hour", pat24)
        views.setString(dateViewId, "setTimeZone", zoneId)
        views.setCharSequence(dateViewId, "setFormat12Hour", patDate)
        views.setCharSequence(dateViewId, "setFormat24Hour", patDate)
    }

    private fun applyPlaceholderContent(context: Context, views: RemoteViews) {
        views.setTextViewText(
            R.id.city1_name,
            context.getString(R.string.widget_dual_clock_city1_hint),
        )
        views.setTextViewText(
            R.id.city2_name,
            context.getString(R.string.widget_dual_clock_city2_hint),
        )
        val phTime = context.getString(R.string.widget_dual_clock_time_placeholder)
        val phDate = context.getString(R.string.widget_dual_clock_date_placeholder)
        val utc = "UTC"
        views.setString(R.id.clock1_time, "setTimeZone", utc)
        views.setCharSequence(R.id.clock1_time, "setFormat12Hour", phTime)
        views.setCharSequence(R.id.clock1_time, "setFormat24Hour", phTime)
        views.setString(R.id.date1, "setTimeZone", utc)
        views.setCharSequence(R.id.date1, "setFormat12Hour", phDate)
        views.setCharSequence(R.id.date1, "setFormat24Hour", phDate)
        views.setString(R.id.clock2_time, "setTimeZone", utc)
        views.setCharSequence(R.id.clock2_time, "setFormat12Hour", phTime)
        views.setCharSequence(R.id.clock2_time, "setFormat24Hour", phTime)
        views.setString(R.id.date2, "setTimeZone", utc)
        views.setCharSequence(R.id.date2, "setFormat12Hour", phDate)
        views.setCharSequence(R.id.date2, "setFormat24Hour", phDate)
    }

    private fun buildFallbackViews(context: Context): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.widget_dual_clock)
        applyPlaceholderContent(context, views)
        return views
    }

    private fun isValidZoneId(id: String): Boolean =
        id.isNotBlank() && runCatching { ZoneId.of(id) }.isSuccess

    companion object {
        private const val TAG = "DualClockWidget"

        private const val KEY_CITY1_NAME = "dual_clock_city1_name"
        private const val KEY_CITY1_TZ = "dual_clock_city1_tz"
        private const val KEY_CITY2_NAME = "dual_clock_city2_name"
        private const val KEY_CITY2_TZ = "dual_clock_city2_tz"
    }
}
