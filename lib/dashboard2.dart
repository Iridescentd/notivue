import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notivue/widget/TaskCard.dart';

class Dashboard2 extends StatelessWidget {
  const Dashboard2({super.key});

  Widget _buildBottomSheetOption(
      BuildContext context, // This is 'bc' from showModalBottomSheet
      String title,
      IconData icon,
      void Function(BuildContext buttonContext) onTapWithButtonContext) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Builder(
        builder: (BuildContext itemButtonContext) {
          return ElevatedButton.icon(
            icon: Icon(icon, color: Colors.black87),
            label: Text(title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: GoogleFonts.pangolin().fontFamily)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFF176), // Yellow color
              minimumSize: const Size(double.infinity, 50), // Make buttons wide
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              onTapWithButtonContext(itemButtonContext);
            },
          );
        },
      ),
    );
  }

  Widget _buildNewImageOption(BuildContext context) {
    return Padding(
      // Added Padding here, similar to _buildBottomSheetOption
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'camera',
            child: Row(
              children: <Widget>[
                Icon(Icons.camera_alt, color: Colors.black54),
                SizedBox(width: 8),
                Text('Take a Photo'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'gallery',
            child: Row(
              children: <Widget>[
                Icon(Icons.photo_library, color: Colors.black54),
                SizedBox(width: 8),
                Text('Choose from Gallery'),
              ],
            ),
          ),
        ],
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF176), // Yellow color
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.image_outlined, color: Colors.black87),
              SizedBox(width: 8), // Spacing between icon and text
              Text('New Image',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: GoogleFonts.pangolin().fontFamily)),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Make sheet background transparent
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 92, 107,
                192), // Same as page background or a bit lighter/darker
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildBottomSheetOption(
                        bc, 'New Audio', Icons.audiotrack_outlined,
                        (buttonContext) {
                      Navigator.pop(bc); // Close bottom sheet
                      // TODO: Implement New Audio action
                      print('New Audio tapped');
                    }),

                    _buildNewImageOption(
                        bc), // Using the simpler PopupMenuButton approach

                    _buildBottomSheetOption(
                        bc, 'New To-do list', Icons.list_alt_outlined,
                        (buttonContext) {
                      Navigator.pop(bc);
                      // TODO: Implement New To-do list action
                      print('New To-do list tapped');
                    }),
                    _buildBottomSheetOption(
                        bc, 'New Notes', Icons.note_add_outlined,
                        (buttonContext) {
                      Navigator.pop(bc);
                      // TODO: Implement New Notes action
                      print('New Notes tapped');
                    }),
                    const SizedBox(height: 20), // Some padding at the bottom
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // At the top of your build method

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: const Color(0xFF5C6BC0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Logo-white.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Good Morning,',
              style: TextStyle(
                  fontFamily: GoogleFonts.pangolin().fontFamily,
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7)),
            ),
            Text(
              'Today is, ${DateFormat('EEEE, d MMMM y').format(DateTime.now())}',
              style: TextStyle(
                  fontFamily: GoogleFonts.pangolin().fontFamily,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'what you want to find ?',
                hintStyle: TextStyle(
                    fontFamily: GoogleFonts.pangolin().fontFamily,
                    color: Colors.white.withOpacity(0.7)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: const Icon(Icons.filter_list, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TaskCard(
            title: 'Tugas PPB',
            completedTasks: 3,
            totalTasks: 20,
            tags: ['To-do', 'School'],
            imageUrl: 'assets/images/banner.jpg',
            isAssetImage: true,
            onDelete: () {
              // Handle delete action
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOptionsBottomSheet(context);
        },
        backgroundColor: const Color(0xFFFFF176),
        child: const Icon(Icons.add, color: Colors.black87),
      ),
    );
  }
}
