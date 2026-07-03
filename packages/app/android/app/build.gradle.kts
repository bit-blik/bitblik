import com.android.build.api.dsl.ApkSigningConfig
import com.android.build.api.dsl.SigningConfig
import java.io.FileInputStream
import java.util.Base64
import java.security.MessageDigest
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun getKeystoreFile(base64String: String?, hash: String, fileName: String): File {
    if (base64String == null) {
        throw GradleException("Keystore is null")
    }
    val decodedBytes = Base64.getDecoder().decode(base64String)
    val tempFile = File("${layout.buildDirectory.get()}/keystores/${fileName}")
    tempFile.parentFile.mkdirs()
    tempFile.writeBytes(decodedBytes)

    val digest = MessageDigest.getInstance("SHA-256")
    val tmpHash = digest.digest(decodedBytes)
    if (tmpHash.joinToString("") { "%02x".format(it) } != hash) {
        throw GradleException("Keystore hash mismatch")
    }
    return tempFile
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = if (keystorePropertiesFile.exists()) {
    Properties().apply {
        load(FileInputStream(keystorePropertiesFile))
    }
} else {
    Properties()
}

android {
    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("keyFile") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }
}

fun getSigningConfig(): ApkSigningConfig {
    if (!System.getenv("KEYSTORE").isNullOrEmpty()) {
        println("Signing: using env vars")
        val cfg = android.signingConfigs.create("env") {
            keyAlias = System.getenv("KEY_ALIAS")
            keyPassword = System.getenv("KEY_PASSWORD")
            storeFile = System.getenv("KEYSTORE")?.let {
                getKeystoreFile(
                    it,
                    System.getenv("KEYSTORE_SHA256"),
                    "store.jks"
                )
            }
            storePassword = System.getenv("KEYSTORE_PASSWORD")
        }
        return cfg
    }
    println("Signing: using key.properties")
    return android.signingConfigs.getByName("keyFile")
}

// pick signing config
val cfg = getSigningConfig()

android {
    namespace = "app.bitblik"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "app.bitblik"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = cfg
        }
        debug {
            applicationIdSuffix = ".dev"
            signingConfig = cfg
        }
    }

    // Payment-system flavors. Use the matching entrypoint so the app's default
    // payment system is deterministic from process start:
    //   flutter build apk --flavor bitblik -t lib/main_bitblik.dart
    //   flutter build apk --flavor bitway -t lib/main_bitway.dart
    //   flutter build apk --flavor bittwint -t lib/main_bittwint.dart
    flavorDimensions += "system"
    productFlavors {
        create("bitblik") {
            dimension = "system"
            resValue("string", "app_name", "bitblik")
        }
        create("bitway") {
            dimension = "system"
            // Distinct appId; debug build adds `.dev` → me.bitway.dev
            applicationId = "me.bitway"
            resValue("string", "app_name", "bitway")
        }
        create("bittwint") {
            dimension = "system"
            applicationId = "app.bittwint"
            resValue("string", "app_name", "bittwint")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
