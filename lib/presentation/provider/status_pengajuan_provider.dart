import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';

class StatusPengajuanProvider extends ChangeNotifier {
  final ApiService apiService;

  StatusPengajuanProvider({required this.apiService}) {
    fetchStatusPengajuan();
  }

  late StatusPengajuanPkl _statusPengajuanPkl;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  StatusPengajuanPkl get list => _statusPengajuanPkl;

  ResultState get state => _state;

  Future<dynamic> fetchStatusPengajuan() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final status = await apiService.getStatusPengajuan();
      if (status.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Belum ada Pengajuan yang diajukan";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _statusPengajuanPkl = status;
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
