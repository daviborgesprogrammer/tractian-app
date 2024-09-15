// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'HomeControllerBase._status', context: context);

  HomeStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  HomeStatus get _status => status;

  @override
  set _status(HomeStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: 'HomeControllerBase._errorMessage', context: context);

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_companiesAtom =
      Atom(name: 'HomeControllerBase._companies', context: context);

  List<Company> get companies {
    _$_companiesAtom.reportRead();
    return super._companies;
  }

  @override
  List<Company> get _companies => companies;

  @override
  set _companies(List<Company> value) {
    _$_companiesAtom.reportWrite(value, super._companies, () {
      super._companies = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
