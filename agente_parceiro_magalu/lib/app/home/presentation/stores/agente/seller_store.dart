import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'seller_store.g.dart';

class SellerStore = _SellerStoreBase with _$SellerStore;

abstract class _SellerStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

  final formKey = GlobalKey<FormState>();

  @observable
  SellerModel sellerModel = SellerModel(
    cnpj: "",
    helenaSellerCode: "",
    nome: "",
    telefone: "",
    email: "",
    cidade: "",
    uf: "",
    cep: "",
    endereco: "",
    numero: "",
    complemento: "",
    cadastro: "",
    dataPedidoTeste: "",
  );

  Future<bool> onSellerInit() async {
    try {
      await _datasource.getSellerList();

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addSeller() async {
    try {
      print(sellerModel.cadastro + sellerModel.cep);
      await _datasource.postSeller(sellerModel: sellerModel);
      return true;
    } catch (err) {
      return false;
    }
  }

  String? validateCommonField(String? text) {
    if (text == "") return "Campo não pode ser vazio";

    return null;
  }
}
