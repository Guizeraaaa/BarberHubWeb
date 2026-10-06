import 'package:flutter/material.dart';

@immutable
class DemoService {
  const DemoService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final int durationMinutes;
  final IconData icon;

  String get formattedPrice => 'R\$ $price,00';
}

@immutable
class DemoBarber {
  const DemoBarber(this.name, this.initials, this.serviceIds);

  final String name;
  final String initials;
  final List<String> serviceIds;
}

// Referência: Guizeraaaa/BarberHub, branch develop,
// lib/shared/mocks/mock.dart (c41adbc998e196cfdb2deb6208e10887e6b6643c).
// Estes dados servem apenas à apresentação e à demonstração local.
const demoServices = [
  DemoService(
    id: 's1',
    name: 'Corte',
    description:
        'Um novo visual, do seu jeito. Do clássico ao seu próximo estilo.',
    price: 45,
    durationMinutes: 30,
    icon: Icons.content_cut_rounded,
  ),
  DemoService(
    id: 's2',
    name: 'Barba',
    description: 'Alinhada nos detalhes. O cuidado que faz toda a diferença.',
    price: 35,
    durationMinutes: 30,
    icon: Icons.face_rounded,
  ),
  DemoService(
    id: 's3',
    name: 'Corte + Barba',
    description:
        'O visual completo em um só horário. Praticidade da cabeça à barba.',
    price: 70,
    durationMinutes: 60,
    icon: Icons.auto_awesome_rounded,
  ),
];

const demoBarbers = [
  DemoBarber('Carlos Mendes', 'CM', ['s1', 's2', 's3']),
  DemoBarber('Rafael Souza', 'RS', ['s1', 's2', 's3']),
  DemoBarber('Diego Almeida', 'DA', ['s1', 's3']),
];

const demoTimes = ['10:00', '10:30', '11:00', '14:00', '14:30', '15:00'];
