import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  late final _StyledTextController _contentController;
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _contentController = _StyledTextController();
    _contentController.addListener(_handleTextChange);
  }

  // Track text selection
  TextSelection? _currentSelection;

  void _toggleFormatting(String style) {
    if (_currentSelection == null || !_currentSelection!.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select some text first'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    _contentController.toggleStyle(
      _currentSelection!.start,
      _currentSelection!.end,
      style,
    );
    setState(() {});
  }

  bool _hasActiveStyle(String style) {
    if (_currentSelection == null || !_currentSelection!.isValid) {
      return false;
    }
    return _contentController.hasStyle(
      _currentSelection!.start,
      _currentSelection!.end,
      style,
    );
  }

  void _handleTextChange() {
    if (_contentController.selection.isValid) {
      final String deletedText = _contentController.text;
      if (deletedText.isEmpty) {
        _contentController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C6BC0),
      body: Column(
        children: [
          // Banner and Header Section
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(
              children: [
                // Banner Image
                Image.asset(
                  'assets/images/banner.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Header with buttons
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.star_border, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.download, color: Colors.white),
                              onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard2'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notes Content Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE6E6FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title TextField
                    TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1D2E),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Content TextField with rich text
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: EditableText(
                          controller: _contentController,
                          focusNode: _focusNode,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1B1D2E),
                          ),
                          cursorColor: Colors.blue,
                          backgroundCursorColor: Colors.grey,
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSelectionChanged: (selection, cause) {
                            setState(() {
                              _currentSelection = selection;
                            });
                          },
                          selectionColor: Colors.blue.withOpacity(0.3),
                          strutStyle: const StrutStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Bar with formatting tools
          Container(
            color: const Color(0xFFE6E6FA),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Text formatting options
                IconButton(
                  icon: Icon(
                    Icons.format_bold,
                    color: _hasActiveStyle('bold') ? Colors.blue : Colors.black87,
                  ),
                  onPressed: () => _toggleFormatting('bold'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_italic,
                    color: _hasActiveStyle('italic') ? Colors.blue : Colors.black87,
                  ),
                  onPressed: () => _toggleFormatting('italic'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_underline,
                    color: _hasActiveStyle('underline') ? Colors.blue : Colors.black87,
                  ),
                  onPressed: () => _toggleFormatting('underline'),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.removeListener(_handleTextChange);
    _contentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

// Custom TextEditingController for styled text
class _StyledTextController extends TextEditingController {
  final Map<TextRange, Map<String, bool>> _styles = {};

  bool hasStyle(int start, int end, String styleType) {
    final range = TextRange(start: start, end: end);
    return _styles[range]?[styleType] ?? false;
  }

  void toggleStyle(int start, int end, String styleType) {
    final range = TextRange(start: start, end: end);
    
    // Get or create style map for this range
    var styleMap = _styles[range] ?? {};
    
    // Toggle the specific style
    styleMap[styleType] = !(styleMap[styleType] ?? false);
    
    // If all styles are false, remove the range entirely
    if (styleMap.values.every((value) => !value)) {
      _styles.remove(range);
    } else {
      _styles[range] = styleMap;
    }
    
    notifyListeners();
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final String plainText = text;
    if (plainText.isEmpty) {
      return TextSpan(text: '', style: style);
    }

    List<TextSpan> children = [];
    int currentIndex = 0;

    // Sort ranges by start position
    final List<TextRange> ranges = _styles.keys.toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    for (final range in ranges) {
      // Skip invalid ranges
      if (range.start >= plainText.length || 
          range.end > plainText.length ||
          range.start >= range.end) {
        continue;
      }

      if (range.start > currentIndex) {
        // Add unstyled text before this range
        children.add(TextSpan(
          text: plainText.substring(currentIndex, range.start),
          style: style,
        ));
      }

      // Build combined style based on active formatting
      final Map<String, bool> styleMap = _styles[range] ?? {};
      TextStyle combinedStyle = TextStyle(
        fontWeight: styleMap['bold'] == true ? FontWeight.bold : FontWeight.normal,
        fontStyle: styleMap['italic'] == true ? FontStyle.italic : FontStyle.normal,
        decoration: styleMap['underline'] == true ? TextDecoration.underline : TextDecoration.none,
      );

      // Add styled text
      children.add(TextSpan(
        text: plainText.substring(range.start, range.end),
        style: style?.merge(combinedStyle) ?? combinedStyle,
      ));

      currentIndex = range.end;
    }

    // Add any remaining unstyled text
    if (currentIndex < plainText.length) {
      children.add(TextSpan(
        text: plainText.substring(currentIndex),
        style: style,
      ));
    }

    return TextSpan(children: children, style: style);
  }

  @override
  set text(String newText) {
    super.text = newText;
    if (newText.isEmpty) {
      _styles.clear();
    }
    _styles.removeWhere((range, _) => 
      range.start >= newText.length || 
      range.end > newText.length ||
      range.start >= range.end
    );
  }

  void clearStylesInRange(int start, int end) {
    _styles.removeWhere((range, _) =>
      (range.start >= start && range.start < end) ||
      (range.end > start && range.end <= end) ||
      (range.start <= start && range.end >= end)
    );
    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    _styles.clear();
    notifyListeners();
  }
} 