pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    // Resolves the secret Mapbox downloads token used to fetch the Mapbox
    // Maven artifacts. It is NEVER stored in this repository.
    //
    // Resolution order:
    //   1. Gradle property  -PMAPBOX_DOWNLOADS_TOKEN=…  (or ~/.gradle/gradle.properties)
    //   2. Environment variable MAPBOX_DOWNLOADS_TOKEN
    //   3. android/local.properties (git-ignored, developer machine only)
    //
    // When unset the Mapbox Maven repository is simply unauthenticated,
    // which makes artifact resolution fail with a 401 — the build never
    // embeds the token in any committed file.
    //
    // NOTE: this block is evaluated before the rest of the script, so the
    // lookup is inlined rather than extracted into a helper.
    val mapboxDownloadsToken =
        providers.gradleProperty("MAPBOX_DOWNLOADS_TOKEN").orNull?.takeIf { it.isNotBlank() }
            ?: System.getenv("MAPBOX_DOWNLOADS_TOKEN")?.takeIf { it.isNotBlank() }
            ?: java.util.Properties().apply {
                val propsFile = file("local.properties")
                if (propsFile.exists()) propsFile.inputStream().use { load(it) }
            }.getProperty("MAPBOX_DOWNLOADS_TOKEN", "")

    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            credentials {
                username = "mapbox"
                password = mapboxDownloadsToken
            }
            authentication {
                create<BasicAuthentication>("basic")
            }
        }
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    val mapboxDownloadsToken =
        providers.gradleProperty("MAPBOX_DOWNLOADS_TOKEN").orNull?.takeIf { it.isNotBlank() }
            ?: System.getenv("MAPBOX_DOWNLOADS_TOKEN")?.takeIf { it.isNotBlank() }
            ?: java.util.Properties().apply {
                val propsFile = file("local.properties")
                if (propsFile.exists()) propsFile.inputStream().use { load(it) }
            }.getProperty("MAPBOX_DOWNLOADS_TOKEN", "")

    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
        maven { url = uri("https://plugins.gradle.org/m2") }
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            credentials {
                username = "mapbox"
                password = mapboxDownloadsToken
            }
            authentication {
                create<BasicAuthentication>("basic")
            }
        }
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")