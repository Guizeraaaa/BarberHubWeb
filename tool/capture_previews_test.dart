import 'dart:io';
import 'dart:ui' as ui;

import 'package:barberhub_web/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final fonts = FontLoader('Barlow');
    for (final weight in [
      'Regular',
      'Medium',
      'SemiBold',
      'Bold',
      'ExtraBold',
    ]) {
      fonts.addFont(rootBundle.load('assets/fonts/Barlow-$weight.ttf'));
    }
    await fonts.load();
    final icons = FontLoader('MaterialIcons');
    icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });

  testWidgets('Capture previews for visual review', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final boundary = GlobalKey();

    Future<void> capture(String name) async {
      await tester.pumpAndSettle();
      final render =
          boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final image = await render.toImage(pixelRatio: 1);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('docs/screenshots/$name.png');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      });
      expect(tester.takeException(), isNull);
    }

    tester.view.physicalSize = const Size(1440, 1000);
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: const BarberHubWebApp(key: ValueKey('desktop')),
      ),
    );
    await capture('desktop');
    await tester.tap(find.text('Experimentar agora'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '10:00'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-demo')));
    await tester.pumpAndSettle();
    expect(find.text('Demonstração concluída!'), findsOneWidget);
    await capture('demo');
    await tester.tap(find.text('Voltar para o site'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Para barbeiros'));
    await capture('dashboard');

    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: const BarberHubWebApp(key: ValueKey('mobile')),
      ),
    );
    await capture('mobile');
    await tester.tap(find.byTooltip('Abrir menu de navegação'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Serviços').hitTestable());
    await capture('mobile-services');
  });
}
