import 'package:flutter/material.dart';

import '../theme/landing_theme.dart';
import 'hero_section.dart';
import 'landing_components.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: LandingTheme.ink,
    child: ContentWidth(
      vertical: 80,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Eyebrow('PARA QUEM FAZ ACONTECER', light: true),
              SizedBox(height: 20),
              SectionTitle('Sua agenda.\nSob controle.', light: true),
              SizedBox(height: 24),
              ConstrainedCopy(
                'Menos tempo organizando. Mais tempo atendendo. O BarberHub também cuida da rotina de quem está do outro lado da cadeira.',
                light: true,
              ),
              SizedBox(height: 24),
              CheckLine('Acompanhe os próximos agendamentos', light: true),
              CheckLine('Cadastre e atualize seus serviços', light: true),
              CheckLine('Visualize receita e atendimentos', light: true),
              SizedBox(height: 22),
              Text(
                'Recursos presentes no projeto BarberHub.',
                style: TextStyle(color: Color(0xFFAEAEA5), fontSize: 12),
              ),
            ],
          );
          if (constraints.maxWidth >= 900) {
            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 70),
                const Expanded(child: _DashboardPreview()),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              copy,
              const SizedBox(height: 42),
              const _DashboardPreview(),
            ],
          );
        },
      ),
    ),
  );
}

class _DashboardPreview extends StatelessWidget {
  const _DashboardPreview();

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(MediaQuery.sizeOf(context).width < 600 ? 20 : 28),
    decoration: BoxDecoration(
      color: const Color(0xFF242420),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: LandingTheme.darkLine),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'Visão geral',
                style: TextStyle(
                  color: LandingTheme.paper,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.dashboard_outlined,
              color: LandingTheme.orange,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Seu negócio em um só lugar.',
          style: TextStyle(color: Color(0xFFAEAEA5), fontSize: 13),
        ),
        const SizedBox(height: 24),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Metric('RECEITA', 'R\$ 425', Icons.payments_outlined),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _Metric('ATENDIMENTOS', '8', Icons.content_cut_rounded),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Text(
          'Atendimentos por serviço',
          style: TextStyle(color: LandingTheme.paper, fontSize: 13),
        ),
        const SizedBox(height: 20),
        Semantics(
          label:
              'Gráfico de exemplo: quatro cortes, três cortes com barba e uma barba.',
          child: const ExcludeSemantics(
            child: Column(
              children: [
                _Bar('Corte', 4, 1),
                SizedBox(height: 12),
                _Bar('Combo', 3, 0.75),
                SizedBox(height: 12),
                _Bar('Barba', 1, 0.25),
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        const Divider(color: LandingTheme.darkLine),
        const SizedBox(height: 12),
        const Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: LandingTheme.orange,
              child: Text(
                'CM',
                style: TextStyle(
                  color: LandingTheme.ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Carlos Mendes',
                    style: TextStyle(color: LandingTheme.paper, fontSize: 13),
                  ),
                  Text(
                    'Próximo: corte + barba',
                    style: TextStyle(color: Color(0xFFAEAEA5), fontSize: 11),
                  ),
                ],
              ),
            ),
            Text(
              '14:30',
              style: TextStyle(
                color: LandingTheme.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'PRÉVIA ILUSTRATIVA · DADOS DE EXEMPLO',
          style: TextStyle(
            color: Color(0xFFAEAEA5),
            fontSize: 9,
            letterSpacing: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: Border.all(color: LandingTheme.darkLine),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: LandingTheme.orange, size: 19),
        const SizedBox(height: 14),
        Text(
          value,
          style: const TextStyle(
            color: LandingTheme.paper,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFAEAEA5),
            fontSize: 9,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}

class _Bar extends StatelessWidget {
  const _Bar(this.label, this.count, this.ratio);

  final String label;
  final int count;
  final double ratio;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 48,
        child: Text(
          label,
          style: const TextStyle(color: Color(0xFFAEAEA5), fontSize: 12),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: ratio,
            child: Container(
              height: 13,
              decoration: BoxDecoration(
                color: LandingTheme.orange,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        '$count',
        style: const TextStyle(color: LandingTheme.paper, fontSize: 12),
      ),
    ],
  );
}
