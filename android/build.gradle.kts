import com.android.build.gradle.BaseExtension
import java.io.File

buildscript {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            credentials {
                username = "mapbox"
                password = java.util.Properties().apply {
                    val propsFile = File(rootDir, "local.properties")
                    if (propsFile.exists()) propsFile.inputStream().use { load(it) }
                }.getProperty("MAPBOX_DOWNLOADS_TOKEN", "")
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

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            credentials {
                username = "mapbox"
                password = java.util.Properties().apply {
                    val propsFile = File(rootDir, "local.properties")
                    if (propsFile.exists()) propsFile.inputStream().use { load(it) }
                }.getProperty("MAPBOX_DOWNLOADS_TOKEN", "")
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
