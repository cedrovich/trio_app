import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importa CarouselSlider
import 'reservas_page.dart'; // Importa la página de reservas
import 'package:supabase_flutter/supabase_flutter.dart'; // Para cerrar sesión

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  void _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacementNamed(context, '/login'); // Redirige al LoginPage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sesión cerrada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lista de eventos (por ahora solo texto)
    final List<String> eventos = [
      'Concierto en CDMX - 5 de diciembre',
      'Festival de música clásica - 15 de diciembre',
      'Boda privada en Monterrey - 20 de diciembre',
      'Evento corporativo en Guadalajara - 30 de diciembre',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trío Semblanzas'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Opciones',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sección de Perfil próximamente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sección de Ajustes próximamente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Preguntas frecuentes'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sección de Preguntas frecuentes próximamente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Reservar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservasPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido al Trío Semblanzas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Disfruta de la mejor música en vivo para tus eventos.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Próximos Eventos:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // CarouselSlider para los próximos eventos
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: eventos.map((evento) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            evento,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, 
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReservasPage()),
                  );
                },
                child: const Text('¡Contrátanos ya!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
