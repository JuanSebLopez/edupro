import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/statistics_card.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'ImgHome2Png.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20.0), // Espacio entre la imagen y los textos
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('michael7.jpg'),
              ),
              SizedBox(width: 16.0), // Espacio entre la imagen y el texto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Juan Peralta',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Estas son tus estadisticas',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
              height: 20.0), // Espacio entre los textos y las tarjetas
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: StatisticsCard(
                            title: 'Estadísticas',
                            icon: Icons.trending_up,
                            count: '1.863',
                            color: Colors.blue,
                            percentage: '+10.9%',
                          ),
                        ),
                        Expanded(
                          child: StatisticsCard(
                            title: 'Completados',
                            icon: Icons.done,
                            count: '1.863',
                            color: Colors.green,
                            percentage: '+10.9%',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: StatisticsCard(
                            title: 'Desafíos',
                            icon: Icons.lightbulb,
                            count: '1.863',
                            color: Colors.orange,
                            percentage: '+10.9%',
                          ),
                        ),
                        Expanded(
                          child: StatisticsCard(
                            title: 'Experiencia',
                            icon: Icons.star_border,
                            count: '11.863',
                            color: Colors.amber,
                            percentage: '+10.9%',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            20.0), // Espacio entre las estadísticas y el nuevo contenido
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.error,
                            size: 48,
                            color: Colors
                                .blue, // Cambio del color del icono a azul
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Necesitas mejorar tus estadísticas, prueba repasar los temas que se te hayan complicado y vuelve a intentarlo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
