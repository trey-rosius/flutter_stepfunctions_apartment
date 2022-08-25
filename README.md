# Invoking a step functions workflow from mobile application built with Amplify and Flutter

In the first part of this series, we built a step functions workflow for a simple apartment booking scenario using the AWS Step functions low code visual editor.

In the second part of this series, we built the same workflow using CDK as IaC, Appsync and python, while invoking the step functions execution from a Lambda function.

In the third part of this series, we built the same workflow using SAM as IaC, Appsync and python, while invoking the step functions execution from a Lambda function.

In this post, we'll be invoking the step functions workflow we created above from a mobile app built with amplify and flutter.a

## Preview
![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/screenshot.png)



## Solutions Architecture
![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/sol_architecture.png)

## Prerequisite
In-order to properly follow through successfully with this tutorial, you'll need to have checked through these prequisites.
- [Installed and Running Amplify CLI](https://docs.amplify.aws/cli/start/install/)
- [Installed and Running Flutter Framework](https://docs.flutter.dev/get-started/install)
- Successfully completed and deployed any of the applications in PART 2 Or 3
- Installed Android Studio or Vscode

## NB
This isn't a flutter tutorial, but rather a tutorial on how to invoke step functions from a flutter application.
So i'll assume you already know how to use Flutter.
If you don't, don't worry. You can always start [here](https://docs.flutter.dev/get-started/install)

## Setup FullStack Project
### Create a new flutter application

```
flutter create amplified_todo
```

### Add Amplify to your application
Go to pub.dev and search for amplify flutter and copy the package and version
![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/amplify_flutter.png)

In your root directory, search for `pubspec.yaml` file and add the amplify package to it.

```
amplify_flutter: ^0.6.6
```

Since we'll be accessing the GraphQl Api we created in PART 3 or PART 4 of this series, we also need to install
the amplify api library.

```
amplify_api: ^0.6.6
```
Therefore, my `pubspec.yaml` dev_dependencies has this structure now.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^2.0.0
  amplify_flutter: ^0.6.0
  amplify_api: ^0.6.0
```
Install the dependencies by running the following command. Depending on your development environment, 
you may perform this step via your IDE (or it may even be performed for you automatically)

```
flutter pub get
```

### Update Target Android SDK Version
From your project root, navigate to the `android/app/` directory and modify build.gradle using a text editor of your choice and update the target Android SDK version to 21 or higher:

```
minSdkVersion 21
```

If you are using Flutter 2.10 or above, you will need to ensure that your app supports an up-to-date Kotlin version. This will typically be version 1.5.31 or higher.

You can do this by updating the Kotlin version in your app's android/build.gradle file:

```
buildscript {
    ext.kotlin_version = '1.5.31'
    ...
}

```
## Get Amplify Config From Appsync

## Updating main.dart
Open your `main.dart` file and initialize Amplify and Amplify API.
