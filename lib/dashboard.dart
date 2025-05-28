import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notivue/widget/TaskCard.dart';
import 'package:notivue/create_note.dart';
import 'package:notivue/settings.dart';
import 'models/note.dart';
import 'services/note_service.dart';
import 'utils/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _noteService = NoteService();
  List<Note> _notes = [];
  bool _isLoading = true;
  String _searchQuery = '';
  bool _isFabMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    try {
      final notes = await _noteService.getNotes();
      if (mounted) {
        setState(() {
          _notes = notes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading notes: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _deleteNote(String noteId) async {
    final confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content: const Text('Are you sure you want to delete this note?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmDelete) return;

    try {
      await _noteService.deleteNote(noteId);
      if (mounted) {
        setState(() {
          _notes.removeWhere((n) => n.id == noteId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting note: ${e.toString()}')),
        );
      }
    }
  }

  List<Note> get _filteredNotes {
    if (_searchQuery.isEmpty) {
      return _notes;
    }
    return _notes
        .where((note) =>
            note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (note.tags.any((tag) =>
                tag.toLowerCase().contains(_searchQuery.toLowerCase()))))
        .toList();
  }

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
    });
  }

  Widget _buildFabMenuItem(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.black87, size: 28),
      label: Text(
        title,
        style: GoogleFonts.pangolin(color: Colors.black87, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF1E592),
        minimumSize: const Size(200, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      onPressed: () {
        _toggleFabMenu();
        onPressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF56618A),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logo-white.png',
                            width: 150,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Today is,',
                            style: GoogleFonts.pangolin(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: GoogleFonts.pangolin(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white, size: 35),
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          style: GoogleFonts.pangolin(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'what you want to find ?',
                            hintStyle:
                                GoogleFonts.pangolin(color: Colors.black54),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black54),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.filter_list,
                              color: Colors.black54, size: 30),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Filter button pressed')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : _filteredNotes.isEmpty && _searchQuery.isEmpty
                            ? _buildEmptyState()
                            : _filteredNotes.isEmpty && _searchQuery.isNotEmpty
                                ? _buildNoResultsState()
                                : _buildNotesList(_filteredNotes),
                  ),
                ],
              ),
            ),
          ),
          if (_isFabMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleFabMenu,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildFabMenuItem(
                          context, 'New Audio', Icons.audiotrack_outlined, () {
                        print('New Audio Tapped');
                      }),
                      const SizedBox(height: 12),
                      _buildFabMenuItem(
                          context, 'New Image', Icons.image_outlined, () {
                        print('New Image Tapped');
                      }),
                      const SizedBox(height: 12),
                      _buildFabMenuItem(
                          context, 'New To-do list', Icons.list_alt_outlined,
                          () {
                        print('New To-do list Tapped');
                      }),
                      const SizedBox(height: 12),
                      _buildFabMenuItem(
                          context, 'New notes', Icons.note_add_outlined,
                          () async {
                        final result =
                            await Navigator.pushNamed(context, '/notes');
                        if (result == true) {
                          _loadNotes();
                        }
                      }),
                      const SizedBox(height: 30),
                      FloatingActionButton(
                        backgroundColor: const Color(0xFFF1E592),
                        onPressed: _toggleFabMenu,
                        child: const Icon(Icons.close,
                            color: Colors.black87, size: 30),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: !_isFabMenuOpen
          ? FloatingActionButton(
              onPressed: _toggleFabMenu,
              backgroundColor: const Color(0xFFF1E592),
              child: const Icon(Icons.add, color: Colors.black87, size: 35),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 150,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          Text(
            "Let's start with what's\nhappening today",
            textAlign: TextAlign.center,
            style: GoogleFonts.pangolin(
              color: Colors.white.withOpacity(0.8),
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 100,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          Text(
            "No notes found for '$_searchQuery'",
            textAlign: TextAlign.center,
            style: GoogleFonts.pangolin(
              color: Colors.white.withOpacity(0.8),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList(List<Note> notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, bottom: 8.0, top: 5.0),
          child: Text(
            _searchQuery.isEmpty
                ? "Showing all items"
                : "Showing search results",
            style: GoogleFonts.pangolin(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNoteScreen(noteToEdit: note),
                    ),
                  );
                  if (result == true && mounted) {
                    _loadNotes();
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: const Color(0xFF3A4262),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    note.title,
                                    style: GoogleFonts.righteous(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Color(0xFFF1E592)),
                                  onPressed: () => _deleteNote(note.id),
                                  tooltip: 'Delete Note',
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.preview,
                              style: GoogleFonts.pangolin(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Created: ${DateFormat.yMd().add_jm().format(note.createdAt.toLocal())}',
                                    style: GoogleFonts.pangolin(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 11,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Edited: ${DateFormat.yMd().add_jm().format(note.updatedAt.toLocal())}',
                                    style: GoogleFonts.pangolin(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 4.0,
                                  children: note.tags.take(2).map((tag) {
                                    return Chip(
                                      label: Text(tag,
                                          style: GoogleFonts.pangolin(
                                              fontSize: 12,
                                              color: Colors.black87)),
                                      backgroundColor:
                                          tag.toLowerCase() == 'school'
                                              ? Colors.red[300]
                                              : Colors.grey[300],
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      visualDensity: VisualDensity.compact,
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  '${note.id.length % 5 + 1} item(s)',
                                  style: GoogleFonts.pangolin(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
