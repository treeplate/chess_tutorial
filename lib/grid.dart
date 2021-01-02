import 'package:flutter/material.dart';

class GridDrawer extends StatelessWidget {
  GridDrawer(this.grid, this.width);
  final List<GridCell> grid;
  final int width;
  int get height => grid.length ~/ width;
  Widget build(BuildContext context) {
    //print("DRW");
    return CustomPaint(
      painter: GridPainter(
        width,
        height,
        grid,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  GridPainter(this.width, this.height, this.grid);
  final int width;
  final int height;
  final List<GridCell> grid;
  bool shouldRepaint(CustomPainter _) => true;
  void paint(Canvas canvas, Size size) {
    print("PNT$size");
    double cellDim = 50;
    Size cellSize = Size(cellDim, cellDim);
    bool white = true;
    for (int y = 0; y < height; y += 1) {
      for (int x = 0; x < width; x += 1) {
        canvas.drawRect(
          Offset(x * cellDim, y * cellDim) & cellSize,
          Paint()..color = white ? Colors.white : Colors.black,
        );
        canvas.drawRect(
          Offset(x * cellDim, y * cellDim) & cellSize,
          (Paint()..style = PaintingStyle.stroke)..strokeWidth = 1,
        );
        grid[x + (y * width)].paint(
          canvas,
          cellSize,
          Offset(x * cellDim, y * cellDim),
        );
        white = !white;
      }
      if ((width / 2) % 1 == 0) {
        white = !white;
      }
    }
  }
}

abstract class GridCell {
  void paint(Canvas canvas, Size size, Offset offset);
}

class EmptyGridCell extends GridCell {
  String toString() => "gsNothing";
  void paint(Canvas canvas, Size size, Offset offset) {}
}
