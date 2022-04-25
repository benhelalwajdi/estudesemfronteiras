
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
          name: json['name'],
          exibicao: json['exibicao'],
          imagem: json['imagem'],
          description: json['description'],
          canonical: json['canonical'],
          meta_description: json['meta_description'],
          title: json['title'],
          redirecionamento_301: json['redirecionamento_301'],
          redirecionamento_302: json['redirecionamento_302'],
          subcategories: json['subcategories'],
          slug: json['slug'],
          visivel: json['visivel'],
          trash: json['trash']
      );

}