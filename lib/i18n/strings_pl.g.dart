///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsPl implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsPl _root = this; // ignore: unused_field

	@override 
	TranslationsPl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPl(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'Cinema City Repertuar';
	@override String get appBarTitlePart1 => 'Cinema City';
	@override String get appBarTitlePart2 => 'Repertuar';
	@override String get refresh => 'Odswież';
	@override String get back => 'Powrót';
	@override String get apply => 'Zastosuj';
	@override String get reset => 'Reset';
	@override String get confirm => 'Zatwiedź';
	@override String get save => 'Zapisz';
	@override String get display => 'Wyświetl';
	@override String get buyTicket => 'Kup bilet przez stronę';
	@override String get scheduleReminder => 'Ustaw przypomnienie';
	@override late final _TranslationsRepertoirePl repertoire = _TranslationsRepertoirePl._(_root);
	@override late final _TranslationsFilmDetailsPl filmDetails = _TranslationsFilmDetailsPl._(_root);
	@override late final _TranslationsFiltersPl filters = _TranslationsFiltersPl._(_root);
	@override late final _TranslationsCinemasPl cinemas = _TranslationsCinemasPl._(_root);
	@override late final _TranslationsRemindersPl reminders = _TranslationsRemindersPl._(_root);
	@override late final _TranslationsGenresPl genres = _TranslationsGenresPl._(_root);
	@override late final _TranslationsLanguageTypePl languageType = _TranslationsLanguageTypePl._(_root);
	@override late final _TranslationsSeatplanPl seatplan = _TranslationsSeatplanPl._(_root);
}

// Path: repertoire
class _TranslationsRepertoirePl implements TranslationsRepertoireEn {
	_TranslationsRepertoirePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get noFilmsToDisplayPickAnotherDate => 'Brak filmów do wyświetlenia. Wybierz inną datę lub dostosuj filtry.';
	@override String get pickDifferentDate => 'Wybierz inną datę';
	@override String get adjustFilters => 'Dostosuj filtry';
	@override String get noFilmsToDisplay => 'Brak filmów do wyświetlenia';
	@override String get pickCinemas => 'Wybierz kina';
	@override String get failedToLoad => 'W trakcie pobierania danych wystąpił błąd';
}

// Path: filmDetails
class _TranslationsFilmDetailsPl implements TranslationsFilmDetailsEn {
	_TranslationsFilmDetailsPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get premiere => 'Premiera';
	@override String get filmLength => 'Czas trwania';
	@override String filmLengthValue({required Object val}) => '${val} min';
	@override String get filmTitle => 'Tytuł';
	@override String get filmGenre => 'Gatunek';
	@override String get cast => 'Obsada';
	@override String get director => 'Reżyser';
	@override String get production => 'Produkcja';
	@override String get rating => 'Ocena';
	@override String get ratingNoData => 'Brak danych';
	@override String get seeTrailer => 'Zobacz zwiastun';
	@override String get failedToLoad => 'Nie udadło się pobrać informacji o filmie';
	@override String get posterError => 'Nie udało się pobrać plakatu';
}

// Path: filters
class _TranslationsFiltersPl implements TranslationsFiltersEn {
	_TranslationsFiltersPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Filtry';
	@override String get genre => 'Gatunek';
	@override String get typeOfShow => 'Rodzaj seansu';
	@override String get noRating => 'Bez oceny';
	@override String get minimalRating => 'Minimalna ocena';
	@override String get selectAll => 'Zaznacz wszystko';
	@override String get unselectAll => 'Odznacz wszystko';
}

// Path: cinemas
class _TranslationsCinemasPl implements TranslationsCinemasEn {
	_TranslationsCinemasPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kina';
	@override String get pickCinemas => 'Wybierz kina';
	@override String get savedAsFavorite => 'Zapisano kina jako ulubione';
	@override String get failedToLoad => 'Nie udało się pobrać listy kin';
}

// Path: reminders
class _TranslationsRemindersPl implements TranslationsRemindersEn {
	_TranslationsRemindersPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String filmReminder({required Object time}) => 'Przypomnienie o seansie - ${time}';
	@override String get reminderScheduled => 'Zaplanowano przypomnienie';
	@override String get selectReminderTime => 'Wybierz czas przypomnienia';
}

// Path: genres
class _TranslationsGenresPl implements TranslationsGenresEn {
	_TranslationsGenresPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get action => 'Akcja';
	@override String get adventure => 'Przygodowy';
	@override String get animation => 'Animacja';
	@override String get bollywood => 'Bollywood';
	@override String get comedy => 'Komedia';
	@override String get crime => 'Kryminalny';
	@override String get documentary => 'Dokument';
	@override String get drama => 'Dramat';
	@override String get family => 'Familijny';
	@override String get fantasy => 'Fantasy';
	@override String get history => 'Historyczny';
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

// Path: languageType
class _TranslationsLanguageTypePl implements TranslationsLanguageTypeEn {
	_TranslationsLanguageTypePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get original => 'PL';
	@override String get subtitles => 'Napisy';
	@override String get dubbing => 'Dubbing';
}

// Path: seatplan
class _TranslationsSeatplanPl implements TranslationsSeatplanEn {
	_TranslationsSeatplanPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get availableSeats => 'Dostępne miejsca';
	@override String get ticketingFinished => 'Sprzedaż biletów zakończona';
	@override String get failedToLoad => 'Brak danych o dostępnych miejscach';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Cinema City Repertuar';
			case 'appBarTitlePart1': return 'Cinema City';
			case 'appBarTitlePart2': return 'Repertuar';
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
			case 'repertoire.failedToLoad': return 'W trakcie pobierania danych wystąpił błąd';
			case 'filmDetails.premiere': return 'Premiera';
			case 'filmDetails.filmLength': return 'Czas trwania';
			case 'filmDetails.filmLengthValue': return ({required Object val}) => '${val} min';
			case 'filmDetails.filmTitle': return 'Tytuł';
			case 'filmDetails.filmGenre': return 'Gatunek';
			case 'filmDetails.cast': return 'Obsada';
			case 'filmDetails.director': return 'Reżyser';
			case 'filmDetails.production': return 'Produkcja';
			case 'filmDetails.rating': return 'Ocena';
			case 'filmDetails.ratingNoData': return 'Brak danych';
			case 'filmDetails.seeTrailer': return 'Zobacz zwiastun';
			case 'filmDetails.failedToLoad': return 'Nie udadło się pobrać informacji o filmie';
			case 'filmDetails.posterError': return 'Nie udało się pobrać plakatu';
			case 'filters.name': return 'Filtry';
			case 'filters.genre': return 'Gatunek';
			case 'filters.typeOfShow': return 'Rodzaj seansu';
			case 'filters.noRating': return 'Bez oceny';
			case 'filters.minimalRating': return 'Minimalna ocena';
			case 'filters.selectAll': return 'Zaznacz wszystko';
			case 'filters.unselectAll': return 'Odznacz wszystko';
			case 'cinemas.name': return 'Kina';
			case 'cinemas.pickCinemas': return 'Wybierz kina';
			case 'cinemas.savedAsFavorite': return 'Zapisano kina jako ulubione';
			case 'cinemas.failedToLoad': return 'Nie udało się pobrać listy kin';
			case 'reminders.filmReminder': return ({required Object time}) => 'Przypomnienie o seansie - ${time}';
			case 'reminders.reminderScheduled': return 'Zaplanowano przypomnienie';
			case 'reminders.selectReminderTime': return 'Wybierz czas przypomnienia';
			case 'genres.action': return 'Akcja';
			case 'genres.adventure': return 'Przygodowy';
			case 'genres.animation': return 'Animacja';
			case 'genres.bollywood': return 'Bollywood';
			case 'genres.comedy': return 'Komedia';
			case 'genres.crime': return 'Kryminalny';
			case 'genres.documentary': return 'Dokument';
			case 'genres.drama': return 'Dramat';
			case 'genres.family': return 'Familijny';
			case 'genres.fantasy': return 'Fantasy';
			case 'genres.history': return 'Historyczny';
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
			case 'languageType.original': return 'PL';
			case 'languageType.subtitles': return 'Napisy';
			case 'languageType.dubbing': return 'Dubbing';
			case 'seatplan.availableSeats': return 'Dostępne miejsca';
			case 'seatplan.ticketingFinished': return 'Sprzedaż biletów zakończona';
			case 'seatplan.failedToLoad': return 'Brak danych o dostępnych miejscach';
			default: return null;
		}
	}
}

