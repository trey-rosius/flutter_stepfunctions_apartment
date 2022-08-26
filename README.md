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

## Initialize Amplify 
From the root of your application, run the command
`amplify init`

![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/f.png)

Give your project a name. 
When you installed and configured amplify cli, you created a profile. Please choose that profile when the cli prompts
you to choose an authentication method.

![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/g.png)

You should see a similar screen once you are done.

![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/h.png)

Amplify creates a file called `amplifyconfiguration.dart` in the `libs` folder.

We have to populate this config file with our backend configuration.

## Get Amplify Config From Appsync
Open up Appsync on the aws console and navigate to your project.

![alt text](https://raw.githubusercontent.com/trey-rosius/flutter_stepfunctions_apartment/master/assets/images/i.png)

Download the configuration by clicking on the orange `Download Config` button.

Now open up `amplifyconfiguration.dart` and fill in the details like so

```dart
const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "cdkMomoApi": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://xxxxxxxxxxxxxxx.appsync-api.us-east-2.amazonaws.com/graphql",
                    "region": "us-east-2",
                    "authorizationType": "API_KEY",
                    "apiKey":"da2-5pn6oexoxxxxxxxxx"
                    
                }
            }
        }
    }
}''';
```
Change the appsync name from `cdkMomoApi` to yours, alongside the rest of the details.

## Updating main.dart
Open your `main.dart` file and initialize Amplify and Amplify API.

```dart
import 'package:apartment_complex/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<void> _configureAmplify() async {

    // Add any Amplify plugins you want to use
    final authPlugin =  AmplifyAPI();
    await Amplify.addPlugin(authPlugin);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      if (kDebugMode) {
        print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
      }
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartments',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}


```

## GraphQL Mutation
Remember our graphql mutation expects an ID and the step functions arn. Here's how to create a Graphql mutation in flutter with Amplify.

```dart
 Future<void> startStepFunctions(String id, String arn) async {
    try{
      String graphqlDoc =
          '''
          mutation add(\$id:ID!
                        \$arn:String!) {
  addStepFunction(input: {id: \$id, arn: \$arn}) {
    id
    arn
  }
}
          
          ''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
            document: graphqlDoc,
            apiName: "cdkMomoApi",
            variables: {
              "id":id,
              "arn":arn
            }

      ));
          var response = await operation.response;

          var data = response.data;

      if (kDebugMode) {
        print('Mutation result is$data');
        print('Mutation error: ${response.errors}');
      }



    }catch(ex){
      if (kDebugMode) {
        print(ex.toString());
      }
    }
  }


```
Please grab the complete code and try it out.

