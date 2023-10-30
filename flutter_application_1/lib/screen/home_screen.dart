import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        backgroundColor: Colors.indigo, // Color más formal para AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade200, Colors.blueGrey.shade100],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: const <Widget>[
            _ModuleCard(
              title: 'Productos',
              icon: Icons.shopping_bag,
              routeName: 'list',
              color: Colors.blueAccent,
            ),
            _ModuleCard(
              title: 'Categorías',
              icon: Icons.category,
              routeName: 'categories',
              color: Colors.teal,
            ),
            _ModuleCard(
              title: 'Proveedores',
              icon: Icons.people,
              routeName: 'providers',
              color: Colors.purpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String routeName;
  final Color color;

  const _ModuleCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.routeName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: CircleAvatar(
        radius: 75,
        backgroundColor: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
