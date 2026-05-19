import com.android.build.api.dsl.ApkSigningConfig
import com.android.build.api.dsl.SigningConfig
import org.jetbrains.kotlin.gradle.targets.js.toHex
import java.io.FileInputStream
import java.util.Base64
import java.security.MessageDigest
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
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
    if (tmpHash.toHex() != hash) {
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
        create("keyFile") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile =
                keystoreProperties.getProperty("storeFile")?.let {
                    file(it)
                }
            storePassword = keystoreProperties.getProperty("storePassword")
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
    ndkVersion = "27.0.12077973" // Updated NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
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
}

flutter {
    source = "../.."
}
