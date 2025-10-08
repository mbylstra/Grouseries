import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class Note {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromFirestore(firestore.DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      userId: data['userId'] as String,
      content: data['content'] as String,
      createdAt: (data['createdAt'] as firestore.Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'content': content,
      'createdAt': firestore.Timestamp.fromDate(createdAt),
    };
  }
}
