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

Xcode の Runner > TARGETS > Runner > Build Settings > Asset Catalog Compiler - Options > Primary App Icon Set Name を `AppIcon-$(CAPITALIZED_APP_ENV)` に変更してください。

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

### Firebase プロジェクトの初期化

以下のファイル・ディレクトリを参照してください。

- `firebase.json`
- `.firebaserc`
- `firebase/`

> [!TIP]
> 動的にファイルを生成したい場合は、以下のように `firebase init` コマンドを実行してください。
> コマンド実行後 `firebase.json` を編集してください。

```sh
# プロジェクトの一覧を取得
% firebase projects:list
✔ Preparing the list of your Firebase projects
┌──────────────────────┬─────────────────────────────────┬────────────────┬──────────────────────┐
│ Project Display Name │ Project ID                      │ Project Number │ Resource Location ID │
├──────────────────────┼─────────────────────────────────┼────────────────┼──────────────────────┤
│ flutter-sandbox-dev  │ flutter-sandbox-dev-*****       │ ************   │ [Not specified]      │
├──────────────────────┼─────────────────────────────────┼────────────────┼──────────────────────┤
│ flutter-sandbox      │ flutter-sandbox-***** (current) │ ************   │ [Not specified]      │
├──────────────────────┼─────────────────────────────────┼────────────────┼──────────────────────┤
│ flutter-sandbox-stg  │ flutter-sandbox-stg-*****       │ ************   │ [Not specified]      │
└──────────────────────┴─────────────────────────────────┴────────────────┴──────────────────────┘

# Firebase プロジェクトの初期化
% firebase init

     ######## #### ########  ######## ########     ###     ######  ########
     ##        ##  ##     ## ##       ##     ##  ##   ##  ##       ##
     ######    ##  ########  ######   ########  #########  ######  ######
     ##        ##  ##    ##  ##       ##     ## ##     ##       ## ##
     ##       #### ##     ## ######## ########  ##     ##  ######  ########

You're about to initialize a Firebase project in this directory:

  /Users/b150005/Development/Apps/Flutter/flutter_sandbox

Before we get started, keep in mind:

  * You are initializing within an existing Firebase project directory

✔ Which Firebase features do you want to set up for this directory? Press Space to select features, then Enter to confirm your choices. Data Connect: Set up a 
Firebase Data Connect service, Firestore: Configure security rules and indexes files for Firestore, Functions: Configure a Cloud Functions directory and its 
files, Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys, Storage: Configure a security rules file for Cloud Storage, 
Emulators: Set up local emulators for Firebase products, Remote Config: Configure a template file for Remote Config, Extensions: Set up an empty Extensions 
manifest, Realtime Database: Configure a security rules file for Realtime Database and (optionally) provision default instance

=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add, 
but for now we'll just set up a default project.

i  Using project flutter-sandbox-dev-****** (flutter-sandbox-dev)

=== Dataconnect Setup
i  dataconnect: ensuring required API sqladmin.googleapis.com is enabled...
✔  dataconnect: required API sqladmin.googleapis.com is enabled
i  dataconnect/dataconnect.yaml is unchanged
i  dataconnect/schema/schema.gql is unchanged
✔ File dataconnect/connector/connector.yaml already exists. Overwrite? Yes
✔  Wrote dataconnect/connector/connector.yaml
i  dataconnect/connector/queries.gql is unchanged
i  dataconnect/connector/mutations.gql is unchanged
✔  Detected FLUTTER app in directory /Users/b150005/Development/Apps/Flutter/flutter_sandbox
✔ Which connector do you want set up a generated SDK for? flutter-sandbox/default
i  Writing your new SDK configuration to /Users/b150005/Development/Apps/Flutter/flutter_sandbox/dataconnect/connector/connector.yaml
✔ File dataconnect/connector/connector.yaml already exists. Overwrite? Yes
✔  Wrote dataconnect/connector/connector.yaml
[winston] Unknown logger level: DEBUG
I0604 22:53:59.138593   38889 codegen.go:82] [connector "default" dartSdk] Generating sources into "/Users/b150005/Development/Apps/Flutter/flutter_sandbox/dataconnect-generated/dart/default_connector"
I0604 22:53:59.140202   38889 dartgen.go:651] Started Dart code generation for connector default
I0604 22:53:59.144520   38889 generate.go:40] Generated all sources. Writing them to disk...
I0604 22:53:59.145453   38889 collector.go:107] connector "default" dartSdk wrote into "/Users/b150005/Development/Apps/Flutter/flutter_sandbox/dataconnect-generated/dart/default_connector"
Generated sources: default.dart [585B] README.md [837B] 

i  Generated SDK code for default
✔  If you'd like to add more generated SDKs to your app your later, run firebase init dataconnect:sdk again
i  If you'd like to provision a CloudSQL Postgres instance on the Firebase Data Connect no-cost trial:
1. Please upgrade to the pay-as-you-go (Blaze) billing plan. Visit the following page:
     https://console.firebase.google.com/project/flutter-sandbox-dev-******/usage/details
2. Run firebase init dataconnect again to configure the Cloud SQL instance.
3. Run firebase deploy --only dataconnect to deploy your Data Connect service.

=== Firestore Setup

Firestore Security Rules allow you to define how and when to allow
requests. You can keep these rules in your project directory
and publish them with firebase deploy.

✔ What file should be used for Firestore Rules? firestore.rules

Firestore indexes allow you to perform complex queries while
maintaining performance that scales with the size of the result
set. You can keep index definitions in your project directory
and publish them with firebase deploy.

✔ What file should be used for Firestore indexes? firestore.indexes.json

=== Functions Setup
Let's create a new codebase for your functions.
A directory corresponding to the codebase will be created in your project
with sample code pre-configured.

See https://firebase.google.com/docs/functions/organize-functions for
more information on organizing your functions using codebases.

Functions can be deployed with firebase deploy.

✔ What language would you like to use to write Cloud Functions? TypeScript
✔ Do you want to use ESLint to catch probable bugs and enforce style? No
✔  Wrote functions/package.json
✔  Wrote functions/tsconfig.json
✔  Wrote functions/src/index.ts
✔  Wrote functions/.gitignore
✔ Do you want to install dependencies with npm now? No

=== Hosting Setup

Your public directory is the folder (relative to your project directory) that
will contain Hosting assets to be uploaded with firebase deploy. If you
have a build process for your assets, use your build's output directory.

✔ What do you want to use as your public directory? build/web
✔ Configure as a single-page app (rewrite all urls to /index.html)? No
✔ Set up automatic builds and deploys with GitHub? No
✔  Wrote build/web/404.html
✔  Wrote build/web/index.html

=== Storage Setup

Firebase Storage Security Rules allow you to define how and when to allow
uploads and downloads. You can keep these rules in your project directory
and publish them with firebase deploy.

✔ What file should be used for Storage Rules? storage.rules
✔  Wrote storage.rules

=== Emulators Setup
✔ Which Firebase emulators do you want to set up? Press Space to select emulators, then Enter to confirm your choices. Authentication Emulator, Functions 
Emulator, Firestore Emulator, Database Emulator, Hosting Emulator, Pub/Sub Emulator, Storage Emulator, Eventarc Emulator, Data Connect Emulator, Cloud Tasks 
Emulator
✔ Which port do you want to use for the auth emulator? 9099
✔ Which port do you want to use for the functions emulator? 5001
✔ Which port do you want to use for the firestore emulator? 8080
✔ Which port do you want to use for the database emulator? 9000
✔ Which port do you want to use for the hosting emulator? 5002
✔ Which port do you want to use for the pubsub emulator? 8085
✔ Which port do you want to use for the storage emulator? 9199
✔ Which port do you want to use for the eventarc emulator? 9299
✔ Which port do you want to use for the dataconnect emulator? 9399
✔ Do you want to persist Postgres data from the Data Connect emulator between runs? Data will be saved to 
dataconnect/.dataconnect/pgliteData. You can change this directory by editing 'firebase.json#emulators.dataconnect.dataDir'. Yes
✔ Which port do you want to use for the tasks emulator? 9499
✔ Would you like to enable the Emulator UI? Yes
✔ Which port do you want to use for the Emulator UI (leave empty to use any available port)? 4000
✔ Would you like to download the emulators now? Yes
i  firestore: downloading cloud-firestore-emulator-v1.19.8.jar...
i  database: downloading firebase-database-emulator-v4.11.2.jar...
i  pubsub: downloading pubsub-emulator-0.8.14.zip...
i  storage: downloading cloud-storage-rules-runtime-v1.1.3.jar...
i  ui: downloading ui-v1.15.0.zip...

=== Remoteconfig Setup
✔ What file should be used for your Remote Config template? remoteconfig.template.json

=== Extensions Setup

=== Database Setup
i  database: ensuring required API firebasedatabase.googleapis.com is enabled...
✔  database: required API firebasedatabase.googleapis.com is enabled


Firebase Realtime Database Security Rules allow you to define how your data should be
structured and when your data can be read from and written to.

✔ What file should be used for Realtime Database Security Rules? database.rules.json
✔  Database Rules for flutter-sandbox-dev-****** have been written to database.rules.json.
Future modifications to database.rules.json will update Realtime Database Security Rules when you run
firebase deploy.

i  Writing configuration info to firebase.json...
i  Writing project information to .firebaserc...

✔  Firebase initialization complete!
```

### Cloud Functions for Firebase プロジェクトの設定

以下のファイルを参照してください。

- `firebase/functions/package.json`
- `firebase/functions/tsconfig.json`
- `firebase/functions/biome.json`

#### Biome.js の導入

```sh
# Biome.js のインストール
% bun add -d @biomejs/biome

# biome.json の生成
% bunx biome init
```

#### Secretlint の導入

```sh
% bun add -d secretlint @secretlint/secretlint-rule-preset-recommend
```

### Firebase Analytics の Screenview Tracking を無効化する

- [Disable screenview tracking](https://firebase.google.com/docs/analytics/screenviews#disable_screenview_tracking)

以下のファイルを参照してください。

- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `macos/Runner/Info.plist`

### 🚧 .env ファイルの編集

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

- `Bundle display name`:, `$(APP_NAME)`
- (iOS のみ)`Bundle name`: `$(APP_NAME)`

Xcode の Runner > TARGETS > Runner > Build Settings > Packaging > Product Bundle Identifier を `$(BUNDLE_ID)` に変更してください。
(macOS のみ) Runner > TARGETS > Runner > Build Settings > Packaging > Product Name を `$(APP_NAME)` に変更してください。

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

## 🌐 l10n

- [Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

以下のファイルを参照してください。

- `lib/core/config/l10n/arb/app_en.arb`
- `lib/core/config/l10n/arb/app_ja.arb`

`flutter gen-l10n` コマンドを実行することで、 ARB → Dart ファイルに変換されます。

# 📚 参考リポジトリ

- [bizz84 / starter_architecture_flutter_firebase](https://github.com/bizz84/starter_architecture_flutter_firebase)
- [swarajkumarsingh / flutter_boilerplate_project](https://github.com/swarajkumarsingh/flutter_boilerplate_project)
- [mrusamamuzaffar / lets_chat](https://github.com/mrusamamuzaffar/lets_chat)
- [AkshatRai-21 / HommieChat](https://github.com/AkshatRai-21/HommieChat)
- [julienlebren / flutter_firebase_phone_auth_riverpod](https://github.com/julienlebren/flutter_firebase_phone_auth_riverpod)
- [fireship-io / riverpod-firebase-demo](https://github.com/fireship-io/riverpod-firebase-demo)
- [lucavenir / go_router_riverpod](https://github.com/lucavenir/go_router_riverpod)