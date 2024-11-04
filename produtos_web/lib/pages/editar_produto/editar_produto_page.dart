import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "../models/produo.dart";
import '../widgets/formulario_widget.dart';

class EditarProdutoPage extends StatefulWidget {
  final int produtoId;
  const EditarProdutoPage({Key? key, required this.produtoId})
      : super(key: key);
  @override
  _EditarProdutoPage createState() => _EditarProdutoPage();
}

class _EditarProdutoPage extends State<EditarProdutoPage> {
  Produto? produto;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchProduto();
  }

  Future<void> _fetchProduto() async {
    final uri = Uri.parse('http://localhost:8000/produto/${widget.produtoId}');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Erro ao carregar produtos');
      }
      final jsonProduto = json.decode(response.body);
      setState(() {
        produto = Produto.fromJson(jsonProduto);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro: $e');
    }
  }

  Future<void> _updateProduto(Map<String, dynamic> produtoAtualizado) async {
    final uri = Uri.parse('http://localhost:8000/produto/${widget.produtoId}');
    try {
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(produtoAtualizado),
      );

      if (response.statusCode != 201) {
        throw Exception('Erro ao atualizar o produto!');
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: FormularioWidget(
                initialData: {
                  "id": produto?.id,
                  "descricao": produto?.descricao,
                  "preco": produto?.preco.toString(),
                  "estoque": produto?.estoque,
                  "data": produto?.data,
                },
                onSave: _updateProduto,
                textoBotao: "Salvar Alterações",
              ),
            ),
    );
  }
}
