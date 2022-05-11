class SellerField {
  static const String cnpj = "CNPJ";
  static const String helenaSellerCode = "Helena Seller Code";
  static const String nome = "Nome";
  static const String telefone = "Telefone";
  static const String email = "E-mail";
  static const String cidade = "Cidade";
  static const String uf = "UF";
  static const String cep = "CEP";
  static const String endereco = "Endereço";
  static const String numero = "Número";
  static const String complemento = "Complemento";
  static const String cadastro = "Cadastro";
  static const String dataPedidoTeste = "Data Pedido Teste";

  static List<String> getFields() => [
        cnpj,
        helenaSellerCode,
        nome,
        telefone,
        email,
        cidade,
        uf,
        cep,
        endereco,
        numero,
        complemento,
        cadastro,
        dataPedidoTeste,
      ];
}

class SheetsFieldModel {
  String cnpj;
  String helenaSellerCode;
  String nome;
  String telefone;
  String email;
  String cidade;
  String uf;
  String cep;
  String endereco;
  String numero;
  String complemento;
  String cadastro;
  String dataPedidoTeste;

  SheetsFieldModel({
    required this.cnpj,
    required this.helenaSellerCode,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.cidade,
    required this.uf,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.complemento,
    required this.cadastro,
    required this.dataPedidoTeste,
  });

  Map<String, dynamic> toJson() => {
        SellerField.cnpj: cnpj,
        SellerField.helenaSellerCode: helenaSellerCode,
        SellerField.nome: nome,
        SellerField.telefone: telefone,
        SellerField.email: email,
        SellerField.cidade: cidade,
        SellerField.uf: uf,
        SellerField.cep: cep,
        SellerField.endereco: endereco,
        SellerField.numero: numero,
        SellerField.complemento: complemento,
        SellerField.cadastro: cadastro,
        SellerField.dataPedidoTeste: dataPedidoTeste,
      };

  static SheetsFieldModel fromJsonSellerModel(Map<String, dynamic> json) {
    SheetsFieldModel sm = SheetsFieldModel(
      cnpj: json["cnpj"],
      helenaSellerCode: json["helenaSellerCode"],
      nome: json["nome"],
      telefone: json["telefone"],
      email: json["email"],
      cidade: json["cidade"],
      uf: json["uf"],
      cep: json["cep"],
      endereco: json["endereco"],
      numero: json["numero"],
      complemento: json["complemento"],
      cadastro: json["cadastro"],
      dataPedidoTeste: json["dataPedidoTeste"],
    );

    return sm;
  }

  static List<SheetsFieldModel> fromJsonSellerModelList(List<dynamic> json) =>
      json.map((i) => fromJsonSellerModel(i)).toList();

  static SheetsFieldModel fromJsonSheet(Map<String, dynamic> json) {
    SheetsFieldModel sm = SheetsFieldModel(
      cnpj: json[SellerField.cnpj],
      helenaSellerCode: json[SellerField.helenaSellerCode],
      nome: json[SellerField.nome],
      telefone: json[SellerField.telefone],
      email: json[SellerField.email],
      cidade: json[SellerField.cidade],
      uf: json[SellerField.uf],
      cep: json[SellerField.cep],
      endereco: json[SellerField.endereco],
      numero: json[SellerField.numero],
      complemento: json[SellerField.complemento],
      cadastro: json[SellerField.cadastro],
      dataPedidoTeste: json[SellerField.dataPedidoTeste],
    );

    return sm;
  }

  static List<SheetsFieldModel> fromJsonSheetList(List<dynamic> json) =>
      json.map((i) => fromJsonSheet(i)).toList();
}
