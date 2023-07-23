import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'avtovas_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AvtovasLocalization
/// returned by `AvtovasLocalization.of(context)`.
///
/// Applications need to include `AvtovasLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'flutter_gen/avtovas_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AvtovasLocalization.localizationsDelegates,
///   supportedLocales: AvtovasLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AvtovasLocalization.supportedLocales
/// property.
abstract class AvtovasLocalization {
  AvtovasLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AvtovasLocalization of(BuildContext context) {
    return Localizations.of<AvtovasLocalization>(context, AvtovasLocalization)!;
  }

  static const LocalizationsDelegate<AvtovasLocalization> delegate = _AvtovasLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru')
  ];

  /// No description provided for @buyTicket.
  ///
  /// In ru, this message translates to:
  /// **'Купить билет'**
  String get buyTicket;

  /// No description provided for @freePlaces.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =0{Продажи билетов прекращены} =1{{count} место} =2{{count} места} few{{count} места} many{{count} мест} other {{count} мест}}'**
  String freePlaces(num count);

  /// No description provided for @help.
  ///
  /// In ru, this message translates to:
  /// **'Помощь'**
  String get help;

  /// No description provided for @inside.
  ///
  /// In ru, this message translates to:
  /// **'в'**
  String get inside;

  /// No description provided for @myTrips.
  ///
  /// In ru, this message translates to:
  /// **'Мои поездки'**
  String get myTrips;

  /// No description provided for @placesLeft.
  ///
  /// In ru, this message translates to:
  /// **'Осталось мест: '**
  String get placesLeft;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @tripDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детали рейса'**
  String get tripDetails;

  /// No description provided for @name.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get name;

  /// No description provided for @info_desk_of_the_central_bus_station.
  ///
  /// In ru, this message translates to:
  /// **'Справочная Центрального автовокзала'**
  String get info_desk_of_the_central_bus_station;

  /// No description provided for @from.
  ///
  /// In ru, this message translates to:
  /// **'с'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ru, this message translates to:
  /// **'до'**
  String get to;

  /// No description provided for @daily.
  ///
  /// In ru, this message translates to:
  /// **'ежедневно'**
  String get daily;

  /// No description provided for @control_room_of_the_central_bus_station.
  ///
  /// In ru, this message translates to:
  /// **'Диспетчерская Центрального автовокзала'**
  String get control_room_of_the_central_bus_station;

  /// No description provided for @support.
  ///
  /// In ru, this message translates to:
  /// **'Служба технической поддержки'**
  String get support;

  /// No description provided for @round_the_clock.
  ///
  /// In ru, this message translates to:
  /// **'Круглосуточно'**
  String get round_the_clock;

  /// No description provided for @contacts.
  ///
  /// In ru, this message translates to:
  /// **'Контакты автовокзалов'**
  String get contacts;

  /// No description provided for @contacts_item.
  ///
  /// In ru, this message translates to:
  /// **'Чебоксары - Центральный автовокзал'**
  String get contacts_item;
}

class _AvtovasLocalizationDelegate extends LocalizationsDelegate<AvtovasLocalization> {
  const _AvtovasLocalizationDelegate();

  @override
  Future<AvtovasLocalization> load(Locale locale) {
    return SynchronousFuture<AvtovasLocalization>(lookupAvtovasLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(_AvtovasLocalizationDelegate old) => false;
}

AvtovasLocalization lookupAvtovasLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru': return AvtovasLocalizationRu();
    default: return AvtovasLocalizationRu();
  }
}

