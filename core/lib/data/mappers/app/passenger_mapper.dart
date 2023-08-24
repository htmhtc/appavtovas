import 'package:core/data/mappers/base_mapper.dart';
import 'package:core/domain/entities/app_entities/passenger.dart';

abstract final class _Fields {
  static const String uuid = 'uuid';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String surname = 'surname';
  static const String gender = 'gender';
  static const String birthdayDate = 'birthdayDate';
  static const String citizenship = 'citizenship';
  static const String documentType = 'documentType';
  static const String documentData = 'documentData';
  static const String rate = 'rate';
}

final class PassengerMapper implements BaseMapper<Passenger> {
  @override
  Map<String, dynamic> toJson(Passenger data) {
    return {
      _Fields.uuid: data.uuid,
      _Fields.firstName: data.firstName,
      _Fields.lastName: data.lastName,
      _Fields.surname: data.surname,
      _Fields.gender: data.gender,
      _Fields.birthdayDate: data.birthdayDate.toString(),
      _Fields.citizenship: data.citizenship,
      _Fields.documentType: data.documentType,
      _Fields.documentData: data.documentData,
      _Fields.rate: data.rate,
    };
  }

  @override
  Passenger fromJson(Map<String, dynamic> json) {
    return Passenger(
      uuid: json[_Fields.uuid],
      firstName: json[_Fields.firstName],
      lastName: json[_Fields.lastName],
      surname: json[_Fields.surname],
      gender: json[_Fields.gender],
      birthdayDate: DateTime.parse(json[_Fields.birthdayDate]),
      citizenship: json[_Fields.citizenship],
      documentType: json[_Fields.documentType],
      documentData: json[_Fields.documentData],
      rate: json[_Fields.rate],
    );
  }
}