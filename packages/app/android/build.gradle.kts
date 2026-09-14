import com.android.build.api.variant.LibraryAndroidComponentsExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // flutter_webrtc_zxing 0.2.1 pins API 34, but flutter_webrtc requires API 36.
    if (name == "flutter_webrtc_zxing") {
        pluginManager.withPlugin("com.android.library") {
            extensions.configure<LibraryAndroidComponentsExtension> {
                finalizeDsl { library ->
                    library.compileSdk = maxOf(library.compileSdk ?: 0, 36)
                }
            }
        }
    }

    // mobile_scanner 7.2.1 skips KGP on AGP 9 even when built-in Kotlin is off.
    if (name == "mobile_scanner" &&
        providers.gradleProperty("android.builtInKotlin").orNull == "false") {
        pluginManager.withPlugin("com.android.library") {
            pluginManager.apply("org.jetbrains.kotlin.android")
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
