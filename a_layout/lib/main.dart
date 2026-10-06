import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Rio do Sul';
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(image: 'images/estacao.jpg'),
              TitleSection(
                name: 'Antiga Estação Ferroviária',
                location: 'Rio do Sul, Santa Catarina - Brasil',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'A antiga estação ferroviária de Rio do Sul fazia parte da '
                    'Estrada de Ferro Santa Catarina, ferrovia inaugurada em '
                    '1909 que cruzava o Vale do Itajaí e foi desativada em '
                    '1971. O prédio de tijolos à vista lembra a arquitetura '
                    'alemã da colonização da região e hoje abriga o Museu '
                    'Histórico Cultural da cidade.\n\n'
                    'Rio do Sul é o principal município do Alto Vale do '
                    'Itajaí, com cerca de 72 mil habitantes (Censo 2022). No '
                    'centro da cidade, os rios Itajaí do Sul e Itajaí do Oeste '
                    'se encontram e formam o Rio Itajaí-Açu. Outros pontos '
                    'conhecidos são a Catedral São João Batista e a Ponte dos '
                    'Arcos.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          const FavoriteWidget(),
        ],
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerRight,
          icon: _isFavorited
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
          color: Colors.red[500],
          onPressed: _toggleFavorite,
        ),
        SizedBox(width: 18, child: Text('$_favoriteCount')),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'LIGAR',
            mensagem: 'Ligando para o Museu Histórico Cultural...',
          ),
          ButtonWithText(
            color: Colors.orange,
            icon: Icons.near_me,
            label: 'ROTA',
            mensagem: 'Abrindo rota até a estação...',
          ),
          ButtonWithText(
            color: Colors.green,
            icon: Icons.photo_camera,
            label: 'FOTOS',
            mensagem: 'Abrindo galeria de fotos...',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'COMPARTILHAR',
            mensagem: 'Link copiado para compartilhar!',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.mensagem,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagem),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true, textAlign: TextAlign.justify),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}
