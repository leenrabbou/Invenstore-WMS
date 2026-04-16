// ignore_for_file: file_names

class EmployeeModel {
  int id;
  String? image, address;
  String userName,
      fullName,
      email,
      gender,
      birthDate,
      phoneNumber,
      ssn,
      employeableType,
      city,
      state,
      role,
      employable;
  int stateId, roleId, employeableId;
  EmployeeModel({
    required this.id,
    required this.image,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
    required this.ssn,
    required this.address,
    required this.employeableType,
    required this.stateId,
    required this.roleId,
    required this.employeableId,
    required this.city,
    required this.employable,
    required this.role,
    required this.state,
  });
  factory EmployeeModel.fromjson(jsonData) {
    return EmployeeModel(
      id: jsonData['id'],
      image: jsonData['image'],
      userName: jsonData['username'],
      fullName: jsonData['full_name'],
      email: jsonData['email'],
      gender: jsonData['gender'],
      birthDate: jsonData['birthday'],
      phoneNumber: jsonData['phone_number'],
      ssn: jsonData['ssn'],
      address: jsonData['address'],
      employeableType: jsonData['employable_type'],
      stateId: jsonData['state_id'],
      roleId: jsonData['role_id'],
      employeableId: jsonData['employable_id'],
      city: jsonData['city'],
      employable: jsonData['employable'],
      role: jsonData['role'],
      state: jsonData['state'],
    );
  }
}
