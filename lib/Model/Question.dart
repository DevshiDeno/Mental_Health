class ChatData {
  String? userQuestion;
  String? generatedAnswer;
bool isUser1=false;
  ChatData({
     this.userQuestion,
     this.generatedAnswer
});
  static List<ChatData>messages=[];
  static List<ChatData>answers=[];
}