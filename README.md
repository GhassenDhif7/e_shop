# E-Shop Flutter Application

## Introduction

E-Shop is a Flutter application that provides a platform for users to browse and purchase products. The application includes features such as user authentication with Firebase, product listing with search and filter functionalities, a shopping cart, and encrypted storage of user credentials.

## Features

- User authentication with Firebase
- Product listing with dynamic search and price range filter
- Add products to the shopping cart
- View and update cart items
- Securely save and retrieve user credentials using encryption and SharedPreferences

## Project Architecture

The project follows the MVC (Model-View-Controller) architecture pattern:

- **Model**: Contains the data models for products and cart items.
- **View**: Contains the UI components such as pages and widgets.
- **Controller**: Contains the business logic and state management using providers.

### Directory Structure


e_shop/
├── android/
├── build/
├── ios/
├── lib/
│ ├── controller/
│ │ ├── cart_provider.dart
│ │ ├── product_provider.dart
│ ├── model/
│ │ ├── product.dart
│ ├── service/
│ │ ├── firebase_auth_service.dart
│ │ ├── product_repository.dart
│ ├── utils/
│ │ ├── encryption_util.dart
│ ├── view/
│ │ ├── cart_page.dart
│ │ ├── login_page.dart
│ │ ├── product_list_page.dart
│ │ ├── register_page.dart
│ ├── main.dart
├── test/
├── pubspec.yaml


## Configuration

### Prerequisites

- Flutter SDK
- Firebase project setup

### Firebase Configuration

1. Set up a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Add an Android app to your Firebase project and download the `google-services.json` file.
3. Place the `google-services.json` file in the `android/app` directory.
4. Add an iOS app to your Firebase project and download the `GoogleService-Info.plist` file.
5. Place the `GoogleService-Info.plist` file in the `ios/Runner` directory.

### Dependencies

Add the following dependencies to your `pubspec.yaml` file:

### yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_auth: ^3.3.0
  firebase_core: ^1.10.0
  shared_preferences: ^2.0.6
  provider: ^6.0.1
  encrypt: ^5.0.1



## Git

git clone https://github.com/GhassenDhif7/e_shop

cd e_shop

flutter pub get

flutter run

email: Ghassen@gmail.com
password: 12345678
or 
register then login

