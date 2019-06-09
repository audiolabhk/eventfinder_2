class Event {
  String title;
  String location;
  String date;

  Event(this.title,this.location,this.date);

  String describe(){
    return "$title at $location on $date";
  }
}