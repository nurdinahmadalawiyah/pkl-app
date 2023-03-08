import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/pencarian_lowongan.dart';

class PencarianProvider extends ChangeNotifier {
  final ApiService apiService;

  PencarianProvider({required this.apiService}) {
    fetchAllPencarianLowongan(keyword);
  }

  PencarianLowongan? _pencarianLowongan;
  String _message = '';
  String _keyword = '';
  ResultState? _state;

  String get message => _message;
  String get keyword => _keyword;

  PencarianLowongan? get pencarianLowongan => _pencarianLowongan;

  ResultState? get state => _state;

  void updateKeyword(String keyword) {
    if (_keyword != keyword) {
      _keyword = keyword;
      fetchAllPencarianLowongan(keyword);
    }
  }

  Future<dynamic> fetchAllPencarianLowongan(String keyword) async {
    try {
      _state = ResultState.loading;
      _keyword = keyword;

      final pencarianLowongan = await apiService.getPencarianLowongan(keyword);
      if (pencarianLowongan.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Data Tidak Ditemukan";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _pencarianLowongan = pencarianLowongan;
      }
    } on SocketException {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'Tidak Ada Koneksi Internet';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
