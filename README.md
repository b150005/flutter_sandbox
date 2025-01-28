# flutter_sandbox

A new Flutter project.

# Feature

## Splash Screen

- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

> [!WARNING]
> `canvaskit`, `skwasm` を使用している場合は**印刷プレビューでスプラッシュ画面が表示される**弊害があります。

```sh
b150005@b150005mac flutter_sandbox % dart run flutter_native_splash:create
Building package executable... 
Built flutter_native_splash:create.
[Android] Creating default splash images
[Android] Updating launch background(s) with splash image path...
[Android]  - android/app/src/main/res/drawable/launch_background.xml
[Android]  - android/app/src/main/res/drawable-v21/launch_background.xml
[Android] Updating styles...
[Android]  - android/app/src/main/res/values-v31/styles.xml
[Android] No android/app/src/main/res/values-v31/styles.xml found in your Android project
[Android] Creating android/app/src/main/res/values-v31/styles.xml and adding it to your Android project
[Android]  - android/app/src/main/res/values-night-v31/styles.xml
[Android] No android/app/src/main/res/values-night-v31/styles.xml found in your Android project
[Android] Creating android/app/src/main/res/values-night-v31/styles.xml and adding it to your Android project
[Android]  - android/app/src/main/res/values/styles.xml
[Android]  - android/app/src/main/res/values-night/styles.xml
[iOS] Creating  images
[iOS] Updating ios/Runner/Info.plist for status bar hidden/visible
[Web] Creating images
[Web] Creating images
[Web] Creating background images
[Web] Creating CSS
[Web] Updating index.html

✅ Native splash complete.
Now go finish building something awesome! 💪 You rock! 🤘🤩
Like the package? Please give it a 👍 here: https://pub.dev/packages/flutter_native_splash
```