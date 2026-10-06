import 'package:flutter/material.dart';

import '../theme/landing_theme.dart';

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.vertical = 0});

  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final small = MediaQuery.sizeOf(context).width < 600;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1240),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: small ? 20 : 40,
            vertical: vertical,
          ),
          child: child,
        ),
      ),
    );
  }
}

class Brand extends StatelessWidget {
  const Brand({super.key, this.light = false, this.compact = false});

  final bool light;
  final bool compact;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.content_cut_rounded,
        color: LandingTheme.orange,
        size: 32,
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BARBERHUB',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: light ? LandingTheme.paper : LandingTheme.ink,
                fontWeight: FontWeight.w800,
                fontSize: compact ? 20 : 24,
                letterSpacing: -0.7,
                height: 1,
              ),
            ),
            if (!compact)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'SEU ESTILO. SEU HORÁRIO.',
                  style: TextStyle(
                    color: LandingTheme.muted,
                    letterSpacing: 1.6,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.light = false, this.dot = false});

  final String text;
  final bool light;
  final bool dot;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (dot) ...[
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: LandingTheme.orange,
          ),
        ),
        const SizedBox(width: 9),
      ],
      Flexible(
        child: Text(
          text,
          style: TextStyle(
            color: light ? LandingTheme.orange : LandingTheme.muted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.light = false});

  final String text;
  final bool light;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.sizeOf(context).width < 600 ? 36 : 48,
        fontWeight: FontWeight.w700,
        height: 1.08,
        letterSpacing: -1.5,
        color: light ? LandingTheme.paper : LandingTheme.ink,
      ),
    ),
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.orange = false,
    this.icon = Icons.arrow_outward_rounded,
  });

  final String label;
  final VoidCallback onPressed;
  final bool orange;
  final IconData icon;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    style: orange
        ? FilledButton.styleFrom(
            backgroundColor: LandingTheme.orange,
            foregroundColor: LandingTheme.ink,
          )
        : null,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(label)),
        const SizedBox(width: 18),
        Icon(icon, size: 19),
      ],
    ),
  );
}

class CheckLine extends StatelessWidget {
  const CheckLine(this.text, {super.key, this.light = false});

  final String text;
  final bool light;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 19,
          color: LandingTheme.orange,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: light ? const Color(0xFFD2D2C9) : LandingTheme.muted,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
