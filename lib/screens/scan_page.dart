import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _scannedBarcode;
  String? _productName;
  String? _brand;
  String? _categories;
  String? _quantity;
  String? _imageUrl;
  double _rating = 0;
  bool _isLoading = false;
  String? _errorMessage;
  final MobileScannerController _controller = MobileScannerController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _lookupProduct(String barcode) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _productName = null;
      _brand = null;
      _categories = null;
      _quantity = null;
      _imageUrl = null;
    });

    try {
      final url =
          'https://world.openfoodfacts.org/api/v2/product/$barcode.json';
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'Grouseries/1.0 (Flutter App)'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          final product = data['product'];
          setState(() {
            _productName = product['product_name'] ?? 'Unknown product';
            _brand = product['brands'];
            _categories = product['categories'];
            _quantity = product['quantity'];
            _imageUrl = product['image_front_url'] ?? product['image_url'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Product not found';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch product data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final barcode = barcodeCapture.barcodes.firstOrNull;
    if (barcode != null && barcode.rawValue != null) {
      setState(() {
        _scannedBarcode = barcode.rawValue;
      });
      _lookupProduct(barcode.rawValue!);
    }
  }

  void _resetScanner() {
    setState(() {
      _scannedBarcode = null;
      _productName = null;
      _brand = null;
      _categories = null;
      _quantity = null;
      _imageUrl = null;
      _rating = 0;
      _errorMessage = null;
      _notesController.clear();
    });
  }

  Future<void> _saveProductRating() async {
    if (_scannedBarcode == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('ratings')
          .doc(_scannedBarcode)
          .set({
            'name': _productName,
            'brand': _brand,
            'categories': _categories,
            'quantity': _quantity,
            'barcode': _scannedBarcode,
            'rating': _rating,
            'notes': _notesController.text,
          });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rating saved successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving rating: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(days: 365),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show product info if we have a scanned barcode, otherwise show scanner
    if (_scannedBarcode != null) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                'Scanned Barcode:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _scannedBarcode!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_productName != null) ...[
                if (_imageUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _imageUrl!,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 100);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                const Text(
                  'Product:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _productName!,
                  style: const TextStyle(fontSize: 24, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
                if (_brand != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Brand: $_brand',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (_quantity != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Quantity: $_quantity',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (_categories != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Categories: $_categories',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'Rate this product:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                RatingStars(
                  value: _rating,
                  onValueChanged: (v) {
                    setState(() {
                      _rating = v;
                    });
                    _saveProductRating();
                  },
                  starCount: 5,
                  starSize: 32,
                  starColor: Colors.amber,
                  starOffColor: const Color(0xffe7e8ea),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Add notes about this product...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (_) => _saveProductRating(),
                ),
              ] else if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _resetScanner,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan Another Product'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    }

    // Show scanner
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              MobileScanner(controller: _controller, onDetect: _handleBarcode),
              CustomPaint(painter: ScannerOverlayPainter(), child: Container()),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Point camera at barcode to scan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaWidth = size.width * 0.8;
    final double scanAreaHeight = size.height * 0.3;
    final double left = (size.width - scanAreaWidth) / 2;
    final double top = (size.height - scanAreaHeight) / 2;

    // Draw semi-transparent overlay
    final overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Draw the overlay with a cutout for the scan area
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(Rect.fromLTWH(left, top, scanAreaWidth, scanAreaHeight))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlayPath, overlayPaint);

    // Draw border around scan area
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRect(
      Rect.fromLTWH(left, top, scanAreaWidth, scanAreaHeight),
      borderPaint,
    );

    // Draw corner accents
    final cornerPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    const cornerLength = 30.0;

    // Top-left corner
    canvas.drawLine(
      Offset(left, top),
      Offset(left + cornerLength, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left, top + cornerLength),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(left + scanAreaWidth, top),
      Offset(left + scanAreaWidth - cornerLength, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaWidth, top),
      Offset(left + scanAreaWidth, top + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(left, top + scanAreaHeight),
      Offset(left + cornerLength, top + scanAreaHeight),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top + scanAreaHeight),
      Offset(left, top + scanAreaHeight - cornerLength),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(left + scanAreaWidth, top + scanAreaHeight),
      Offset(left + scanAreaWidth - cornerLength, top + scanAreaHeight),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaWidth, top + scanAreaHeight),
      Offset(left + scanAreaWidth, top + scanAreaHeight - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
