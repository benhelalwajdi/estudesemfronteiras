import 'dart:convert';

List<Module> ModuleFromJson(String str) =>
    List<Module>.from(json.decode(str).map((x) => Module.fromMap(x)));

class Module {
  var id;
  var user_id;
  var course_id;
  var course_sagah_id;
  var nome;
  var disciplina_id;
  var professor_id;
  var created;
  var modified ;

  Module({
    required this.id,
    required this.user_id,
    required this.course_id,
    required this.course_sagah_id,
    required this.nome,
    required this.disciplina_id,
    required this.professor_id,
    required this.created,
    required this.modified,
  });

  factory Module.fromMap(Map<String, dynamic> json)=>
      Module(id: json['id'],
        user_id: json['user_id'],
        course_id: json['course_id'],
        course_sagah_id: json['course_sagah_id'],
        nome: json['nome'],
        disciplina_id: json['disciplina_id'],
        professor_id: json['professor_id'],
        created: json['created'],
        modified: json['modified']);
}