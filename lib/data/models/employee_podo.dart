import 'package:hive/hive.dart';
part '../data_sources/data_adapter.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  String joinDate;

  @HiveField(3)
  String resignDate;

  Employee(
      {required this.name,
      required this.role,
      required this.joinDate,
      this.resignDate = ""});
}
