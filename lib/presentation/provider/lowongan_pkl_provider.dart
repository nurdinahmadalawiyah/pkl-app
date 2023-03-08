import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';


class LowonganPklProvider extends ChangeNotifier {
  final ApiService apiService;

  LowonganPklProvider({required this.apiService}) {
    _fetchLowonganPkl();
  }

  late LowonganPkl _lowonganPkl;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  LowonganPkl get list => _lowonganPkl;

  ResultState get state => _state;

  Future<dynamic> _fetchLowonganPkl() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final lowongan = await apiService.getLowonganPkl();
      if (lowongan.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Lowongan PKL Kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _lowonganPkl = lowongan;
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