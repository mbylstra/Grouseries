import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Use Firebase Auth popup
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');

        return await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile (Android/iOS): Use official pattern from Firebase docs
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;

        // Initialize if not already done
        await googleSignIn.initialize();

        // Trigger the authentication flow
        final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

        // Obtain auth details from the request
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the credential
        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    if (!kIsWeb) {
      await GoogleSignIn.instance.disconnect();
    }
    await _auth.signOut();
  }
}
