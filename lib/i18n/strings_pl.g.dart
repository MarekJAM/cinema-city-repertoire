///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

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

/// The flat map containing all translations for locale <pl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		return switch (path) {
			'appName' => 'Cinema City Repertuar',
			'appBarTitlePart1' => 'Cinema City',
			'appBarTitlePart2' => 'Repertuar',
			'refresh' => 'Odswież',
			'back' => 'Powrót',
			'apply' => 'Zastosuj',
			'reset' => 'Reset',
			'confirm' => 'Zatwiedź',
			'save' => 'Zapisz',
			'display' => 'Wyświetl',
			'buyTicket' => 'Kup bilet przez stronę',
			'scheduleReminder' => 'Ustaw przypomnienie',
			'repertoire.noFilmsToDisplayPickAnotherDate' => 'Brak filmów do wyświetlenia. Wybierz inną datę lub dostosuj filtry.',
			'repertoire.pickDifferentDate' => 'Wybierz inną datę',
			'repertoire.adjustFilters' => 'Dostosuj filtry',
			'repertoire.noFilmsToDisplay' => 'Brak filmów do wyświetlenia',
			'repertoire.pickCinemas' => 'Wybierz kina',
			'repertoire.failedToLoad' => 'W trakcie pobierania danych wystąpił błąd',
			'filmDetails.premiere' => 'Premiera',
			'filmDetails.filmLength' => 'Czas trwania',
			'filmDetails.filmLengthValue' => ({required Object val}) => '${val} min',
			'filmDetails.filmTitle' => 'Tytuł',
			'filmDetails.filmGenre' => 'Gatunek',
			'filmDetails.cast' => 'Obsada',
			'filmDetails.director' => 'Reżyser',
			'filmDetails.production' => 'Produkcja',
			'filmDetails.rating' => 'Ocena',
			'filmDetails.ratingNoData' => 'Brak danych',
			'filmDetails.seeTrailer' => 'Zobacz zwiastun',
			'filmDetails.failedToLoad' => 'Nie udadło się pobrać informacji o filmie',
			'filmDetails.posterError' => 'Nie udało się pobrać plakatu',
			'filters.name' => 'Filtry',
			'filters.genre' => 'Gatunek',
			'filters.typeOfShow' => 'Rodzaj seansu',
			'filters.noRating' => 'Bez oceny',
			'filters.minimalRating' => 'Minimalna ocena',
			'filters.selectAll' => 'Zaznacz wszystko',
			'filters.unselectAll' => 'Odznacz wszystko',
			'cinemas.name' => 'Kina',
			'cinemas.pickCinemas' => 'Wybierz kina',
			'cinemas.savedAsFavorite' => 'Zapisano kina jako ulubione',
			'cinemas.failedToLoad' => 'Nie udało się pobrać listy kin',
			'reminders.filmReminder' => ({required Object time}) => 'Przypomnienie o seansie - ${time}',
			'reminders.reminderScheduled' => 'Zaplanowano przypomnienie',
			'reminders.selectReminderTime' => 'Wybierz czas przypomnienia',
			'genres.action' => 'Akcja',
			'genres.adventure' => 'Przygodowy',
			'genres.animation' => 'Animacja',
			'genres.bollywood' => 'Bollywood',
			'genres.comedy' => 'Komedia',
			'genres.crime' => 'Kryminalny',
			'genres.documentary' => 'Dokument',
			'genres.drama' => 'Dramat',
			'genres.family' => 'Familijny',
			'genres.fantasy' => 'Fantasy',
			'genres.history' => 'Historyczny',
			'genres.horror' => 'Horror',
			'genres.kidsClub' => 'Dla dzieci',
			'genres.live' => 'Na żywo',
			'genres.musical' => 'Musical',
			'genres.romance' => 'Romantyczny',
			'genres.sciFi' => 'Sci-fi',
			'genres.sport' => 'Sport',
			'genres.thriller' => 'Thriller',
			'genres.war' => 'Wojenny',
			'genres.western' => 'Western',
			'genres.unspecified' => 'Nieokreślony',
			'languageType.original' => 'PL',
			'languageType.subtitles' => 'Napisy',
			'languageType.dubbing' => 'Dubbing',
			'seatplan.availableSeats' => 'Dostępne miejsca',
			'seatplan.ticketingFinished' => 'Sprzedaż biletów zakończona',
			'seatplan.failedToLoad' => 'Brak danych o dostępnych miejscach',
			_ => null,
		};
	}
}

