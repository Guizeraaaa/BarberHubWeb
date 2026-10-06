import 'package:flutter/material.dart';

import '../models/demo_catalog.dart';
import '../theme/landing_theme.dart';
import 'landing_components.dart';

Future<void> showBookingDemo(
  BuildContext context, {
  int serviceIndex = 2,
  String? time,
}) => showDialog<void>(
  context: context,
  builder: (_) =>
      BookingDemoDialog(serviceIndex: serviceIndex, initialTime: time),
);

class BookingDemoDialog extends StatefulWidget {
  const BookingDemoDialog({super.key, this.serviceIndex = 2, this.initialTime});

  final int serviceIndex;
  final String? initialTime;

  @override
  State<BookingDemoDialog> createState() => _BookingDemoDialogState();
}

class _BookingDemoDialogState extends State<BookingDemoDialog> {
  late int _serviceIndex;
  String _barber = demoBarbers.first.name;
  int _day = 0;
  String? _time;
  bool _complete = false;
  late final List<DateTime> _days;

  DemoService get _service => demoServices[_serviceIndex];

  List<DemoBarber> get _availableBarbers => demoBarbers
      .where((barber) => barber.serviceIds.contains(_service.id))
      .toList();

  @override
  void initState() {
    super.initState();
    _serviceIndex = widget.serviceIndex;
    _time = widget.initialTime;
    final now = DateTime.now();
    _days = List.generate(
      4,
      (index) => DateTime(now.year, now.month, now.day + index + 1),
    );
  }

  String _date(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';

  void _changeService(int? index) {
    if (index == null) return;
    setState(() {
      _serviceIndex = index;
      if (!_availableBarbers.any((barber) => barber.name == _barber)) {
        _barber = _availableBarbers.first.name;
      }
      _time = null;
    });
  }

  @override
  Widget build(BuildContext context) => Dialog(
    insetPadding: const EdgeInsets.all(16),
    backgroundColor: LandingTheme.paper,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 540),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Eyebrow('EXPERIMENTE O BARBERHUB', dot: true),
                  ),
                  IconButton(
                    tooltip: 'Fechar demonstração',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_complete) ..._success() else ..._form(),
            ],
          ),
        ),
      ),
    ),
  );

  List<Widget> _form() => [
    const Text(
      'Seu horário, do seu jeito.',
      style: TextStyle(fontSize: 28, height: 1.15, fontWeight: FontWeight.w700),
    ),
    const SizedBox(height: 12),
    const Text(
      'Demonstração com dados de exemplo. Nenhuma reserva real será criada.',
      style: TextStyle(color: LandingTheme.muted, fontSize: 14),
    ),
    const SizedBox(height: 24),
    DropdownButtonFormField<int>(
      key: const ValueKey('demo-service'),
      initialValue: _serviceIndex,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Serviço',
        border: OutlineInputBorder(),
      ),
      items: [
        for (var index = 0; index < demoServices.length; index++)
          DropdownMenuItem(
            value: index,
            child: Text(
              '${demoServices[index].name} · ${demoServices[index].formattedPrice}',
            ),
          ),
      ],
      onChanged: _changeService,
    ),
    const SizedBox(height: 18),
    const Text('Profissional', style: TextStyle(fontWeight: FontWeight.w600)),
    const SizedBox(height: 6),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final barber in _availableBarbers)
          ChoiceChip(
            label: Text(barber.name),
            selected: _barber == barber.name,
            onSelected: (_) => setState(() {
              _barber = barber.name;
              _time = null;
            }),
          ),
      ],
    ),
    const SizedBox(height: 18),
    const Text('Dia de exemplo', style: TextStyle(fontWeight: FontWeight.w600)),
    const SizedBox(height: 6),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var index = 0; index < _days.length; index++)
          ChoiceChip(
            label: Text(_date(_days[index])),
            selected: _day == index,
            onSelected: (_) => setState(() {
              _day = index;
              _time = null;
            }),
          ),
      ],
    ),
    const SizedBox(height: 18),
    const Text(
      'Horário de exemplo',
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    const SizedBox(height: 6),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final time in demoTimes)
          ChoiceChip(
            label: Text(time),
            selected: _time == time,
            onSelected: (_) => setState(() => _time = time),
          ),
      ],
    ),
    const SizedBox(height: 22),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LandingTheme.cream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${_service.name} · ${_service.durationMinutes} min',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            _service.formattedPrice,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    FilledButton(
      key: const ValueKey('confirm-demo'),
      onPressed: _time == null ? null : () => setState(() => _complete = true),
      child: const Text('Simular agendamento'),
    ),
    if (_time == null)
      const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          'Escolha um horário para continuar.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: LandingTheme.muted),
        ),
      ),
  ];

  List<Widget> _success() => [
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Icon(Icons.task_alt_rounded, size: 64, color: LandingTheme.orange),
    ),
    const Text(
      'Demonstração concluída!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    ),
    const SizedBox(height: 18),
    Text(
      '${_service.name} com $_barber\n${_date(_days[_day])} às $_time · ${_service.formattedPrice}',
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 18),
    const Text(
      'Você testou o fluxo de agendamento. Este exemplo não foi enviado a uma barbearia e será descartado ao fechar.',
      textAlign: TextAlign.center,
      style: TextStyle(color: LandingTheme.muted),
    ),
    const SizedBox(height: 26),
    ActionButton(
      label: 'Voltar para o site',
      onPressed: () => Navigator.pop(context),
    ),
  ];
}
