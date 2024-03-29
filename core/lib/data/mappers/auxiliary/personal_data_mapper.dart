import 'package:core/avtovas_core.dart';
import 'package:core/data/mappers/base_mapper.dart';

final class PersonalDataMapper implements BaseMapper<PersonalData> {
  @override
  Map<String, dynamic> toJson(PersonalData data) {
    throw UnimplementedError();
  }

  @override
  PersonalData fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  PersonalData personalDataFromPassenger(
    Passenger passenger,
  ) {
    final nameList = [
      passenger.lastName.replaceAll(RegExp(r'\s+'), ''),
      passenger.firstName.replaceAll(RegExp(r'\s+'), ''),
      if (passenger.surname != null)
        passenger.surname!.replaceAll(RegExp(r'\s+'), '')
      else
        '-',
    ];

    return PersonalData(
      ticketNumber: '',
      seatNum: '',
      fareName: '',
      fullName: nameList.join(' '),
      documentNum: passenger.documentData,
      documentType: passenger.documentType,
      phoneNumber: '',
      dateOfBirth: passenger.birthdayDate.toString(),
      gender: passenger.gender,
      citizenship: passenger.citizenship,
      email: '',
    );
  }

  Passenger passengerFromPersonalData(PersonalData data) {
    final nameList = data.fullName.split(' ');

    return Passenger(
      uuid: generateUuid(),
      firstName: nameList[1],
      lastName: nameList[0],
      surname: nameList.length > 2 ? nameList[2] : null,
      gender: data.gender,
      birthdayDate: DateTime.parse(data.dateOfBirth),
      citizenship: data.citizenship,
      documentType: data.documentType,
      createdAt: DateTime.now(),
      documentData: data.documentNum,
    );
  }
}
