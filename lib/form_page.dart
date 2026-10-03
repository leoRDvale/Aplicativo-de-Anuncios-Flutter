import 'package:flutter/material.dart';
import './models/anuncio.dart';

class FormPage extends StatefulWidget {
  final Anuncio? anuncio;
  final int? index;

  const FormPage({super.key, this.anuncio, this.index});

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.anuncio != null) {
      _tituloController.text = widget.anuncio!.titulo;
      _descricaoController.text = widget.anuncio!.descricao;
      _precoController.text = widget.anuncio!.preco.toString();
    }
  }

  void _salvar() {
    if (_tituloController.text.isNotEmpty &&
        _descricaoController.text.isNotEmpty &&
        _precoController.text.isNotEmpty) {
      final anuncio = Anuncio(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        preco: double.tryParse(_precoController.text) ?? 0.0,
      );

      Navigator.pop(context, {'anuncio': anuncio, 'index': widget.index});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.anuncio == null ? 'Novo Anúncio' : 'Editar Anúncio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
