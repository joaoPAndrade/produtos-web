import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late TextEditingController dataCompletaController;

  @override
  void initState() {
    super.initState();
    descricaoController =
        TextEditingController(text: widget.initialData?['descricao'] ?? '');
    precoController =
        TextEditingController(text: widget.initialData?['preco'] ?? '');
    estoqueController = TextEditingController(
        text: widget.initialData?['estoque']?.toString() ?? '');
    dataController = TextEditingController(
        text: (widget.initialData?['data']?.length ?? 0) >= 10
            ? widget.initialData!['data']!.substring(0, 10)
            : widget.initialData?['data'] ?? '');
    dataCompletaController =
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
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
          ),
          TextField(
            controller: estoqueController,
            decoration: const InputDecoration(labelText: 'Estoque'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            controller: dataController,
            decoration: const InputDecoration(labelText: 'Data'),
            readOnly: true,
            onTap: () async {
              DateTime? initialDate;
              if (dataCompletaController.text.isNotEmpty) {
                initialDate = DateTime.tryParse(dataCompletaController.text);
              }
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String dataCompleta = pickedDate.toIso8601String();
                dataCompletaController.text = dataCompleta;
                dataController.text = dataCompleta.substring(0, 10);
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: ElevatedButton(
              onPressed: () {
                
                if (descricaoController.text.length < 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Descrição deve ter pelo menos 3 caracteres.")),
                  );
                  return;
                }
                if (double.tryParse(precoController.text) == null ||
                    double.parse(precoController.text) <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Preço deve ser maior que zero.")),
                  );
                  return;
                }
                if (int.tryParse(estoqueController.text) == null ||
                    int.parse(estoqueController.text) <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Estoque deve ser maior que zero.")),
                  );
                  return;
                }
                if (dataController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data é obrigatória.")),
                  );
                  return;
                }

                final novoProduto = {
                  "descricao": descricaoController.text,
                  "preco": double.tryParse(precoController.text) ?? 0.0,
                  "estoque": int.tryParse(estoqueController.text) ?? 0,
                  "data": dataController.text,
                };
                widget.onSave(novoProduto);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.textoBotao,
                    softWrap: true,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
