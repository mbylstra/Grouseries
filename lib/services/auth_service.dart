import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication;

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  // Auth state stream
  Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  firebase_auth.User? get currentUser => _auth.currentUser;

  // Sign in with Google
  Future<firebase_auth.UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Use Firebase Auth popup
        final firebase_auth.GoogleAuthProvider googleProvider =
            firebase_auth.GoogleAuthProvider();
        googleProvider.addScope('email');

        return await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile (Android/iOS): Use official pattern from Firebase docs
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;

        // Initialize if not already done
        await googleSignIn.initialize();

        // Trigger the authentication flow
        final GoogleSignInAccount googleUser = await googleSignIn
            .authenticate();

        // Obtain auth details from the request
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        // Create a new credential
        final credential = firebase_auth.GoogleAuthProvider.credential(
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
