import 'package:flutter/material.dart';
import '../models/produo.dart';

class ProdutoWidget extends StatelessWidget {
  final Produto produto;
  final VoidCallback onTap;
  const ProdutoWidget({
    Key? key,
    required this.produto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 162, 212, 253),
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: const BoxConstraints(
        maxWidth: 100,
        maxHeight: 100,
      ),
      child: ListTile(
        title: Text(
          produto.descricao,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
      
    );
  }
}
