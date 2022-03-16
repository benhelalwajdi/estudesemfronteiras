
class Category {
  var id;
  var name;
  var exibicao;
  var imagem;
  var description;
  var canonical;
  var meta_description ;
  var title;
  var redirecionamento_301;
  var redirecionamento_302;
  var subcategories;
  var slug;
  var visivel;
  var trash;

  Category({
    required this.id,
    required this.name,
    this.exibicao,
    this.imagem,
    this.description,
    this.canonical,
    this.meta_description,
    this.title,
    this.redirecionamento_301,
    this.redirecionamento_302,
    this.subcategories,
    this.slug,
    this.visivel,
    this.trash,
  });

  factory Category.fromMap(Map<String, dynamic> json) =>
      Category(
          id: json['id'],
          name: json['orif_id'],
          exibicao: json['course_id'],
          imagem: json['user_id'],
          description: json['purchase_status'],
          canonical: json['active'],
          meta_description: json['access_time'],
          title: json['date_hour'],
          redirecionamento_301: json['good_thru'],
          redirecionamento_302: json['trash'],
          subcategories: json['coupon_info'],
          slug: json['type'],
          visivel: json['active_tests'],
          trash: json['ted']
      );

}