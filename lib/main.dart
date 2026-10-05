import 'package:flutter/material.dart';

void main() {
  runApp(const KgnTawaFryApp());
}

class MenuItemModel {
  final String name;
  final String category;
  final int half;
  final int full;

  const MenuItemModel(
    this.name,
    this.category,
    this.half,
    this.full,
  );
}

const menu = <MenuItemModel>[
  // CHICKEN
  MenuItemModel('Murgh Do Pyaza', 'Chicken', 160, 300),
  MenuItemModel('Murgh Mughlai', 'Chicken', 170, 320),
  MenuItemModel('Chicken Handi', 'Chicken', 160, 300),
  MenuItemModel('Chicken Peshawar', 'Chicken', 170, 320),
  MenuItemModel('Shahi Chicken', 'Chicken', 170, 320),
  MenuItemModel('Malai Tikka', 'Chicken', 180, 350),
  MenuItemModel('Tikka Masala', 'Chicken', 170, 320),
  MenuItemModel('Karahi', 'Chicken', 160, 300),
  MenuItemModel('Garlic Chicken', 'Chicken', 160, 300),
  MenuItemModel('Chicken India', 'Chicken', 250, 450),
  MenuItemModel('Butter Chicken Boneless', 'Chicken', 170, 320),
  MenuItemModel('White Chicken', 'Chicken', 180, 350),
  MenuItemModel('Green Chicken', 'Chicken', 180, 350),
  MenuItemModel('Chicken Fry', 'Chicken', 120, 220),
  MenuItemModel('Chicken Masala', 'Chicken', 120, 220),
  MenuItemModel('Biryani', 'Chicken', 80, 120),
  MenuItemModel('Tandoori Masala', 'Chicken', 250, 480),
  MenuItemModel('Ahmedabad Masala', 'Chicken', 160, 320),
  MenuItemModel('Tikka Rice', 'Chicken', 170, 320),

  // MUTTON
  MenuItemModel('Mughlai Mutton', 'Mutton', 150, 280),
  MenuItemModel('Dalbati Gos', 'Mutton', 150, 280),
  MenuItemModel('White Mutton', 'Mutton', 160, 300),
  MenuItemModel('Green Mutton', 'Mutton', 150, 280),
  MenuItemModel('Mutton Kurma', 'Mutton', 160, 300),
  MenuItemModel('Mutton Fry', 'Mutton', 120, 220),
  MenuItemModel('Mutton Masala', 'Mutton', 120, 220),
  MenuItemModel('Kaleji Masala', 'Mutton', 120, 220),
  MenuItemModel('Bhaji Gos', 'Mutton', 130, 240),
  MenuItemModel('Paya Fry', 'Mutton', 120, 220),

  // FISH / OTHER
  MenuItemModel('Chaap Fry', 'Fish', 120, 220),
  MenuItemModel('Bheja Fry', 'Fish', 130, 240),
  MenuItemModel('Boti Masala', 'Fish', 120, 220),
  MenuItemModel('Kheema Fry', 'Fish', 80, 160),
  MenuItemModel('Kheema Pulao', 'Fish', 100, 180),
  MenuItemModel('Fish Fry', 'Fish', 80, 160),
  MenuItemModel('Fish Kadhi', 'Fish', 100, 200),
  MenuItemModel('Zinga Fry', 'Fish', 130, 240),
  MenuItemModel('Zinga Rice', 'Fish', 170, 320),

  // EGG
  MenuItemModel('Anda Kadhi', 'Egg', 80, 160),
  MenuItemModel('Anda Kheema', 'Egg', 80, 160),
  MenuItemModel('Anda Bhurji', 'Egg', 50, 100),
  MenuItemModel('Anda Pulao', 'Egg', 60, 120),

  //
