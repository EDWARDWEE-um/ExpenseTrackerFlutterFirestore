import 'package:flutter/material.dart';

final _allFontWeight = List.from(FontWeight.values);

extension TextStyleExtension on TextStyle? {
  TextStyle? scaleFontWeight(int scaleValue) {
    if (scaleValue == 0) {
      return this;
    }

    final currentIndex = this?.fontWeight?.index ?? FontWeight.w400.index;
    final newFontWeightIndex = currentIndex + scaleValue;
    if (newFontWeightIndex <= 0) {
      return this?.copyWith(fontWeight: _allFontWeight[0]);
    }

    if (newFontWeightIndex >= _allFontWeight.length) {
      return this?.copyWith(fontWeight: _allFontWeight[_allFontWeight.length - 1]);
    }

    return this?.copyWith(fontWeight: _allFontWeight[newFontWeightIndex]);
  }
}
