import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  // Get notes stream for the current user
  Stream<List<Note>> getNotesStream() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return _firestore
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

    await _firestore.collection('notes').add(note.toFirestore());
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
