import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Release signing credentials are NEVER stored in this repository.
//
// They are read, in order of preference, from:
//   1. Gradle properties / environment variables (CI):
//        ORG_GRADLE_PROJECT_storeFile, ORG_GRADLE_PROJECT_storePassword,
//        ORG_GRADLE_PROJECT_keyAlias,    ORG_GRADLE_PROJECT_keyPassword
//        (or -PstoreFile=… etc.)
//   2. android/key.properties (git-ignored, developer machine only)
//   3. Nothing -> fall back to the debug keystore so local builds work.
//
// android/key.properties.example documents the file-based option.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

/** Resolves a signing value from Gradle properties, then key.properties. */
fun signingValue(name: String): String? {
    val fromGradle = providers.gradleProperty(name).orNull?.takeIf { it.isNotBlank() }
    if (fromGradle != null) return fromGradle
    return keystoreProperties.getProperty(name)?.takeIf { it.isNotBlank() }
}

val storeFileValue = signingValue("storeFile")
val storePasswordValue = signingValue("storePassword")
val keyAliasValue = signingValue("keyAlias")
val keyPasswordValue = signingValue("keyPassword")

val hasReleaseSigning = storeFileValue != null &&
    storePasswordValue != null &&
    keyAliasValue != null &&
    keyPasswordValue != null

android {
    namespace = "com.tripmetic.app"
    // Material Components 1.11+ and AGP 8.x expect at least compileSdk 34 for resource merging.
    compileSdk = maxOf(34, flutter.compileSdkVersion)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.tripmetic.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = maxOf(33, flutter.minSdkVersion)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        ndk {
            abiFilters.clear()
            // Physical devices only — avoids x86_64 CMake/NDK linker failures on Apple Silicon Macs.
            abiFilters.add("arm64-v8a")
        }
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = keyAliasValue
                keyPassword = keyPasswordValue
                storeFile = rootProject.file(storeFileValue!!)
                storePassword = storePasswordValue
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                // No release keystore configured — fall back to the debug
                // keystore so local/CI builds still succeed. Never ship this.
                signingConfigs.getByName("debug")
            }
        }
    }

    packaging {
        jniLibs {
            // Multiple SDKs (e.g. Mapbox, PDF) ship the same libc++; pick one copy per ABI.
            pickFirsts += listOf(
                "lib/armeabi-v7a/libc++_shared.so",
                "lib/arm64-v8a/libc++_shared.so",
                "lib/x86/libc++_shared.so",
                "lib/x86_64/libc++_shared.so",
            )
        }
    }
}

flutter {
    source = "../.."
}

// Native RevenueCat Android SDK — align with https://www.revenuecat.com/docs/getting-started/installation/android
// The Flutter plugin also pulls purchases-hybrid-common; this line pins the billing SDK revision you asked for.
dependencies {
    // Required for Theme.MaterialComponents.* in res/values/styles.xml (NormalTheme).
    implementation("com.google.android.material:material:1.12.0")
    implementation("com.revenuecat.purchases:purchases:10.1.2")
}
