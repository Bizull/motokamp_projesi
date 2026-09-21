import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile/profile_screen.dart';
import 'profile/badges_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Keşfet sekmesinin içindeki sayfa geçişlerini yönetecek anahtar
  final GlobalKey<NavigatorState> _exploreNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Android geri tuşuna basıldığında uygulamadan çıkmak yerine bir önceki iç ekrana dön
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _exploreNavigatorKey.currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // 1. Sekme: Kendi içinde gezinme desteği olan Keşfet
            Navigator(
              key: _exploreNavigatorKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                );
              },
            ),

            // 2. Sekme: Rozetler
            const BadgesScreen(),

            // 3. Sekme: Profilim
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            // Eğer zaten Keşfet sekmesindeyken tekrar Keşfet'e basarsa en başa (Motor & Kamp kartlarına) dönsün
            if (index == 0 && _currentIndex == 0) {
              _exploreNavigatorKey.currentState?.popUntil((route) => route.isFirst);
            }
            setState(() {
              _currentIndex = index;
            });
          },
          indicatorColor: Colors.deepOrange.shade100,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore, color: Colors.deepOrange),
              label: 'Keşfet',
            ),
            NavigationDestination(
              icon: Icon(Icons.shield_outlined),
              selectedIcon: Icon(Icons.shield, color: Colors.amber),
              label: 'Rozetler',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Colors.blueGrey),
              label: 'Profilim',
            ),
          ],
        ),
      ),
    );
  }
}