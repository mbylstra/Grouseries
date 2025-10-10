// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/button.dart'
    as _widgetbook_workspace_button;
import 'package:widgetbook_workspace/product_details.dart'
    as _widgetbook_workspace_product_details;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'material',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ElevatedButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Disabled Button',
            builder: _widgetbook_workspace_button.disabledButton,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Primary Button',
            builder: _widgetbook_workspace_button.primaryButton,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Primary Button with Icon',
            builder: _widgetbook_workspace_button.primaryButtonWithIcon,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'OutlinedButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Outlined Button',
            builder: _widgetbook_workspace_button.outlinedButton,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TextButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Text Button',
            builder: _widgetbook_workspace_button.textButton,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'screens',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ProductDetails',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Loading',
            builder:
                _widgetbook_workspace_product_details.productDetailsLoading,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Minimal Product Info',
            builder:
                _widgetbook_workspace_product_details.productDetailsMinimal,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Product Not Found',
            builder:
                _widgetbook_workspace_product_details.productDetailsNotFound,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With Notes',
            builder:
                _widgetbook_workspace_product_details.productDetailsWithNotes,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With Product',
            builder:
                _widgetbook_workspace_product_details.productDetailsWithProduct,
          ),
        ],
      ),
    ],
  ),
];
