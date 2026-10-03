import 'package:flutter/material.dart';
import './models/anuncio.dart';
import './form_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final List<Anuncio> _anuncios = [];

  void _adicionarAnuncio() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormPage()),
    );

    if (resultado != null) {
      setState(() {
        _anuncios.add(resultado['anuncio']);
      });
    }
  }

  void _editarAnuncio(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(anuncio: _anuncios[index], index: index),
      ),
    );

    if (resultado != null) {
      setState(() {
        _anuncios[index] = resultado['anuncio'];
      });
    }
  }

  void _removerAnuncio(int index) {
    setState(() {
      _anuncios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            Image.asset('images/logoml.png', height: 40),
            const SizedBox(width: 10),
            const Text('Mercado Livre'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _anuncios.length,
        itemBuilder: (context, index) {
          final anuncio = _anuncios[index];
          return Dismissible(
            key: Key(anuncio.titulo + index.toString()),
            direction: DismissDirection.horizontal,

            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.edit, color: Colors.white, size: 30),
            ),

            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),

            confirmDismiss: (direction) async {
              // desliza pra editar
              if (direction == DismissDirection.startToEnd) {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FormPage(anuncio: anuncio, index: index),
                  ),
                );

                if (resultado != null) {
                  setState(() {
                    _anuncios[index] = resultado['anuncio'];
                  });
                }

                // Não remove o item da lista
                return false;
              }
              //desliza para remover
              else if (direction == DismissDirection.endToStart) {
                return true;
              }

              return false;
            },

            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _removerAnuncio(index);
              }
            },

            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                //icone de imagem ao lado do texto do anuncio
                leading: const Icon(Icons.image, size: 50),
                title: Text(anuncio.titulo),
                subtitle: Text(anuncio.descricao),
                trailing: Text('R\$ ${anuncio.preco.toStringAsFixed(2)}'),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarAnuncio,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
