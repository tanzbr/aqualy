import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDQ8oC8I_IqhLrhyhN8Mzv-tSKoJNeeP4U",
            authDomain: "aqualy-03btc1.firebaseapp.com",
            projectId: "aqualy-03btc1",
            storageBucket: "aqualy-03btc1.firebasestorage.app",
            messagingSenderId: "362915371993",
            appId: "1:362915371993:web:95c60bda1cef03aab7d7c8"));
  } else {
    await Firebase.initializeApp();
  }
}
