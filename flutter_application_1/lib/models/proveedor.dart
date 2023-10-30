import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.listadoProveedores,
  });

  List<ProveedorListado> listadoProveedores;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        listadoProveedores: (json["Proveedores Listado"] as List<dynamic>?)
                ?.map((x) => ProveedorListado.fromMap(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado":
            List<dynamic>.from(listadoProveedores.map((x) => x.toMap())),
      };
}

class ProveedorListado {
  ProveedorListado({
    required this.proveedorId,
    required this.proveedorName,
    required this.proveedorLastName,
    required this.proveedorMail,
    required this.proveedorState,
  });

  int proveedorId;
  String proveedorName;
  String proveedorLastName;
  String proveedorMail;
  String proveedorState;

  factory ProveedorListado.fromJson(String str) =>
      ProveedorListado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProveedorListado.fromMap(Map<String, dynamic> json) =>
      ProveedorListado(
        proveedorId: json["provider_id"] ?? 0,
        proveedorName: json["provider_name"] ?? 'Nombre no disponible',
        proveedorLastName:
            json["provider_last_name"] ?? 'Apellido no disponible',
        proveedorMail: json["provider_mail"] ?? 'Correo no disponible',
        proveedorState: json["provider_state"] ?? 'Estado no disponible',
      );

  Map<String, dynamic> toMap() => {
        "provider_id": proveedorId,
        "provider_name": proveedorName,
        "provider_last_name": proveedorLastName,
        "provider_mail": proveedorMail,
        "provider_state": proveedorState,
      };

  ProveedorListado copy() => ProveedorListado(
      proveedorId: proveedorId,
      proveedorName: proveedorName,
      proveedorLastName: proveedorLastName,
      proveedorMail: proveedorMail,
      proveedorState: proveedorState);
}
