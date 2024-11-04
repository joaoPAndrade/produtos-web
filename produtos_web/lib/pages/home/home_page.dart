import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produto_front/pages/criar_produto/criar_produto_page.dart';
import 'package:produto_front/pages/widgets/produto_widget.dart';
import '../detalhes_produto/detalhes_produto_page.dart';
import 'dart:convert';
import "../models/produo.dart";
import '../widgets/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageStatus createState() => _HomePageStatus();
}

class _HomePageStatus extends State<HomePage> {
  List<Produto> produtos = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  Future<void> _fetchProdutos() async {
    final uri = Uri.parse('http://localhost:8000/produtos');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Erro ao carregar produtos');
      }
      List<dynamic> jsonList = json.decode(response.body);
      setState(() {
        produtos = jsonList.map((json) => Produto.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(title: 'CRUD - Produto'),
        body: Stack(
          children: [
            const SizedBox(height: 200),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      return ProdutoWidget(
                        produto: produtos[index],
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesProdutoPage(
                                  produtoId: produtos[index].id),
                            ),
                          );
                          _fetchProdutos();
                        },
                      );
                    },
                  ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CriarProdutoPage()),
                  );
                  _fetchProdutos();
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
  }
}
