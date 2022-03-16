import 'dart:convert';

import 'package:estudesemfronteiras/Entity/courses.dart';

List<Purchase> purchaseFromJson(String str) =>
    List<Purchase>.from(json.decode(str).map((x) => Purchase.fromMap(x)));

class Purchase {
  var id;
  var orig_id;
  var course_id;
  var course_code;
  var user_id;
  var purchase_status;
  var active;
  var access_time;
  var date_hour;
  var good_thru;
  var trash;
  var coupon_info;
  var type;
  var active_tests;
  var ted;
  var acesso_total;
  var contrato_validado;
  var contrato_aprovado_usuario_id;
  var hash;
  var consultor_id;
  var course;

  Purchase({
    required this.id,
    required this.orig_id,
    required this.course_id,
    required this.user_id,
    required this.purchase_status,
    required this.active,
    required this.access_time,
    required this.date_hour,
    required this.good_thru,
    required this.trash,
    required this.coupon_info,
    required this.type,
    required this.active_tests,
    required this.ted,
    required this.acesso_total,
    required this.contrato_validado,
    required this.contrato_aprovado_usuario_id,
    required this.hash,
    required this.consultor_id,
    this.course
  });

  factory Purchase.fromMap(Map<String, dynamic> json) =>
      Purchase(
        id: json['id'],
        orig_id: json['orif_id'],
        course_id: json['course_id'],
        user_id: json['user_id'],
        purchase_status: json['purchase_status'],
        active: json['active'],
        access_time: json['access_time'],
        date_hour: json['date_hour'],
        good_thru: json['good_thru'],
        trash: json['trash'],
        coupon_info: json['coupon_info'],
        type: json['type'],
        active_tests: json['active_tests'],
        ted: json['ted'],
        acesso_total: json['acesso_total'],
        contrato_validado: json['contrato_validado'],
        contrato_aprovado_usuario_id: json['contrato_aprovado_usuario_id'],
        hash: json['hash'],
        consultor_id: json['consultor_id'],
        course: json['course']
      );

}
