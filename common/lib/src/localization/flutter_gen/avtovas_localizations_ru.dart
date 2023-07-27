import 'package:intl/intl.dart' as intl;
export 'package:common/src/localization/flutter_gen/avtovas_localizations.dart';

// ignore_for_file: lines_longer_than_80_chars

/// The translations for Russian (`ru`).
class AvtovasLocalizationRu extends AvtovasLocalization {
  AvtovasLocalizationRu([String locale = 'ru']) : super(locale: locale);

  @override
  String get buyTicket => 'Купить билет';

  @override
  String get carrier => 'Перевозчик';

  @override
  String get flight => 'Рейс';

  @override
  String freePlaces(num count) {
    final temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мест',
      many: '$count мест',
      few: '$count места',
      two: '$count места',
      one: '$count место',
      zero: 'Продажи билетов прекращены',
    );
    return temp0;
  }

  @override
  String get help => 'Помощь';

  @override
  String get flightInformation => 'Информация о рейсе';

  @override
  String get inside => 'в';

  @override
  String get myTrips => 'Мои поездки';

  @override
  String get onWay => 'В пути: ';

  @override
  String get placesLeft => 'Осталось мест: ';

  @override
  String get primaryDetailsMessage => 'Отправление и прибытие по местному времени';

  @override
  String get profile => 'Профиль';

  @override
  String get returnConditions => 'Условия возврата';

  @override
  String get search => 'Поиск';

  @override
  String get secondaryDetailsMessage => 'Перевозчик имеет право заменить транспортное средство, в случае его неисправности, аварии и других аналогичных случаях';

  @override
  String get transport => 'Транспорт: ';

  @override
  String get tripDetails => 'Детали рейса';

  @override
  String get name => 'Имя';

  @override
  String get infoDeskOfTheCentralBusStation => 'Справочная Центрального автовокзала';

  @override
  String get from => 'с';

  @override
  String get to => 'до';

  @override
  String get daily => 'ежедневно';

  @override
  String get controlRoomOfTheCentralBusStation => 'Диспетчерская Центрального автовокзала';

  @override
  String get support => 'Служба технической поддержки';

  @override
  String get roundTheClock => 'Круглосуточно';

  @override
  String get contacts => 'Контакты автовокзалов';

  @override
  String get contactsItem => 'Чебоксары - Центральный автовокзал';

  @override
  String get waypoints => 'Промежуточные пункты';

  @override
  String get inquiry => 'Позвонить или задать вопрос';

  @override
  String get directoryInfo => 'Справочная информация';

  @override
  String get busStationContacts => 'Контакты автовокзалов';

  @override
  String get enterName => 'Введите имя';

  @override
  String get emailExample => 'example@example.ru';

  @override
  String get enterPhoneNumber => 'Введите номер телефона';

  @override
  String get enterQuestion => 'Введите вопрос';

  @override
  String get askQuestion => 'Задать вопрос';

  @override
  String get questionConsentText => 'Нажимая кнопку “Задать вопрос”, я даю';

  @override
  String get personalDataProcessingText => 'согласие на обработку персональных данных';

  @override
  String get call => 'Позвонить';

  @override
  String get technicalSupportService => 'Служба технической поддержки';

  @override
  String get centralBusStationHelpline => 'Справочная Центрального автовокзала';

  @override
  String get ourQualifiedExpertsWillHelp => 'Наши квалифицированные специалисты обязательно вам помогут.';

  @override
  String get twentyFourHours => 'круглосуточно';

  @override
  String get dailyFromFiveToTwenty => 'с 05:00 до 20:00 ежедневно';

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
