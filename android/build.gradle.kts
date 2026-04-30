import java.io.FileInputStream
import java.util.Properties
import com.android.build.gradle.BaseExtension

// Load local.properties once so native SDK credentials (e.g. Mapbox) are not hardcoded.
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    FileInputStream(localPropertiesFile).use { localProperties.load(it) }
}
val mapboxDownloadsToken: String =
    localProperties.getProperty("MAPBOX_DOWNLOADS_TOKEN") ?: ""

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()

        // Mapbox Maven — required to pull the Mapbox Android SDKs at build time.
        // The password is read from local.properties (MAPBOX_DOWNLOADS_TOKEN) so the
        // secret downloads token is never committed to source control.
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            authentication {
                create<BasicAuthentication>("basic")
            }
            credentials {
                // MUST always be the literal string "mapbox" per Mapbox's docs —
                // it is NOT your Mapbox username.
                username = "mapbox"
                password = mapboxDownloadsToken
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
