import 'package:intl/intl.dart' as intl;

import 'avtovas_localizations.dart';

// ignore_for_file: unnecessary_string_interpolations
// ignore_for_file: use_super_parameters
// ignore_for_file: always_use_package_imports
// ignore_for_file: prefer-match-file-name,
// ignore_for_file: omit_local_variable_types,
// ignore_for_file: avoid-non-ascii-symbols
// ignore_for_file: member-ordering
// ignore_for_file: prefer_final_locals
// ignore_for_file: no_leading_underscores_for_local_identifiers

/// The translations for Russian (`ru`).
class AvtovasLocalizationRu extends AvtovasLocalization {
  AvtovasLocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get buyTicket => 'Купить билет';

  @override
  String freePlaces(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мест',
      many: '$count мест',
      few: '$count места',
      two: '$count места',
      one: '$count место',
      zero: 'Продажи билетов прекращены',
    );
    return '$_temp0';
  }

  @override
  String get help => 'Помощь';

  @override
  String get inside => 'в';

  @override
  String get myTrips => 'Мои поездки';

  @override
  String get placesLeft => 'Осталось мест: ';

  @override
  String get profile => 'Профиль';

  @override
  String get search => 'Поиск';

  @override
  String get tripDetails => 'Детали рейса';

  @override
  String get name => 'Имя';

  @override
  String get sortByTime => 'Сортировка по времени';

  @override
  String get sortByPrice => 'Сортировка по цене';

  @override
  String get passport => 'Паспорт';

  @override
  String get internationalPassport => 'Заграничный паспорт';

  @override
  String get birthCertificate => 'Свидетельство о рождении';

  @override
  String get childish => 'Детский ';

  @override
  String get passengers => 'Пассажирский';
}
