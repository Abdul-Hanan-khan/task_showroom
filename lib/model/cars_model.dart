class Car{
  String ? id;
  String ? category;
  String ? color;
  String ? carName;

  String ? make;
  String ? model;
  String ? owner;
  String ? registration;
  String ? uploadedBy;
  String ? userId;

  Car({this.id, this.category, this.color, this.carName,  this.make,
    this.model, this.owner,this.uploadedBy,this.registration, this.userId});

  Car.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    id = json['id'];
    category = json['category'];
    color = json['color'];
    carName = json['car_name'];
    make = json['make'];
    model = json['model'];
    registration = json['registration'];
    uploadedBy = json['uploaded_by'];
    owner = json['owner'];
  }}