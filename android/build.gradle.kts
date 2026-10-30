import com.android.build.gradle.BaseExtension
import java.io.File

// NOTE: the `buildscript` block below is evaluated before the rest of this
// script, so the Mapbox token lookup is inlined there rather than extracted
// into a shared helper.
//
// Resolves the secret Mapbox downloads token used to fetch the Mapbox Maven
// artifacts. It is NEVER stored in this repository.
//
// Resolution order:
//   1. Gradle property  -PMAPBOX_DOWNLOADS_TOKEN=…  (or ~/.gradle/gradle.properties)
//   2. Environment variable MAPBOX_DOWNLOADS_TOKEN
//   3. android/local.properties (git-ignored, developer machine only)
//
// When unset the Mapbox Maven repository is simply unauthenticated, which
// makes artifact resolution fail with a 401 — the build never embeds the
// token in any committed file.
buildscript {
    val mapboxDownloadsToken =
        providers.gradleProperty("MAPBOX_DOWNLOADS_TOKEN").orNull?.takeIf { it.isNotBlank() }
            ?: System.getenv("MAPBOX_DOWNLOADS_TOKEN")?.takeIf { it.isNotBlank() }
            ?: java.util.Properties().apply {
                val propsFile = File(rootDir, "local.properties")
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
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}

val mapboxDownloadsToken: String =
    providers.gradleProperty("MAPBOX_DOWNLOADS_TOKEN").orNull?.takeIf { it.isNotBlank() }
        ?: System.getenv("MAPBOX_DOWNLOADS_TOKEN")?.takeIf { it.isNotBlank() }
        ?: java.util.Properties().apply {
            val propsFile = File(rootDir, "local.properties")
            if (propsFile.exists()) propsFile.inputStream().use { load(it) }
        }.getProperty("MAPBOX_DOWNLOADS_TOKEN", "")

allprojects {
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
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.library") {
        extensions.configure<BaseExtension>("android") {
            if (namespace == null) {
                namespace = project.group.toString()
            }
        }
    }
    plugins.withId("com.android.application") {
        extensions.configure<BaseExtension>("android") {
            if (namespace == null) {
                namespace = project.group.toString()
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
