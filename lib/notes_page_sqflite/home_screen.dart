import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';

import 'database_helper.dart';
import 'model.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  DBHelper? dbHelper;
  List<NotesModel>? notesList;
  List<NotesModel> datas = [];
  bool fetching = true;

  final player = AudioPlayer();

  bool isPlaying = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    dbHelper = DBHelper();
    getData();
    fetching = false;
    super.initState();
  }

  Future setAudio(String audioPath) async {
    final file = File(audioPath);
    player.setSourceUrl(file.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    datas = await dbHelper!.getNotesList();
    print("data :: $datas");
  }

  Future<List<NotesModel>> loadData() async {
    notesList = (await dbHelper!.getNotesList());
    print("notesList $notesList");
    return notesList ?? [];
  }

  final TextEditingController mynotesController = TextEditingController();
  final TextEditingController decrioption = TextEditingController();

  //image

  List<String> selectedImages = [];
  File? file;
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    print("loadData(),loadData(),loadData(),loadData(),loadData(),");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: loadData(),
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return (notesList != null && notesList!.isNotEmpty)
                        ? ListView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final notesData = snapshot.data![index];
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete_outline),
                                ),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    dbHelper!.delete(notesData.id!).then(
                                        (value) => print("deleted id $value"));
                                    notesList!.removeAt(index);
                                    getData();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Note's is Deleted"),
                                      ),
                                    );
                                  });
                                },
                                key: ValueKey(notesData.id!),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddPage(
                                                      notesModel: notesData),
                                                )).whenComplete(
                                              () async {
                                                await getData();
                                                setState(() {});
                                              },
                                            );
                                          },
                                          title: Text(
                                            notesData.title.toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          subtitle: Text(
                                              notesData.description.toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Note is empty please add new notes'),
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                )).whenComplete(() async {
              await getData();
              setState(() {});
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
