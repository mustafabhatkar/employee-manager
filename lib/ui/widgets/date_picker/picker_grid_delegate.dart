import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PickerGridDelegate extends SliverGridDelegate {
  const PickerGridDelegate({
    required this.columnCount,
    required this.rowExtent,
    required this.rowStride,
    this.columnPadding = 0,
    this.rowPadding = 0,
  });

  final int columnCount;

  final double columnPadding;

  final double rowPadding;

  final double rowExtent;

  final double rowStride;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = constraints.crossAxisExtent / columnCount;

    return SliverGridRegularTileLayout(
      // to add padding between cells.
      childCrossAxisExtent: tileWidth - columnPadding,
      childMainAxisExtent: rowExtent - rowPadding,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth ,
      mainAxisStride: rowStride,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(PickerGridDelegate oldDelegate) => false;
}
