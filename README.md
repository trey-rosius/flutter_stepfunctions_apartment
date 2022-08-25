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
- [Installed and Running Flutter Framework] (https://docs.flutter.dev/get-started/install)
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