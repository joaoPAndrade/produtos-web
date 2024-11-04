import 'package:flutter/material.dart';

class FormularioWidget extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final void Function(Map<String, dynamic>) onSave;
  final String textoBotao;
  const FormularioWidget(
      {Key? key,
      this.initialData,
      required this.onSave,
      required this.textoBotao})
      : super(key: key);

  @override
  FormularioWidgetState createState() => FormularioWidgetState();
}

class FormularioWidgetState extends State<FormularioWidget> {
  late TextEditingController idController;
  late TextEditingController descricaoController;
  late TextEditingController precoController;
  late TextEditingController estoqueController;
  late TextEditingController dataController;

  @override
  void initState() {
    super.initState();
    descricaoController =
        TextEditingController(text: widget.initialData?['descricao'] ?? '');
    precoController =
        TextEditingController(text: widget.initialData?['preco'] ?? '');
    estoqueController = TextEditingController(
        text: widget.initialData?['estoque']?.toString() ?? '');
    dataController =
        TextEditingController(text: widget.initialData?['data'] ?? '');
  }

  @override
  void dispose() {
    descricaoController.dispose();
    precoController.dispose();
    estoqueController.dispose();
    dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            controller: descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: precoController,
            decoration: const InputDecoration(labelText: 'Preço'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: estoqueController,
            decoration: const InputDecoration(labelText: 'Estoque'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: dataController,
            decoration: const InputDecoration(labelText: 'Data'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final novoProduto = {
                  "descricao": descricaoController.text,
                  "preco": double.tryParse(precoController.text) ?? 0.0,
                  "estoque": int.tryParse(estoqueController.text) ?? 0,
                  "data": dataController.text,
                };
                widget.onSave(novoProduto);
              },
              child: Text(widget.textoBotao))
        ],
      ),
    );
  }
}
