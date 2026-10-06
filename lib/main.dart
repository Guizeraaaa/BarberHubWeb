import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'features/landing/pages/landing_page.dart';
import 'features/landing/theme/landing_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Disponibiliza a página para navegação por teclado e leitores de tela.
  SemanticsBinding.instance.ensureSemantics();
  runApp(const BarberHubWebApp());
}

class BarberHubWebApp extends StatelessWidget {
  const BarberHubWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberHub — Seu estilo. Seu horário.',
      debugShowCheckedModeBanner: false,
      theme: LandingTheme.theme,
      home: const LandingPage(),
    );
  }
}
