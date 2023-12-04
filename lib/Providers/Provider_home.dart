import 'package:flutter/material.dart';

import '../Model/Journal.dart';
import '../Model/Question.dart';

class FirstProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  Future<DateTime> selectedDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    return _selectedDate;
  }

  DateTime addBookedDate(date) {
    _selectedDate = date;
    return date;
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}

class SecondProvider extends ChangeNotifier {
  DateTime? _bookedDate;

  DateTime? get bookedDate => _bookedDate;

  void addBookedDate(DateTime date) {
    _bookedDate = date;
    notifyListeners();
  }
}

class ChatDataProvider with ChangeNotifier {
  void addChatMessage(String question) {
    final chatMessage =
        ChatData(userQuestion: question);
    ChatData.messages.add(chatMessage);
  }
  void addChatAnswer(String answer){
    final chatAnswer=ChatData(generatedAnswer: answer);
    ChatData.answers.add(chatAnswer);
  }
}


class NoteProvider with ChangeNotifier {
  bool containsNote(String writtenNotes, DateTime currentdate) {
    return Note.noteList.any((note) =>
        note.written_notes == writtenNotes && note.date == currentdate);
  }

  void addNote(String writtenNotes, DateTime currentdate) {
    final finalNotes = Note(written_notes: writtenNotes, date: currentdate);
    Note.noteList.add(finalNotes);
  }
}

