// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:core/avtovas_core.dart';
import 'package:core/data/utils/caller_methods/caller_methods.dart';
import 'package:http/http.dart' as http;

final class CallerDataSource implements ICallerDataSource {
  CallerDataSource() {
    _regenerateUnique();
  }

  @override
  Future<String> initCall(
    int phoneNumber, {
    String? expectedCode,
  }) async {
    final response = await http.post(
      Uri.parse(PrivateInfo.callerEndpoint),
      body: jsonEncode(
        CallerParams.initCallParams(
          phoneNumber: phoneNumber,
          uniqueV4: _uniqueV4,
        ),
      ),
    );

    return expectedCode ??
        (jsonDecode(response.body) as Map<String, dynamic>)['code'].toString();
  }

  @override
  Future<Map<String, dynamic>> getInfo() {
    throw UnimplementedError();
  }

  // ignore: unused_field
  static String _uniqueV4 = generateUuid();

  void _regenerateUnique() {
    Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        _uniqueV4 = generateUuid();
      },
    );
  }
}
