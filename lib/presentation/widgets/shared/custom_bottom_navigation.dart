import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up_alt_outlined), label: 'Populares'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}

//-------------------------------------------------------
//---------------------- onItemTapped -------------------
//-------------------------------------------------------

void onItemTapped(BuildContext context, int index) {
  context.go('/home/$index');
}
