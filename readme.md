# MS Store Project

* [Click see video](https://youtu.be/MgPACGTpd8E)


A MS Store project created in flutter using GetX. MS Store supports mobile, clone the appropriate branches mentioned below:

## Getting Started

The MS Store contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
git clone https://github.com/the-best-is-best/ms_store.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Hide Generated Files

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:
```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```

## MS Store Features:

* Splash
* Login
* Home
* Routing
* Theme
* Dio
* GetStorage
* GetX
* Email validator
* Code Generation
* Pretty dio logger
* Dependency Injection
* Dark Theme Support 
* Multilingual Support 
* firebase 
* flutter_facebook_auth
* google sign in
* google maps
* geolocator
* geocoding
* polyline map
* flutter_localizations
* dartz
* cached network image
* svg
* screen util

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
```

Here is the folder structure we have been using in this project

```
lib/app/
       |- constants/
       |- resources/
       |- utils/
       |- bindings
       |- refs
       |- app
       |- di
       |- extensions
       |- components
   |- data/ data layer
   |- domain/ domain layer
   |- presentation/ presentation layer
```