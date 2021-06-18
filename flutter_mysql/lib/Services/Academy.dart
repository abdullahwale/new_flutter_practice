class Academy{

  String academyname;
  String address;
  String city;
  Academy({this.academyname,this.address,this.city});

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      academyname: json['academy_name'] as String,
      address: json['academy_address'] as String,
      city: json['city'] as String,
    );
  }
}