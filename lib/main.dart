import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/favorites_page.dart';
import 'pages/profile_page.dart';
import 'models/note.dart';
import 'pages/cart_page.dart'; // Импортируем страницу корзины

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.system,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Note> notes = [];
  final List<Note> favoriteNotes = [];
  final List<Note> cartItems = []; // Список для корзины

  void _toggleFavorite(Note note) {
    setState(() {
      note.isFavorite = !note.isFavorite;
      if (note.isFavorite) {
        favoriteNotes.add(note);
      } else {
        favoriteNotes.remove(note);
      }
    });
  }

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _deleteNote(Note note) {
    setState(() {
      notes.remove(note);
      favoriteNotes.remove(note);
      cartItems.remove(note); // Удаляем из корзины, если удалено из заметок
    });
  }

  void _addToCart(Note note) {
    setState(() {
      cartItems.add(note);
    });
  }

  void _removeFromCart(Note note) {
    setState(() {
      cartItems.remove(note);
    });
  }

  List<Widget> get _pages => [
    HomePage(
      notes: notes,
      onToggleFavorite: _toggleFavorite,
      onAddNote: _addNote,
      onDeleteNote: _deleteNote,
      cartItems: cartItems, // Передаём список корзины
      onAddToCart: _addToCart, // Передаём функцию добавления в корзину
    ),
    FavoritesPage(
      favoriteNotes: favoriteNotes,
      onToggleFavorite: _toggleFavorite,
    ),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(cartItems: cartItems), // Переход на экран корзины
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
