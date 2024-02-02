/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 116 (58 per locale)
///
/// Built on 2024-02-01 at 22:49 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	pl(languageCode: 'pl', build: _StringsPl.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get appName => 'Cinema City Repertoire';
	String get refresh => 'Refresh';
	String get back => 'Back';
	String get apply => 'Apply';
	String get reset => 'Reset';
	String get confirm => 'Confirm';
	String get save => 'Save';
	String get display => 'Display';
	String get buyTicket => 'Buy ticket on website';
	String get scheduleReminder => 'Schedule reminder';
	late final _StringsRepertoireEn repertoire = _StringsRepertoireEn._(_root);
	late final _StringsFilmDetailsEn filmDetails = _StringsFilmDetailsEn._(_root);
	late final _StringsFiltersEn filters = _StringsFiltersEn._(_root);
	late final _StringsCinemasEn cinemas = _StringsCinemasEn._(_root);
	late final _StringsRemindersEn reminders = _StringsRemindersEn._(_root);
	late final _StringsGenresEn genres = _StringsGenresEn._(_root);
}

// Path: repertoire
class _StringsRepertoireEn {
	_StringsRepertoireEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get noFilmsToDisplayPickAnotherDate => 'No films to display. Pick another date or adjust filters.';
	String get pickDifferentDate => 'Pick a different date';
	String get adjustFilters => 'Adjust filters';
	String get noFilmsToDisplay => 'No films to display';
	String get pickCinemas => 'Pick cinemas';
}

// Path: filmDetails
class _StringsFilmDetailsEn {
	_StringsFilmDetailsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get premiere => 'Premiere';
	String get filmLength => 'Film length';
	String filmLengthValue({required Object val}) => '${val} min';
	String get filmTitle => 'Title';
	String get filmGenre => 'Genre';
	String get cast => 'Cast';
	String get director => 'Director';
	String get production => 'Production';
	String get score => 'Score';
	String get scoreNoData => 'No data';
	String get seeTrailer => 'Watch trailer';
}

// Path: filters
class _StringsFiltersEn {
	_StringsFiltersEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Filters';
	String get genre => 'Genre';
	String get typeOfShow => 'Type of session';
	String get noScore => 'No score';
	String get minimalScore => 'Minimal score';
}

// Path: cinemas
class _StringsCinemasEn {
	_StringsCinemasEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Cinemas';
	String get savedAsFavorite => 'Saved as favorite';
}

// Path: reminders
class _StringsRemindersEn {
	_StringsRemindersEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String filmReminder({required Object time}) => 'Reminder - ${time}';
	String get reminderScheduled => 'Reminder scheduled';
	String get selectReminderTime => 'Select reminder time';
}

// Path: genres
class _StringsGenresEn {
	_StringsGenresEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get action => 'Action';
	String get adventure => 'Adventure';
	String get animation => 'Animation';
	String get bollywood => 'Bollywoood';
	String get comedy => 'Comedy';
	String get crime => 'Crime';
	String get documentary => 'Documentary';
	String get drama => 'Drama';
	String get family => 'Family';
	String get fantasy => 'Fantasy';
	String get history => 'History';
	String get horror => 'Horror';
	String get kidsClub => 'Kids club';
	String get live => 'Love';
	String get musical => 'Musical';
	String get romance => 'Romance';
	String get sciFi => 'Sci-fi';
	String get sport => 'Sport';
	String get thriller => 'Thriller';
	String get war => 'War';
	String get western => 'Western';
	String get unspecified => 'Unspecified';
}

// Path: <root>
class _StringsPl implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsPl.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsPl _root = this; // ignore: unused_field

	// Translations
	@override String get appName => 'Cinema City Repertuar';
	@override String get refresh => 'Odswież';
	@override String get back => 'Powrót';
	@override String get apply => 'Zastosuj';
	@override String get reset => 'Reset';
	@override String get confirm => 'Zatwiedź';
	@override String get save => 'Zapisz';
	@override String get display => 'Wyświetl';
	@override String get buyTicket => 'Kup bilet przez stronę';
	@override String get scheduleReminder => 'Ustaw przypomnienie';
	@override late final _StringsRepertoirePl repertoire = _StringsRepertoirePl._(_root);
	@override late final _StringsFilmDetailsPl filmDetails = _StringsFilmDetailsPl._(_root);
	@override late final _StringsFiltersPl filters = _StringsFiltersPl._(_root);
	@override late final _StringsCinemasPl cinemas = _StringsCinemasPl._(_root);
	@override late final _StringsRemindersPl reminders = _StringsRemindersPl._(_root);
	@override late final _StringsGenresPl genres = _StringsGenresPl._(_root);
}

// Path: repertoire
class _StringsRepertoirePl implements _StringsRepertoireEn {
	_StringsRepertoirePl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String get noFilmsToDisplayPickAnotherDate => 'Brak filmów do wyświetlenia. Wybierz inną datę lub dostosuj filtry.';
	@override String get pickDifferentDate => 'Wybierz inną datę';
	@override String get adjustFilters => 'Dostosuj filtry';
	@override String get noFilmsToDisplay => 'Brak filmów do wyświetlenia';
	@override String get pickCinemas => 'Wybierz kina';
}

// Path: filmDetails
class _StringsFilmDetailsPl implements _StringsFilmDetailsEn {
	_StringsFilmDetailsPl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String get premiere => 'Premiera';
	@override String get filmLength => 'Czas trwania';
	@override String filmLengthValue({required Object val}) => '${val} min';
	@override String get filmTitle => 'Tytuł';
	@override String get filmGenre => 'Gatunek';
	@override String get cast => 'Obsada';
	@override String get director => 'Reżyser';
	@override String get production => 'Produkcja';
	@override String get score => 'Ocena';
	@override String get scoreNoData => 'Brak danych';
	@override String get seeTrailer => 'Zobacz zwiastun';
}

// Path: filters
class _StringsFiltersPl implements _StringsFiltersEn {
	_StringsFiltersPl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Filtry';
	@override String get genre => 'Gatunek';
	@override String get typeOfShow => 'Rodzaj seansu';
	@override String get noScore => 'Bez oceny';
	@override String get minimalScore => 'Minimalna ocena';
}

// Path: cinemas
class _StringsCinemasPl implements _StringsCinemasEn {
	_StringsCinemasPl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kina';
	@override String get savedAsFavorite => 'Zapisano kina jako ulubione';
}

// Path: reminders
class _StringsRemindersPl implements _StringsRemindersEn {
	_StringsRemindersPl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String filmReminder({required Object time}) => 'Przypomnienie o seansie - ${time}';
	@override String get reminderScheduled => 'Zaplanowano przypomnienie';
	@override String get selectReminderTime => 'Wybierz czas przypomnienia';
}

// Path: genres
class _StringsGenresPl implements _StringsGenresEn {
	_StringsGenresPl._(this._root);

	@override final _StringsPl _root; // ignore: unused_field

	// Translations
	@override String get action => 'Akcja';
	@override String get adventure => 'Przygodowy';
	@override String get animation => 'Animacja';
	@override String get bollywood => 'Bollywoood';
	@override String get comedy => 'Komedia';
	@override String get crime => 'Kryminalny';
	@override String get documentary => 'Dokument';
	@override String get drama => 'Dramat';
	@override String get family => 'Familijny';
	@override String get fantasy => 'Fantasy';
	@override String get history => 'Historczny';
	@override String get horror => 'Horror';
	@override String get kidsClub => 'Dla dzieci';
	@override String get live => 'Na żywo';
	@override String get musical => 'Musical';
	@override String get romance => 'Romantyczny';
	@override String get sciFi => 'Sci-fi';
	@override String get sport => 'Sport';
	@override String get thriller => 'Thriller';
	@override String get war => 'Wojenny';
	@override String get western => 'Western';
	@override String get unspecified => 'Nieokreślony';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Cinema City Repertoire';
			case 'refresh': return 'Refresh';
			case 'back': return 'Back';
			case 'apply': return 'Apply';
			case 'reset': return 'Reset';
			case 'confirm': return 'Confirm';
			case 'save': return 'Save';
			case 'display': return 'Display';
			case 'buyTicket': return 'Buy ticket on website';
			case 'scheduleReminder': return 'Schedule reminder';
			case 'repertoire.noFilmsToDisplayPickAnotherDate': return 'No films to display. Pick another date or adjust filters.';
			case 'repertoire.pickDifferentDate': return 'Pick a different date';
			case 'repertoire.adjustFilters': return 'Adjust filters';
			case 'repertoire.noFilmsToDisplay': return 'No films to display';
			case 'repertoire.pickCinemas': return 'Pick cinemas';
			case 'filmDetails.premiere': return 'Premiere';
			case 'filmDetails.filmLength': return 'Film length';
			case 'filmDetails.filmLengthValue': return ({required Object val}) => '${val} min';
			case 'filmDetails.filmTitle': return 'Title';
			case 'filmDetails.filmGenre': return 'Genre';
			case 'filmDetails.cast': return 'Cast';
			case 'filmDetails.director': return 'Director';
			case 'filmDetails.production': return 'Production';
			case 'filmDetails.score': return 'Score';
			case 'filmDetails.scoreNoData': return 'No data';
			case 'filmDetails.seeTrailer': return 'Watch trailer';
			case 'filters.name': return 'Filters';
			case 'filters.genre': return 'Genre';
			case 'filters.typeOfShow': return 'Type of session';
			case 'filters.noScore': return 'No score';
			case 'filters.minimalScore': return 'Minimal score';
			case 'cinemas.name': return 'Cinemas';
			case 'cinemas.savedAsFavorite': return 'Saved as favorite';
			case 'reminders.filmReminder': return ({required Object time}) => 'Reminder - ${time}';
			case 'reminders.reminderScheduled': return 'Reminder scheduled';
			case 'reminders.selectReminderTime': return 'Select reminder time';
			case 'genres.action': return 'Action';
			case 'genres.adventure': return 'Adventure';
			case 'genres.animation': return 'Animation';
			case 'genres.bollywood': return 'Bollywoood';
			case 'genres.comedy': return 'Comedy';
			case 'genres.crime': return 'Crime';
			case 'genres.documentary': return 'Documentary';
			case 'genres.drama': return 'Drama';
			case 'genres.family': return 'Family';
			case 'genres.fantasy': return 'Fantasy';
			case 'genres.history': return 'History';
			case 'genres.horror': return 'Horror';
			case 'genres.kidsClub': return 'Kids club';
			case 'genres.live': return 'Love';
			case 'genres.musical': return 'Musical';
			case 'genres.romance': return 'Romance';
			case 'genres.sciFi': return 'Sci-fi';
			case 'genres.sport': return 'Sport';
			case 'genres.thriller': return 'Thriller';
			case 'genres.war': return 'War';
			case 'genres.western': return 'Western';
			case 'genres.unspecified': return 'Unspecified';
			default: return null;
		}
	}
}

extension on _StringsPl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Cinema City Repertuar';
			case 'refresh': return 'Odswież';
			case 'back': return 'Powrót';
			case 'apply': return 'Zastosuj';
			case 'reset': return 'Reset';
			case 'confirm': return 'Zatwiedź';
			case 'save': return 'Zapisz';
			case 'display': return 'Wyświetl';
			case 'buyTicket': return 'Kup bilet przez stronę';
			case 'scheduleReminder': return 'Ustaw przypomnienie';
			case 'repertoire.noFilmsToDisplayPickAnotherDate': return 'Brak filmów do wyświetlenia. Wybierz inną datę lub dostosuj filtry.';
			case 'repertoire.pickDifferentDate': return 'Wybierz inną datę';
			case 'repertoire.adjustFilters': return 'Dostosuj filtry';
			case 'repertoire.noFilmsToDisplay': return 'Brak filmów do wyświetlenia';
			case 'repertoire.pickCinemas': return 'Wybierz kina';
			case 'filmDetails.premiere': return 'Premiera';
			case 'filmDetails.filmLength': return 'Czas trwania';
			case 'filmDetails.filmLengthValue': return ({required Object val}) => '${val} min';
			case 'filmDetails.filmTitle': return 'Tytuł';
			case 'filmDetails.filmGenre': return 'Gatunek';
			case 'filmDetails.cast': return 'Obsada';
			case 'filmDetails.director': return 'Reżyser';
			case 'filmDetails.production': return 'Produkcja';
			case 'filmDetails.score': return 'Ocena';
			case 'filmDetails.scoreNoData': return 'Brak danych';
			case 'filmDetails.seeTrailer': return 'Zobacz zwiastun';
			case 'filters.name': return 'Filtry';
			case 'filters.genre': return 'Gatunek';
			case 'filters.typeOfShow': return 'Rodzaj seansu';
			case 'filters.noScore': return 'Bez oceny';
			case 'filters.minimalScore': return 'Minimalna ocena';
			case 'cinemas.name': return 'Kina';
			case 'cinemas.savedAsFavorite': return 'Zapisano kina jako ulubione';
			case 'reminders.filmReminder': return ({required Object time}) => 'Przypomnienie o seansie - ${time}';
			case 'reminders.reminderScheduled': return 'Zaplanowano przypomnienie';
			case 'reminders.selectReminderTime': return 'Wybierz czas przypomnienia';
			case 'genres.action': return 'Akcja';
			case 'genres.adventure': return 'Przygodowy';
			case 'genres.animation': return 'Animacja';
			case 'genres.bollywood': return 'Bollywoood';
			case 'genres.comedy': return 'Komedia';
			case 'genres.crime': return 'Kryminalny';
			case 'genres.documentary': return 'Dokument';
			case 'genres.drama': return 'Dramat';
			case 'genres.family': return 'Familijny';
			case 'genres.fantasy': return 'Fantasy';
			case 'genres.history': return 'Historczny';
			case 'genres.horror': return 'Horror';
			case 'genres.kidsClub': return 'Dla dzieci';
			case 'genres.live': return 'Na żywo';
			case 'genres.musical': return 'Musical';
			case 'genres.romance': return 'Romantyczny';
			case 'genres.sciFi': return 'Sci-fi';
			case 'genres.sport': return 'Sport';
			case 'genres.thriller': return 'Thriller';
			case 'genres.war': return 'Wojenny';
			case 'genres.western': return 'Western';
			case 'genres.unspecified': return 'Nieokreślony';
			default: return null;
		}
	}
}
