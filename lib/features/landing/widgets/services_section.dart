import 'package:flutter/material.dart';

import '../models/demo_catalog.dart';
import '../theme/landing_theme.dart';
import 'booking_demo_dialog.dart';
import 'landing_components.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) => ContentWidth(
    vertical: 84,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('CADA DETALHE CONTA'),
        const SizedBox(height: 16),
        const SectionTitle('O próximo visual\né você quem escolhe.'),
        const SizedBox(height: 18),
        const Text(
          'Explore os serviços do BarberHub e experimente o fluxo de agendamento.',
          style: TextStyle(color: LandingTheme.muted, fontSize: 17),
        ),
        const SizedBox(height: 34),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 780 ? 3 : 1;
            final width = (constraints.maxWidth - (columns - 1) * 18) / columns;
            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                for (var index = 0; index < demoServices.length; index++)
                  SizedBox(width: width, child: _ServiceCard(index)),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        const Text(
          'Serviços e valores de exemplo, baseados no catálogo do projeto.',
          style: TextStyle(color: LandingTheme.muted, fontSize: 12),
        ),
      ],
    ),
  );
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final service = demoServices[index];
    final featured = index == 2;
    final ink = featured ? LandingTheme.paper : LandingTheme.ink;
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: featured ? LandingTheme.ink : LandingTheme.paper,
        border: Border.all(
          color: featured ? LandingTheme.ink : LandingTheme.line,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                service.icon,
                size: 35,
                color: featured ? LandingTheme.orange : LandingTheme.ink,
              ),
              Text(
                '${service.durationMinutes} MIN',
                style: TextStyle(
                  color: featured
                      ? const Color(0xFFB5B5AB)
                      : LandingTheme.muted,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            service.name,
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.w600,
              fontSize: 27,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            service.description,
            style: TextStyle(
              color: featured ? const Color(0xFFB5B5AB) : LandingTheme.muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Divider(color: featured ? LandingTheme.darkLine : LandingTheme.line),
          const SizedBox(height: 12),
          Wrap(
            spacing: 18,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                service.formattedPrice,
                style: TextStyle(
                  color: ink,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton.icon(
                onPressed: () => showBookingDemo(context, serviceIndex: index),
                style: TextButton.styleFrom(
                  foregroundColor: featured
                      ? LandingTheme.orange
                      : LandingTheme.ink,
                ),
                label: const Text('Experimentar'),
                icon: const Icon(Icons.arrow_outward_rounded, size: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
