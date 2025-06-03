import java.util.Base64

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.firebase-perf")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// dart-defines-from-file で渡された情報を Map オブジェクトとして取得する
val dartDefines: Map<String, String> by lazy {
    if (project.hasProperty("dart-defines")) {
        val dartDefinesProperty = project.property("dart-defines") as String

        println("🔍 Raw dart-defines: $dartDefinesProperty")

        dartDefinesProperty
            .split(",")
            .mapNotNull { entry ->
                try {
                    val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
                    println("   Decoded entry: '$decoded'")

                    val trimmed = decoded.trim()
                    if (trimmed.isEmpty()) {
                        println("   ⚠️ Skipping empty line")
                        return@mapNotNull null
                    }

                    if (trimmed.startsWith("#")) {
                        println("   💬 Skipping comment: '$trimmed'")
                        return@mapNotNull null
                    }

                    // key=value形式で分割(値に=が含まれる場合も考慮)
                    val pair = trimmed.split("=", limit = 2)
                    when {
                        pair.size != 2 -> {
                            println("   ⚠️ Skipping invalid entry (no '=' found): '$trimmed'")
                            null
                        }
                        pair[0].trim().isEmpty() -> {
                            println("   ⚠️ Skipping entry with blank key: '$trimmed'")
                            null
                        }
                        pair[0].trim().contains(" ") -> {
                            println("   ⚠️ Skipping entry with space in key: '${pair[0].trim()}'")
                            null
                        }
                        else -> {
                            val key = pair[0].trim()
                            val value = pair[1].trim()

                            // Flutter内部変数をスキップ
                            if (key.lowercase().startsWith("flutter")) {
                                println("   🚫 Skipping Flutter internal variable: '$key'")
                                return@mapNotNull null
                            }

                            // 値のクォート除去
                            val cleanValue = value.removeSurrounding("\"").removeSurrounding("'")

                            println("   ✅ Parsed: '$key' = '$cleanValue'")
                            key to cleanValue
                        }
                    }
                } catch (e: IllegalArgumentException) {
                    println("   ❌ Failed to decode Base64 entry '$entry': Invalid Base64")
                    null
                } catch (e: Exception) {
                    println("   ❌ Failed to process entry '$entry': ${e.message}")
                    null
                }
            }
            .toMap()
    } else {
        println("🔍 No dart-defines property found")
        emptyMap()
    }
}

// 指定した key を持つ環境変数を取得する
fun getEnvProperty(name: String): String {
    val value = dartDefines[name]

    if (value == null) {
        println("❌ Environment variable '$name' is missing!")
        println("   Available keys: ${dartDefines.keys.joinToString(", ")}")
        throw GradleException("Required environment variable '$name' not found")
    }

    if (value.isEmpty()) {
        println("⚠️ Environment variable '$name' is empty (but defined)")
    } else {
        println("✅ $name = '$value'")
    }

    return value
}

android {
    namespace = "com.example.flutter_sandbox"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion
    ndkVersion = getEnvProperty("androidNdkVersion")

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        // applicationId = "com.example.flutter_sandbox"
        applicationId = getEnvProperty("applicationId");

        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // TIP: Firebase Authentication SDK の最小要件に合わせる
        // minSdk = flutter.minSdkVersion
        minSdk = getEnvProperty("androidMinSdkVersion").toInt()
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Specify application name
        resValue("string", "app_name", getEnvProperty("applicationName"))
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// 環境ごとの google-services.json をコピーする
tasks.register("copyGoogleServicesJson") {
    group = "firebase"
    description = "Copy google-services.json based on environment"

    doLast {
        val environment = getEnvProperty("appEnv")
        val source = file("src/$environment/google-services.json")
        val target = file("google-services.json")

        if (source.exists()) {
            source.copyTo(target, overwrite = true)
            println("✅ Copied google-services.json from $environment environment")
        } else {
            println("⚠️ Warning: google-services.json not found for $environment environment")
            println("   Expected location: ${source.absolutePath}")
        }
    }
}

// 環境ごとの res/ ディレクトリをコピーする
tasks.register("copyEnvironmentResources") {
    group = "android"
    description = "Copy res/ directory based on environment (for app icons, etc.)"

    doLast {
        val environment = getEnvProperty("appEnv")
        val source = file("src/$environment/res")
        val target = file("src/main/res")

        if (source.exists()) {
            if (target.exists()) {
                target.deleteRecursively()
                println("🗑️ Deleted existing src/main/res directory")
            }

            source.copyRecursively(target, overwrite = true)
            println("✅ Copied res/ directory from $environment environment")
            println("   Source: ${source.absolutePath}")
            println("   Target: ${target.absolutePath}")
        } else {
            println("⚠️ Warning: res/ directory not found for $environment environment")
            println("   Expected location: ${source.absolutePath}")
            println("   Skipping resource copy...")
        }
    }
}

tasks.named("preBuild") {
    dependsOn("copyGoogleServicesJson", "copyEnvironmentResources")
}

tasks.named("clean") {
    doLast {
        val targetFile = file("google-services.json")
        if (targetFile.exists()) {
            targetFile.delete()
            println("🧹 Cleaned google-services.json")
        }

        val targetDir = file("src/main/res")
        if (targetDir.exists()) {
            targetDir.deleteRecursively()
            println("🧹 Cleaned src/main/res directory")
        }
    }
}