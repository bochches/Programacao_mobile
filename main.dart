import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Tarefa {
  String titulo;
  String descricao;
  bool isConcluida;
  Tarefa({required this.titulo, required this.descricao, this.isConcluida = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Tarefa> _tarefas = [];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  void _adicionarTarefa() {
    if(_tituloController.text.isNotEmpty) {
      setState(() {
        _tarefas.add(Tarefa(
          titulo: _tituloController.text,
          descricao: _descricaoController.text,
        ));
      });
      _tituloController.clear();
      _descricaoController.clear();
    };
  }

  void _removerTarefa(int index) {
    showDialog(
      context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Remover Tarefa'),
          content: const Text('Tem certeza que deseja remover esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _tarefas.removeAt(index);
                });
              },
              child: const Text('Remover'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Tarefas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Funcionalidade Extra: Contador de tarefas (Requisito 5)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Total: ${_tarefas.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Área de cadastro
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título da Tarefa',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _adicionarTarefa,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Tarefa'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Botão largo
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                return ListTile(
                  title: Text(tarefa.titulo),
                  subtitle: Text(tarefa.descricao),
                  trailing: Checkbox(
                    value: tarefa.isConcluida,
                    onChanged: (bool? value) {
                      setState(() {
                        tarefa.isConcluida = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}