import 'package:barberhub_web/features/landing/widgets/booking_demo_dialog.dart';
import 'package:barberhub_web/main.dart';
import 'package:flutter/material.dart';
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
  });
  for (final width in [360.0, 390.0, 768.0, 1024.0, 1440.0]) {
    testWidgets('Landing page sem overflow em $width pixels', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const BarberHubWebApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('Seu estilo.'), findsOneWidget);
      expect(tester.takeException(), isNull);

      final scrollable = find.byType(Scrollable).first;
      for (var index = 0; index < 10; index++) {
        await tester.drag(scrollable, const Offset(0, -650));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      await tester.ensureVisible(find.text('Conheça o projeto'));
      await tester.pumpAndSettle();
      expect(find.text('Conheça o projeto').hitTestable(), findsOneWidget);
    });
  }

  testWidgets('Menu mobile navega até serviços', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BarberHubWebApp());
    await tester.tap(find.byTooltip('Abrir menu de navegação'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Serviços').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('CADA DETALHE CONTA').hitTestable(), findsOneWidget);
  });

  testWidgets('Demonstração exige horário e descarta dados ao fechar', (
    tester,
  ) async {
    await tester.pumpWidget(const BarberHubWebApp());
    await tester.ensureVisible(find.text('Experimentar agora'));
    await tester.tap(find.text('Experimentar agora'));
    await tester.pumpAndSettle();
    expect(find.byType(BookingDemoDialog), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('confirm-demo')))
          .onPressed,
      isNull,
    );

    await tester.ensureVisible(find.widgetWithText(ChoiceChip, '10:00'));
    await tester.tap(find.widgetWithText(ChoiceChip, '10:00'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('confirm-demo')));
    await tester.tap(find.byKey(const ValueKey('confirm-demo')));
    await tester.pumpAndSettle();
    expect(find.text('Demonstração concluída!'), findsOneWidget);
    expect(find.textContaining('às 10:00'), findsOneWidget);

    await tester.tap(find.text('Voltar para o site'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Experimentar agora'));
    await tester.pumpAndSettle();
    expect(find.text('Demonstração concluída!'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('confirm-demo')))
          .onPressed,
      isNull,
    );
  });

  testWidgets('Barba filtra profissionais que não oferecem esse serviço', (
    tester,
  ) async {
    await tester.pumpWidget(const BarberHubWebApp());
    await tester.ensureVisible(find.text('Experimentar agora'));
    await tester.tap(find.text('Experimentar agora'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ChoiceChip, 'Diego Almeida'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('demo-service')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Barba · R\$ 35,00').last);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ChoiceChip, 'Diego Almeida'), findsNothing);
    expect(find.widgetWithText(ChoiceChip, 'Carlos Mendes'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Rafael Souza'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perguntas frequentes revelam a resposta', (tester) async {
    await tester.pumpWidget(const BarberHubWebApp());
    final question = find.text('Posso fazer uma reserva real neste site?');
    await tester.ensureVisible(question);
    await tester.pumpAndSettle();
    await tester.tap(question);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('nenhuma reserva é enviada').hitTestable(),
      findsOneWidget,
    );
  });

  testWidgets('Texto ampliado em celular mantém o layout utilizável', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.4)),
          child: child!,
        ),
        home: const BarberHubWebApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
