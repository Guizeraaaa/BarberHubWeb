import 'package:flutter/material.dart';

import '../../../shared/browser_links.dart';
import '../theme/landing_theme.dart';
import '../widgets/booking_demo_dialog.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/landing_components.dart';
import '../widgets/services_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _how = GlobalKey();
  final _services = GlobalKey();
  final _professionals = GlobalKey();
  final _faq = GlobalKey();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openSource() {
    final opened = openBrowserLink(
      Uri.parse('https://github.com/Guizeraaaa/BarberHub/tree/develop'),
    );
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Acesse github.com/Guizeraaaa/BarberHub para conhecer o projeto.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final small =
        MediaQuery.sizeOf(context).width < 1100 ||
        MediaQuery.textScalerOf(context).scale(15) > 18;
    final navigation = <String, GlobalKey>{
      'Como funciona': _how,
      'Serviços': _services,
      'Para barbeiros': _professionals,
      'Dúvidas': _faq,
    };
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(small ? 76 : 88),
        child: Material(
          color: LandingTheme.cream,
          child: SafeArea(
            bottom: false,
            child: ContentWidth(
              child: SizedBox(
                height: small ? 76 : 88,
                child: Row(
                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Brand(),
                      ),
                    ),
                    if (!small) ...[
                      for (final entry in navigation.entries)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextButton(
                            onPressed: () => _scrollTo(entry.value),
                            child: Text(entry.key),
                          ),
                        ),
                      const SizedBox(width: 24),
                      ActionButton(
                        label: 'Experimentar',
                        onPressed: () => showBookingDemo(context),
                      ),
                    ] else
                      PopupMenuButton<String>(
                        tooltip: 'Abrir menu de navegação',
                        icon: const Icon(Icons.menu_rounded),
                        onSelected: (value) {
                          if (value == 'Experimentar') {
                            showBookingDemo(context);
                          } else {
                            _scrollTo(navigation[value]!);
                          }
                        },
                        itemBuilder: (_) => [
                          for (final label in navigation.keys)
                            PopupMenuItem(value: label, child: Text(label)),
                          const PopupMenuItem(
                            value: 'Experimentar',
                            child: Text('Experimentar'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroSection(onHowItWorks: () => _scrollTo(_how)),
              _HowSection(key: _how),
              ServicesSection(key: _services),
              DashboardSection(key: _professionals),
              _FaqSection(key: _faq),
              _closing(),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closing() => ColoredBox(
    color: LandingTheme.orange,
    child: ContentWidth(
      vertical: 66,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Eyebrow('SEU PRÓXIMO CORTE COMEÇA AQUI'),
              SizedBox(height: 18),
              SectionTitle('Um novo visual.\nUm jeito mais simples.'),
              SizedBox(height: 18),
              Text(
                'Experimente o BarberHub e encontre tempo para você.',
                style: TextStyle(fontSize: 17),
              ),
            ],
          );
          final button = ActionButton(
            label: 'Experimentar o BarberHub',
            onPressed: () => showBookingDemo(context),
          );
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 30),
                button,
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [copy, const SizedBox(height: 30), button],
          );
        },
      ),
    ),
  );

  Widget _footer() => ContentWidth(
    vertical: 34,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 48,
          runSpacing: 22,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            const Brand(),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () => _scrollTo(_services),
                  child: const Text('Serviços'),
                ),
                TextButton(
                  onPressed: () => _scrollTo(_faq),
                  child: const Text('Dúvidas'),
                ),
                TextButton.icon(
                  onPressed: _openSource,
                  label: const Text('Conheça o projeto'),
                  icon: const Icon(Icons.arrow_outward_rounded, size: 17),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(color: LandingTheme.line),
        const SizedBox(height: 18),
        Wrap(
          spacing: 24,
          runSpacing: 10,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              '© ${DateTime.now().year} BarberHub.',
              style: const TextStyle(color: LandingTheme.muted, fontSize: 12),
            ),
            const Text(
              'Feito por quem acredita em cuidar dos detalhes.',
              style: TextStyle(color: LandingTheme.muted, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
  );
}

class _HowSection extends StatelessWidget {
  const _HowSection({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: LandingTheme.paper,
    child: ContentWidth(
      vertical: 78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('SIMPLES DO COMEÇO AO FIM'),
          const SizedBox(height: 16),
          const SectionTitle('O cuidado começa\nantes da cadeira.'),
          const SizedBox(height: 38),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 780 ? 3 : 1;
              final width =
                  (constraints.maxWidth - (columns - 1) * 38) / columns;
              return Wrap(
                spacing: 38,
                runSpacing: 32,
                children: [
                  SizedBox(
                    width: width,
                    child: const _Feature(
                      Icons.content_cut_rounded,
                      'Seu serviço, seu estilo.',
                      'Explore o catálogo, confira valores e escolha o cuidado que combina com você.',
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: const _Feature(
                      Icons.people_outline_rounded,
                      'Com quem você confia.',
                      'Conheça os profissionais e escolha o barbeiro para o seu próximo atendimento.',
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: const _Feature(
                      Icons.calendar_month_outlined,
                      'Tudo na sua agenda.',
                      'Escolha um horário e acompanhe seus agendamentos em um só lugar no app.',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

class _Feature extends StatelessWidget {
  const _Feature(this.icon, this.title, this.description);

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: LandingTheme.cream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 27, color: LandingTheme.ink),
      ),
      const SizedBox(height: 21),
      Text(
        title,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        description,
        style: const TextStyle(color: LandingTheme.muted, height: 1.6),
      ),
    ],
  );
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({super.key});

  static const _questions = {
    'Posso fazer uma reserva real neste site?':
        'Por enquanto, este site apresenta o BarberHub e permite testar uma demonstração local. Os serviços, profissionais e horários são exemplos; nenhuma reserva é enviada a uma barbearia.',
    'O que posso fazer no app BarberHub?':
        'O projeto permite consultar serviços e profissionais, selecionar horários, acompanhar agendamentos e cancelar um atendimento. Você pode conhecer o código pelo link no rodapé.',
    'O BarberHub também é para barbeiros?':
        'Sim. O projeto inclui gestão de serviços e um painel com receita, quantidade de atendimentos e gráficos de serviços e status dos agendamentos.',
    'Preciso instalar algo para experimentar?':
        'Não. A demonstração desta página funciona diretamente no navegador do celular, tablet ou computador. O app completo é um projeto separado.',
  };

  @override
  Widget build(BuildContext context) => ContentWidth(
    vertical: 82,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Eyebrow('VAMOS DESCOMPLICAR'),
            SizedBox(height: 16),
            SectionTitle('Ficou com\nalguma dúvida?'),
            SizedBox(height: 18),
            Text(
              'A gente explica.',
              style: TextStyle(color: LandingTheme.muted, fontSize: 18),
            ),
          ],
        );
        final questions = Column(
          children: [
            for (final entry in _questions.entries)
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: LandingTheme.line)),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(vertical: 8),
                  childrenPadding: const EdgeInsets.fromLTRB(0, 0, 18, 20),
                  shape: const Border(),
                  collapsedShape: const Border(),
                  iconColor: LandingTheme.ink,
                  collapsedIconColor: LandingTheme.ink,
                  title: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          color: LandingTheme.muted,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
        if (constraints.maxWidth > 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: title),
              const SizedBox(width: 70),
              Expanded(flex: 6, child: questions),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [title, const SizedBox(height: 30), questions],
        );
      },
    ),
  );
}
