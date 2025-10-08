import 'package:flutter/material.dart';
import 'package:grouseries/screens/scan_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Loading', type: ProductDetails)
Widget productDetailsLoading(BuildContext context) {
  final controller = TextEditingController();
  return ProductDetails(
    barcode: '5000159484695',
    isLoading: true,
    rating: 0,
    notesController: controller,
    onRatingChanged: (_) {},
    onReset: () {},
  );
}

@widgetbook.UseCase(name: 'With Product', type: ProductDetails)
Widget productDetailsWithProduct(BuildContext context) {
  final controller = TextEditingController(text: 'Great product!');
  return ProductDetails(
    barcode: '5000159484695',
    productName: 'Cadbury Dairy Milk',
    brand: 'Cadbury',
    categories: 'Snacks, Chocolate, Milk chocolate',
    quantity: '200g',
    imageUrl:
        'https://images.openfoodfacts.org/images/products/500/015/948/4695/front_en.3.400.jpg',
    isLoading: false,
    rating: 4.5,
    notesController: controller,
    onRatingChanged: (_) {},
    onReset: () {},
  );
}

@widgetbook.UseCase(name: 'Product Not Found', type: ProductDetails)
Widget productDetailsNotFound(BuildContext context) {
  final controller = TextEditingController();
  return ProductDetails(
    barcode: '1234567890123',
    isLoading: false,
    errorMessage: 'Product not found',
    rating: 0,
    notesController: controller,
    onRatingChanged: (_) {},
    onReset: () {},
  );
}

@widgetbook.UseCase(name: 'Minimal Product Info', type: ProductDetails)
Widget productDetailsMinimal(BuildContext context) {
  final controller = TextEditingController();
  return ProductDetails(
    barcode: '9876543210987',
    productName: 'Unknown Product',
    isLoading: false,
    rating: 2.0,
    notesController: controller,
    onRatingChanged: (_) {},
    onReset: () {},
  );
}

@widgetbook.UseCase(name: 'With Notes', type: ProductDetails)
Widget productDetailsWithNotes(BuildContext context) {
  final controller = TextEditingController(
    text: 'Too sweet for my taste. Good for kids though. The packaging is nice.',
  );
  return ProductDetails(
    barcode: '5000159484695',
    productName: 'Lindt Excellence Dark 70%',
    brand: 'Lindt',
    quantity: '100g',
    isLoading: false,
    rating: 3.5,
    notesController: controller,
    onRatingChanged: (_) {},
    onReset: () {},
  );
}
