# <your-application-name>

A new Flutter project.

# ⚙️ 環境構築

## 🚨 pedantic_mono の導入

- [pedantic_mono](https://pub.dev/packages/pedantic_mono)

## 🧱 Firebase の導入 + 環境別構築

### アプリのアイコンを設定する

#### Android

`android/app/src/<environment>/res/` ディレクトリで環境ごとに表示するアイコンを設定してください。

- `mipmap-hdpi`
- `mipmap-mdpi`
- `mipmap-xhdpi`
- `mipmap-xxhdpi`
- `mipmap-xxxhdpi`

- `ic_launcher_background.png`
- `ic_launcher_foreground.png`
- `ic_launcher_monochrome.png`
- `ic_launcher.png`

#### iOS/macOS

Xcode で以下のファイルを開き、環境ごとに表示する App Icon(`AppIcon-<Environment>`) を設定してください。

iOS: `Runner/Assets.xcassets`
macOS: `Runner/Resources/Assets.xcassets`

Xcode の Runner > TARGETS > Runner > Build Settings > Asset Catalog Compiler - Options > Primary App Icon Set Name を `AppIcon-$(capitalizedAppEnv)` に変更してください。

#### Web

`lib/web/` ディレクトリに以下のアイコンを配置してください。

- `favicon-<environment>.ico`
- `icons/apple-touch-icon-<environment>.png`
- `icons/icon-192-<environment>.png`
- `icons/icon-192-maskable-<environment>.png`
- `icons/icon-512-<environment>.png`
- `icons/icon-512-maskable-<environment>.png`
- `icons/ogp-<environment>.png`

また、 [ウェブアプリマニフェスト](https://developer.mozilla.org/ja/docs/Web/Progressive_web_apps/Manifest) も環境別に配置してください。

- `manifest-<environment>.json`

### Firebase プロジェクトを作成する

- [Firebase コンソール](https://console.firebase.google.com/)

### `flutterfire config` の実行

- [How to Setup Flutter & Firebase with Multiple Flavors using the FlutterFire CLI](https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/)

> [!NOTE]
> `script/flutterfire-config.sh` を編集してください。

```sh
BASE_BUNDLE_ID=<your-bundle-id>
BASE_PACKAGE_NAME=<your-package-name>
FIREBASE_PROJECT_ID=<your-firebase-project-id>
```

```sh
% script/flutterfire-config.sh dev
🔥 Starting FlutterFire configuration for <environment> environment...

i Found 5 Firebase projects. Selecting project <your-firebase-project-id>.
✔ Which platforms should your configuration support (use arrow keys & space to select)? · android, ios, macos, web, windows
✔ You have to choose a configuration type. Either build configuration (most likely choice) or a target set up. · Build configuration
✔ Please choose one of the following build configurations · Debug
✔ You have to choose a configuration type. Either build configuration (most likely choice) or a target set up. · Build configuration
✔ Please choose one of the following build configurations · Debug
i Firebase android app <your-android-application-id> is not registered on Firebase project <your-firebase-project-id>.
i Registered a new Firebase android app on Firebase project <your-firebase-project-id>.
i Firebase ios app <your-iOS-bundle-id> is not registered on Firebase project <your-firebase-project-id>.
i Registered a new Firebase ios app on Firebase project <your-firebase-project-id>.
i Firebase macos app <your-macOS-bundle-id> registered.
i Firebase web app <your-application-name> (web) is not registered on Firebase project <your-firebase-project-id>.
i Registered a new Firebase web app on Firebase project <your-firebase-project-id>.
i Firebase windows app <your-application-name> (windows) is not registered on Firebase project <your-firebase-project-id>.
i Registered a new Firebase windows app on Firebase project <your-firebase-project-id>.



Firebase configuration file lib/core/config/firebase/firebase_options_development.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
web       ******
android   ******
ios       ******
macos     ******
windows   ******

Learn more about using this file and next steps from the documentation:
 > https://firebase.google.com/docs/flutter/setup

🎉 FlutterFire configuration completed!
```

### Firebase Analytics の Screenview Tracking を無効化する

- [Disable screenview tracking](https://firebase.google.com/docs/analytics/screenviews#disable_screenview_tracking)

以下のファイルを参照してください。

- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `macos/Runner/Info.plist`

### .env ファイルの編集

```txt
placeholder=placeholder
```

### Android のビルド設定

以下のファイルを参照してください。

- `android/app/build.gradle.kts`

### iOS/macOS のビルド設定

#### xcconfig の生成と読み取り

以下のファイルを参照してください。

- `ios/Script/env-to-xcconfig.sh`
- `macos/Script/env-to-xcconfig.sh`

Xcode の `Edit Scheme...` > Build > Pre-actions > New Run Script Action で以下のように設定してください。

- Provide build settings from > `Runner`

```sh
${SRCROOT}/Script/env-to-xcconfig.sh
```

以下のファイルを参照してください。

- `ios/Flutter/Debug.xcconfig`
- `ios/Flutter/Release.xcconfig`
- `macos/Flutter/Flutter-Debug.xcconfig`
- `macos/Flutter/Flutter-Release.xcconfig`

#### アプリケーション名の切り替え

以下のファイルを Xcode で開き、以下の Key, Value に変更してください。

> [!TIP]
> `macos` をXcode で開いた場合は `Runner/Resources/Info.plist` で表示できます。
> また、 `macos` の `Bundle display name` は自身で追加してください。

- `ios/Runner/Info.plist`
- `macos/Runner/Info.plist`

- `Bundle display name`:, `$(applicationName)`
- (iOS のみ)`Bundle name`: `$(applicationName)`

Xcode の Runner > TARGETS > Runner > Build Settings > Packaging > Product Bundle Identifier を `$(bundleId)` に変更してください。
(macOS のみ) Runner > TARGETS > Runner > Build Settings > Packaging > Product Name を `$(applicationName)` に変更してください。

#### GoogleService-Info.plist のコピー

以下のファイルを参照してください。

- `ios/Script/copy-google-service-info-plist.sh`
- `macos/Script/copy-google-service-info-plist.sh`

Xcode の Runner > TARGETS > Runner > Build Phases > New Run Script Phase で以下のように設定し、 `Run Build Tool Plug-ins` の次に配置してください。

- Shell: /bin/sh

```sh
/bin/sh "${SRCROOT}/Script/copy-google-service-info-plist.sh"
```

#### Podfile の編集

以下のファイルを参照してください。

> [!WARN]
> macOS の場合は追加で以下の対応が必要です。
> Xcode の Runner > TARGETS > Runner > General > Minimum Deployments を `macos/Podfile` の `MACOS_DEPLOYMENT_TARGET` と同じバージョンに設定する

- `ios/Podfile`
- `macos/Podfile`
