import 'package:cloud_firestore/cloud_firestore.dart' as firestore_package;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import '../models/note.dart' show Note;

class NotesService {
  final firestore_package.FirebaseFirestore firestore =
      firestore_package.FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? get _currentUserId => auth.currentUser?.uid;

  // Get notes stream for the current user
  Stream<List<Note>> getNotesStream() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return firestore
        .collection('notes')
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList(),
        );
  }

  // Add a new note
  Future<void> addNote(String content) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in to add notes');
    }

    final note = Note(
      id: '',
      userId: _currentUserId!,
      content: content,
      createdAt: DateTime.now(),
    );

    await firestore.collection('notes').add(note.toFirestore());
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    await firestore.collection('notes').doc(noteId).delete();
  }
}
