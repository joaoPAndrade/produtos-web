class Produto {
  final int id;
  final String descricao;
  final double preco;
  final int estoque;
  final String data;

  const Produto({
    required this.id,
    required this.descricao,
    required this.estoque,
    required this.preco,
    required this.data,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as int,
      descricao: json['descricao'] as String,
      preco: double.parse(json['preco']),
      estoque: json['estoque'] as int,
      data: json['data'] as String,
    );
  }
}
