import 'package:flutter/material.dart';
import '../services/local_service.dart';
import '../models/mahasiswa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalService service = LocalService();
  final TextEditingController nama = TextEditingController();
  final TextEditingController jurusan = TextEditingController();

  @override
  void dispose() {
    nama.dispose();
    jurusan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Local Storage')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nama,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: jurusan,
              decoration: const InputDecoration(labelText: 'Jurusan'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nama.text.isEmpty || jurusan.text.isEmpty) return;

              await service.tambah(
                Mahasiswa(nama.text, jurusan.text),
              );

              nama.clear();
              jurusan.clear();
              setState(() {});
            },
            child: const Text('Tambah'),
          ),
          Expanded(
            child: FutureBuilder<List<Mahasiswa>>(
              future: service.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Belum ada data'));
                }

                final List<Mahasiswa> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].nama),
                      subtitle: Text(data[index].jurusan),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await service.hapus(index);
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
