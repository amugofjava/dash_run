import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

var s = 32.0;
var sp;
var p = Paint();
var rd = Random();
List<N> net;
List<D> dsh;
int v = 2;
int scn = 0;
int sr = 0;
int mo = 0;

Future<ui.Image> load() async {
  ByteData d = await rootBundle.load("a/s.png");
  ui.Codec c = await ui.instantiateImageCodec(d.buffer.asUint8List());
  ui.FrameInfo fi = await c.getNextFrame();
  return fi.image;
}

void main() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) => runApp(A()));

class A extends StatelessWidget {
  G g = G();

  @override
  Widget build(BuildContext c) => MediaQuery(
        data: MediaQueryData.fromWindow(ui.window),
        child: Container(
          color: Colors.blue[200],
          child: SafeArea(
            child: GestureDetector(
                onTap: () => g.f(),
                onHorizontalDragUpdate: (DragUpdateDetails d) =>
                    g.m(d.globalPosition.dx),
                behavior: HitTestBehavior.translucent,
                child: g),
          ),
        ),
      );
}

class G extends SingleChildRenderObjectWidget {
  R r;

  @override
  RenderObject createRenderObject(BuildContext c) => r = R();

  void m(double x) {
    if (scn == 2) {
      sr = 0;
      scn = 1;
      return;
    }

    r.m(x);
  }

  void f() {
    if (scn == 0) {
      scn = 1;
    } else {
      r.f();
    }
  }
}

class R extends RenderBox {
  double x;
  int i;

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();
    if (attached) nl();
  }

  void nl() {
    dsh = [];
    net = [];
    v++;

    for (var x = 0.0; x < 10; x++) {
      dsh.add(D((x * -s), constraints.biggest));
    }
  }

  void go() {
    v = 2;
    mo = rd.nextInt(3);
    nl();
  }

  void t(Duration t) {
    if (!attached) return;
    st();
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner w) {
    super.attach(w);
    load().then((i) {
      sp = i;
      st();
    });
  }

  @override
  void detach() {
    super.detach();
    SchedulerBinding.instance.cancelFrameCallbackWithId(i);
  }

  void st() => i = SchedulerBinding.instance.scheduleFrameCallback(t);
  void f() => net.add(N(x));
  void m(double x) => this.x = x;

  void sc(Canvas c) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.black, fontSize: 18.0),
        text: "Score ${sr}");
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(c, new Offset(12.0, 16.0));
  }

  @override
  void paint(PaintingContext cc, Offset o) {
    if (sp == null) return;

    cc.setIsComplexHint();

    var c = cc.canvas;
    var y = size.height - 48;
    var h = size;

    if (scn == 0) {
      c.drawImageRect(sp, Rect.fromLTWH(0, 32, 600.0, 960.0),
          Rect.fromLTWH(0, 0, h.width, h.height), p);
      return;
    }

    if (scn == 2) {
      c.drawImageRect(sp, Rect.fromLTWH(0, 992, 600.0, 960.0),
          Rect.fromLTWH(0, 0, h.width, h.height), p);
      sc(c);
      return;
    }

    if (x == null) x = size.width / 2 - 16.0;
    if (x < 0) x = 0;
    if (x > h.width - s) x = h.width - s;
    if (dsh.every((x) => x.d)) nl();

    c.drawImageRect(sp, Rect.fromLTWH(0, 1952, 600.0, 960.0),
        Rect.fromLTWH(0, 0, h.width, h.height), p);

    c.drawImageRect(sp, Rect.fromLTWH(64 + (mo * 32.0), 0, s, s),
        Rect.fromLTWH(x, y, 32, 32), p);

    sc(c);

    dsh.forEach((f) {
      f.u(c);
      if (!f.d && f.x >= x && f.x <= x + s && f.y + s >= y) {
        scn = 2;
        go();
        return;
      }
    });

    net.forEach((f) => f.paint(c, h));
  }

  @override
  bool get isRepaintBoundary => true;
}

class N {
  var x, y;
  var d = false;

  N(this.x);

  void paint(Canvas c, Size z) {
    if (d) return;

    y = y ?? z.height - 60;

    if (y < 0) {
      d = true;
    } else {
      c.drawImageRect(
          sp, Rect.fromLTWH(32, 0, 32, 32), Rect.fromLTWH(x, y, s, s), p);

      y -= 6;

      for (var u in dsh) {
        if (x >= u.x && x <= u.x + s && y >= u.y && y <= u.y + s && !u.d) {
          this.d = u.d = true;
          sr += (z.height - y).ceil();
          return;
        }
      }
    }
  }
}

class D {
  double x, y;
  int r = 0;
  Size z;
  bool d = false;

  D(this.x, this.z);

  void u(Canvas c) {
    y = y ?? (z.height % s) + 16;

    if (!d) {
      if (x > 0) {
        c.drawImageRect(
            sp, Rect.fromLTWH(0, 0, 32, 32), Rect.fromLTWH(x, y, s, s), p);
      }
      if (r == 0) {
        x += v;

        if (x > z.width - s) {
          r = 1;
          x = z.width - s;
          y += s;
        }
      } else {
        x -= v;

        if (x < 0) {
          r = 0;
          y += s;
        }
      }
    }
  }
}
