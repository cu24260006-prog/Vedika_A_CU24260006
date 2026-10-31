LAB SHEET 10 – FLUTTER FIREBASE AUTHENTICATION AND CLOUD FIRESTORE

Contains 15 separate Dart files (1.dart to 15.dart), following the uploaded practical list.

IMPORTANT FIREBASE SETUP
1. Create a Firebase project at https://console.firebase.google.com/
2. Add your Android app and configure FlutterFire in your Flutter project.
3. Run: flutterfire configure
4. Add packages: firebase_core, firebase_auth, cloud_firestore
5. Enable Email/Password sign-in in Firebase Authentication.
6. Create/enable Cloud Firestore in Firebase Console.
7. Copy one numbered Dart file into lib/main.dart of your configured project.
8. Ensure Android internet permission is enabled.

Each practical is a separate example. Replace no Firebase configuration by
guesswork: FlutterFire generates firebase_options.dart for your own project.
These are source examples and have not been run against your Firebase project.

Required packages:
  firebase_core
  firebase_auth
  cloud_firestore

Firebase Console setup is required before running these programs. Practical 1 and all app examples call Firebase.initializeApp(); if your FlutterFire setup generates firebase_options.dart, import it and use Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).
