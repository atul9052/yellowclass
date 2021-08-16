import 'package:hive/hive.dart';

part 'movieinfo.g.dart';
@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String director;
  @HiveField(2)
  final  String image;
  Contact(this.name, this.director,this.image);
}