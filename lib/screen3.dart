class Student {
  int? id;
  String? name;
  String? rollnumber;
  String? age;
  String? phonenumber;
  String? Imagepath;

// User Data Convert To Map..!
  StudentMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['rollnumber'] = rollnumber!;
    mapping['age'] = age!;
    mapping['phonenumber'] = phonenumber!;
    mapping['Imagepath'] = Imagepath!;

    return mapping;
  }
}
