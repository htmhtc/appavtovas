import 'dart:convert';

import 'package:core/data/mappers/app/passenger_mapper.dart';
import 'package:core/data/mappers/app/payment_mapper.dart';
import 'package:core/data/mappers/app/statused_trip_mapper.dart';
import 'package:core/data/mappers/base_mapper.dart';
import 'package:core/domain/entities/app_entities/user.dart';
import 'package:flutter/cupertino.dart';

abstract final class _Fields {
  static const String uuid = 'uuid';
  static const String phoneNumber = 'phone_number';
  static const String showNotifications = 'show_notifications';
  static const String emails = 'emails';
  static const String statusedTrips = 'statused_trips';
  static const String passengers = 'passengers';
  static const String paymentHistory = 'payment_history';
  static const String searchHistory = 'search_history';
  static const String availableFcmTokens = 'available_fcm_tokens';
  static const String isBlocked = 'is_blocked';
}

final class UserMapper implements BaseMapper<User> {
  @override
  Map<String, dynamic> toJson(User data, {bool toPostgres = true}) {
    return {
      _Fields.uuid: data.uuid,
      _Fields.phoneNumber: data.phoneNumber,
      _Fields.showNotifications: data.showNotifications,
      _Fields.emails: data.emails,
      _Fields.passengers: toPostgres
          ? data.passengers
              ?.map((e) => jsonEncode(PassengerMapper().toJson(e)))
              .toList()
          : data.passengers?.map(PassengerMapper().toJson).toList(),
      _Fields.statusedTrips: toPostgres
          ? data.statusedTrips
              ?.map((e) => jsonEncode(StatusedTripMapper().toJson(e)))
              .toList()
          : data.statusedTrips
              ?.map((e) => StatusedTripMapper().toJson)
              .toList(),
      _Fields.paymentHistory:
          data.paymentHistory?.map(PaymentMapper().toJson).toList(),
      _Fields.searchHistory: data.searchHistory?.map(jsonEncode).toList(),
      _Fields.availableFcmTokens: data.availableFcmTokens,
      _Fields.isBlocked: data.isBlocked,
    };
  }

  @override
  User fromJson(Map<String, dynamic> json, {bool fromPostgres = true}) {
    final emails = json[_Fields.emails] as List<dynamic>?;

    final availableFcmTokens =
        json[_Fields.availableFcmTokens] as List<dynamic>?;

    final statusedTrips = json[_Fields.statusedTrips];

    final passengers = json[_Fields.passengers];

    final paymentHistory = json[_Fields.paymentHistory];

    final jsonSearchHistory = json[_Fields.searchHistory];

    final searchHistory = fromPostgres
        ? jsonSearchHistory != null
            ? (jsonSearchHistory as List<dynamic>)
                .map((e) => jsonDecode(e) as List<dynamic>)
                .toList()
            : null
        : jsonSearchHistory;

    List<List<String>>? decodedSearchHistory;

    if (jsonSearchHistory != null && !fromPostgres) {
      for (final json in jsonSearchHistory) {
        decodedSearchHistory ??= [];

        final decoded = jsonDecode(json) as List<dynamic>;

        decodedSearchHistory.add(decoded.map((e) => e.toString()).toList());
      }
    }

    return User(
      uuid: json[_Fields.uuid],
      phoneNumber: json[_Fields.phoneNumber],
      showNotifications: json[_Fields.showNotifications],
      emails: emails?.map((e) => e.toString()).toList(),
      availableFcmTokens: availableFcmTokens?.map((e) => e.toString()).toList(),
      statusedTrips: statusedTrips != null
          ? (statusedTrips as List<dynamic>)
              .map(
                (e) => StatusedTripMapper().fromJson(
                  fromPostgres ? jsonDecode(e) : e,
                ),
              )
              .toList()
          : null,
      passengers: passengers != null
          ? (passengers as List<dynamic>)
              .map(
                (e) => PassengerMapper().fromJson(
                  fromPostgres ? jsonDecode(e) : e,
                ),
              )
              .toList()
          : null,
      paymentHistory: paymentHistory != null
          ? (paymentHistory as List<dynamic>)
              .map(
                (e) => PaymentMapper().fromJson(
                  fromPostgres ? jsonDecode(e) : e,
                ),
              )
              .toList()
          : null,
      searchHistory: searchHistory != null
          ? fromPostgres
              ? (searchHistory as List<List<dynamic>>)
                  // ignore: avoid_dynamic_calls
                  .map((e) => e.map((e) => e.toString()).toList())
                  .toList()
              : decodedSearchHistory?.toList()
          : null,
      isBlocked: json[_Fields.isBlocked],
    );
  }
}
