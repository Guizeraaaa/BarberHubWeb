import 'package:flutter/material.dart';

import '../theme/landing_theme.dart';
import 'booking_demo_dialog.dart';
import 'landing_components.dart';
import 'scheduling_preview.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onHowItWorks});

  final VoidCallback onHowItWorks;

  @override
  Widget build(BuildContext context) => ContentWidth(
    vertical: 38,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final copy = _copy(context, wide);
        final preview = _preview(wide);
        return Column(
          children: [
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 11, child: copy),
                  const SizedBox(width: 32),
                  Expanded(flex: 10, child: preview),
                ],
              )
            else ...[
              copy,
              const SizedBox(height: 38),
              preview,
            ],
            const SizedBox(height: 42),
            Container(
              padding: const EdgeInsets.only(top: 24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: LandingTheme.line)),
              ),
              child: Wrap(
                spacing: wide ? 56 : 24,
                runSpacing: 18,
                children: const [
                  _Step('01', 'Escolha seu serviço'),
                  _Step('02', 'Encontre seu barbeiro'),
                  _Step('03', 'Reserve seu horário'),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  Widget _copy(BuildContext context, bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          border: Border.all(color: LandingTheme.line),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Eyebrow('MAIS TEMPO PARA VOCÊ', dot: true),
      ),
      const SizedBox(height: 28),
      Semantics(
        header: true,
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Seu estilo.\nSeu horário.\n'),
              TextSpan(
                text: 'Sem complicar.',
                style: TextStyle(color: LandingTheme.orangeDark),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: wide
                ? 78
                : (MediaQuery.sizeOf(context).width < 600 ? 49 : 70),
            fontWeight: FontWeight.w800,
            height: 1.02,
            letterSpacing: wide ? -3.3 : -2,
          ),
        ),
      ),
      const SizedBox(height: 26),
      const ConstrainedCopy(
        'O cuidado de sempre, com a praticidade que faltava. Encontre seu barbeiro e organize seu próximo corte em poucos toques.',
      ),
      const SizedBox(height: 30),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ActionButton(
            label: 'Experimentar agora',
            onPressed: () => showBookingDemo(context),
          ),
          TextButton.icon(
            onPressed: onHowItWorks,
            icon: const Icon(Icons.play_circle_outline_rounded, size: 21),
            label: const Text('Como funciona'),
          ),
        ],
      ),
      const SizedBox(height: 24),
      const Row(
        children: [
          Icon(Icons.touch_app_outlined, size: 17, color: LandingTheme.muted),
          SizedBox(width: 7),
          Expanded(
            child: Text(
              'Do primeiro toque ao próximo atendimento.',
              style: TextStyle(fontSize: 13, color: LandingTheme.muted),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _preview(bool wide) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 540),
    child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFF2D8BC),
                borderRadius: BorderRadius.circular(260),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(wide ? 68 : 12, 24, wide ? 28 : 12, 24),
          child: Transform.rotate(
            angle: wide ? 0.025 : 0,
            child: const SchedulingPreview(),
          ),
        ),
        if (wide) ...[
          const Positioned(
            right: 8,
            top: 18,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 54,
              color: LandingTheme.orange,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 66,
            child: Container(
              width: 190,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LandingTheme.paper,
                border: Border.all(color: LandingTheme.line),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.event_available_rounded,
                    size: 28,
                    color: LandingTheme.orange,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tudo no\nseu tempo.',
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class ConstrainedCopy extends StatelessWidget {
  const ConstrainedCopy(this.text, {super.key, this.light = false});

  final String text;
  final bool light;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 420),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        height: 1.5,
        color: light ? const Color(0xFFAEAEA5) : LandingTheme.muted,
      ),
    ),
  );
}

class _Step extends StatelessWidget {
  const _Step(this.number, this.label);

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        number,
        style: const TextStyle(
          color: LandingTheme.orangeDark,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
