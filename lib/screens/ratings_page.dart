import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ratings').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No rated products yet.\nScan and rate products to see them here!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        final products = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductRatingCard(doc: products[index]);
          },
        );
      },
    );
  }
}

class ProductRatingCard extends StatefulWidget {
  final DocumentSnapshot doc;

  const ProductRatingCard({super.key, required this.doc});

  @override
  State<ProductRatingCard> createState() => _ProductRatingCardState();
}

class _ProductRatingCardState extends State<ProductRatingCard> {
  late TextEditingController _notesController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final data = widget.doc.data() as Map<String, dynamic>;
    _notesController = TextEditingController(text: data['notes'] ?? '');
    _notesController.addListener(_onNotesChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _notesController.dispose();
    super.dispose();
  }

  void _onNotesChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.doc.reference.update({'notes': _notesController.text});
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.doc.data() as Map<String, dynamic>;
    final name = data['name'] ?? 'Unknown Product';
    final brand = data['brand'];
    final quantity = data['quantity'];
    final rating = (data['rating'] ?? 0.0).toDouble();
    final barcode = data['barcode'] ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (brand != null && brand.isNotEmpty)
              Text('Brand: $brand', style: const TextStyle(fontSize: 14)),
            if (quantity != null && quantity.isNotEmpty)
              Text('Quantity: $quantity', style: const TextStyle(fontSize: 14)),
            Text(
              'Barcode: $barcode',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            RatingStars(
              value: rating,
              starCount: 5,
              starSize: 20,
              starColor: Colors.amber,
              starOffColor: const Color(0xffe7e8ea),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Add notes...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
