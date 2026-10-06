import 'package:flutter/material.dart';

import '../models/demo_catalog.dart';
import '../theme/landing_theme.dart';
import 'booking_demo_dialog.dart';
import 'landing_components.dart';

class SchedulingPreview extends StatefulWidget {
  const SchedulingPreview({super.key});

  @override
  State<SchedulingPreview> createState() => _SchedulingPreviewState();
}

class _SchedulingPreviewState extends State<SchedulingPreview> {
  String _time = '14:30';

  @override
  Widget build(BuildContext context) => Container(
    width: 330,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: LandingTheme.ink,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: LandingTheme.ink.withValues(alpha: 0.16),
          blurRadius: 44,
          offset: const Offset(0, 22),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: LandingTheme.ink,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(fontSize: 11, color: LandingTheme.paper),
                    ),
                    Icon(
                      Icons.battery_full_rounded,
                      color: LandingTheme.paper,
                      size: 17,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Brand(light: true, compact: true),
                    Icon(
                      Icons.menu_rounded,
                      size: 20,
                      color: LandingTheme.paper,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: LandingTheme.paper,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Eyebrow('PRÉVIA DO APP', dot: true),
                const SizedBox(height: 10),
                const Text(
                  'Hora de cuidar\ndo seu estilo.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: LandingTheme.cream,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: LandingTheme.line),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.content_cut_rounded,
                        color: LandingTheme.ink,
                        size: 25,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Corte + Barba',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '60 min · Carlos Mendes',
                              style: TextStyle(
                                fontSize: 11,
                                color: LandingTheme.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'R\$ 70',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Escolha um horário',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final time in demoTimes)
                        SizedBox(
                          width: (constraints.maxWidth - 16) / 3,
                          child: OutlinedButton(
                            onPressed: () => setState(() => _time = time),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              minimumSize: const Size(0, 44),
                              foregroundColor: LandingTheme.ink,
                              backgroundColor: _time == time
                                  ? LandingTheme.orange
                                  : LandingTheme.paper,
                              side: BorderSide(
                                color: _time == time
                                    ? LandingTheme.orange
                                    : LandingTheme.line,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Text(
                              time,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => showBookingDemo(context, time: _time),
                  style: FilledButton.styleFrom(
                    backgroundColor: LandingTheme.orange,
                    foregroundColor: LandingTheme.ink,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                  ),
                  child: const Text(
                    'Experimentar agendamento',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Demonstração com dados de exemplo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: LandingTheme.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
