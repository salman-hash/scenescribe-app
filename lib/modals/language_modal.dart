import 'package:flutter/material.dart';

class LanguageModal extends StatelessWidget {
  const LanguageModal({super.key});

  static const Map<String, String> _chatGPTLanguages = {
    "en": "English",
    "es": "Spanish",
    "fr": "French",
    "de": "German",
    "it": "Italian",
    "pt": "Portuguese",
    "ru": "Russian",
    "zh": "Chinese (Simplified)",
    "ja": "Japanese",
    "ko": "Korean",
    "pl": "Polish",
    "ar": "Arabic",
    "sv": "Swedish",
    "fi": "Finnish",
    "no": "Norwegian",
    "nl": "Dutch",
    "tr": "Turkish",
    "he": "Hebrew",
    "hi": "Hindi",
    "ur": "Urdu",
    "vi": "Vietnamese",
    "id": "Indonesian",
    "th": "Thai",
    "uk": "Ukrainian",
    "fa": "Persian",
    "cs": "Czech",
    "ro": "Romanian",
    "hu": "Hungarian",
    "el": "Greek",
    "da": "Danish",
  };

  @override
  Widget build(BuildContext context) {
    final sortedLangs = _chatGPTLanguages.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    return AlertDialog(
      title: const Text('Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: sortedLangs.length,
            itemBuilder: (_, index) {
              final lang = sortedLangs[index];
              return ListTile(
                title: Text(lang.value),
                subtitle: Text(lang.key),
                onTap: () => Navigator.of(context).pop(lang.value),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
