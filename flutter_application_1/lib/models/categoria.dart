import 'dart:convert';

class Categoria {
  Categoria({
    required this.listadoCategorias,
  });

  List<CategoriaListado> listadoCategorias;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        listadoCategorias: List<CategoriaListado>.from(
            json["Listado Categorias"].map((x) => CategoriaListado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado Categorias":
            List<dynamic>.from(listadoCategorias.map((x) => x.toMap())),
      };
}

class CategoriaListado {
  CategoriaListado({
    required this.categoriaId,
    required this.categoriaName,
    required this.categoriaState,
  });

  int categoriaId;
  String categoriaName;
  String categoriaState;

  factory CategoriaListado.fromJson(String str) =>
      CategoriaListado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriaListado.fromMap(Map<String, dynamic> json) =>
      CategoriaListado(
        categoriaId: json["category_id"] ?? 0,
        categoriaName: json["category_name"] ?? 'nombre no disponible',
        categoriaState: json["category_state"] ?? 'Estado no disponible',
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoriaId,
        "category_name": categoriaName,
        "category_state": categoriaState,
      };

  CategoriaListado copy() => CategoriaListado(
      categoriaId: categoriaId,
      categoriaName: categoriaName,
      categoriaState: categoriaState);
}
