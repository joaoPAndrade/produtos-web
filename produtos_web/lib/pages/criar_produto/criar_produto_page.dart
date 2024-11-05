import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/formulario_widget.dart';
import '../widgets/appBar.dart';

class CriarProdutoPage extends StatefulWidget {
  const CriarProdutoPage({Key? key}) : super(key: key);

  @override
  CriarProdutoPageState createState() => CriarProdutoPageState();
}

class CriarProdutoPageState extends State<CriarProdutoPage> {
  bool _isLoading = false;

  Future<void> _createProduto(Map<String, dynamic> produtoNovo) async {
    final uri = Uri.parse('http://localhost:8000/produto');
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(produtoNovo),
      );

      if (response.statusCode != 201) {
        throw Exception('Erro ao criar o produto!');
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'CRUD - Produto'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : FormularioWidget(
                initialData: const {
                  "descricao": '',
                  "preco": '',
                  "estoque": '',
                  "data": '',
                },
                onSave: (Map<String, dynamic> produtoNovo) {
                  _createProduto(produtoNovo);
                },
                textoBotao: "Criar Produto",
              ),
      ),
    );
  }
}
