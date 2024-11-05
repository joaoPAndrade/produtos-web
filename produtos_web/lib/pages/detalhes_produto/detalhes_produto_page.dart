import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produto_front/pages/home/home_page.dart';
import 'dart:convert';
import "../models/produo.dart";
import '../editar_produto/editar_produto_page.dart';
import '../widgets/appBar.dart';

class DetalhesProdutoPage extends StatefulWidget {
  final int produtoId;
  const DetalhesProdutoPage({Key? key, required this.produtoId})
      : super(key: key);
  @override
  _DetalhesPageStatus createState() => _DetalhesPageStatus();
}

class _DetalhesPageStatus extends State<DetalhesProdutoPage> {
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

  Future<void> excluirProduto(int produtoId) async {
    final uri = Uri.parse('http://localhost:8000/produto/$produtoId');
    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw Exception('Erro ao excluir produto');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'CRUD - Produto'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : produto != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          produto!.descricao,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                                'Preço: R\$ ${produto!.preco.toStringAsFixed(2)}'),
                            const SizedBox(height: 10),
                            Text('Estoque: ${produto!.estoque}'),
                            const SizedBox(height: 10),
                            Text('Data: ${produto!.data.substring(0, 10)}'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditarProdutoPage(
                                          produtoId: produto!.id)),
                                );
                                _fetchProduto();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Edit',
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                  
                                    title: const Text('Confirmação'),
                                    content: const Text(
                                        'Tem certeza de que deseja excluir este produto?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue),
                                        child: const Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Cancelar',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await excluirProduto(produto!.id);
                                          if (mounted) {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Excluir',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Delete',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
              : const Center(child: Text('Produto não encontrado')),
    );
  }
}
