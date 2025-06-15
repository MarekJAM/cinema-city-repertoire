///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get appName => 'Cinema City Repertoire';
	String get appBarTitlePart1 => 'Cinema City';
	String get appBarTitlePart2 => 'Repertoire';
	String get refresh => 'Refresh';
	String get back => 'Back';
	String get apply => 'Apply';
	String get reset => 'Reset';
	String get confirm => 'Confirm';
	String get save => 'Save';
	String get display => 'Display';
	String get buyTicket => 'Buy ticket on website';
	String get scheduleReminder => 'Schedule reminder';
	late final TranslationsRepertoireEn repertoire = TranslationsRepertoireEn._(_root);
	late final TranslationsFilmDetailsEn filmDetails = TranslationsFilmDetailsEn._(_root);
	late final TranslationsFiltersEn filters = TranslationsFiltersEn._(_root);
	late final TranslationsCinemasEn cinemas = TranslationsCinemasEn._(_root);
	late final TranslationsRemindersEn reminders = TranslationsRemindersEn._(_root);
	late final TranslationsGenresEn genres = TranslationsGenresEn._(_root);
	late final TranslationsLanguageTypeEn languageType = TranslationsLanguageTypeEn._(_root);
	late final TranslationsSeatplanEn seatplan = TranslationsSeatplanEn._(_root);
}

// Path: repertoire
class TranslationsRepertoireEn {
	TranslationsRepertoireEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get noFilmsToDisplayPickAnotherDate => 'No films to display. Pick another date or adjust filters.';
	String get pickDifferentDate => 'Pick a different date';
	String get adjustFilters => 'Adjust filters';
	String get noFilmsToDisplay => 'No films to display';
	String get pickCinemas => 'Pick cinemas';
	String get failedToLoad => 'Failed to load data';
}

// Path: filmDetails
class TranslationsFilmDetailsEn {
	TranslationsFilmDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get premiere => 'Premiere';
	String get filmLength => 'Film length';
	String filmLengthValue({required Object val}) => '${val} min';
	String get filmTitle => 'Title';
	String get filmGenre => 'Genre';
	String get cast => 'Cast';
	String get director => 'Director';
	String get production => 'Production';
	String get rating => 'Rating';
	String get ratingNoData => 'No data';
	String get seeTrailer => 'Watch trailer';
	String get failedToLoad => 'Failed to load film details';
	String get posterError => 'Failed to load poster';
}

// Path: filters
class TranslationsFiltersEn {
	TranslationsFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Filters';
	String get genre => 'Genre';
	String get typeOfShow => 'Type of session';
	String get noRating => 'No rating';
	String get minimalRating => 'Minimal rating';
	String get selectAll => 'Select all';
	String get unselectAll => 'Unselect all';
}

// Path: cinemas
class TranslationsCinemasEn {
	TranslationsCinemasEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Cinemas';
	String get pickCinemas => 'Select cinemas';
	String get savedAsFavorite => 'Saved as favorite';
	String get failedToLoad => 'Failed to load list of cinemas';
}

// Path: reminders
class TranslationsRemindersEn {
	TranslationsRemindersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String filmReminder({required Object time}) => 'Reminder - ${time}';
	String get reminderScheduled => 'Reminder scheduled';
	String get selectReminderTime => 'Select reminder time';
}

// Path: genres
class TranslationsGenresEn {
	TranslationsGenresEn._(this._root);

	final Translations _root; // ignore: unused_field

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

// Path: languageType
class TranslationsLanguageTypeEn {
	TranslationsLanguageTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get original => 'PL';
	String get subtitles => 'Subtitles';
	String get dubbing => 'Dubbing';
}

// Path: seatplan
class TranslationsSeatplanEn {
	TranslationsSeatplanEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get availableSeats => 'Available seats';
	String get ticketingFinished => 'Ticketing finished';
	String get failedToLoad => 'No info about available seats';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Cinema City Repertoire';
			case 'appBarTitlePart1': return 'Cinema City';
			case 'appBarTitlePart2': return 'Repertoire';
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
			case 'repertoire.failedToLoad': return 'Failed to load data';
			case 'filmDetails.premiere': return 'Premiere';
			case 'filmDetails.filmLength': return 'Film length';
			case 'filmDetails.filmLengthValue': return ({required Object val}) => '${val} min';
			case 'filmDetails.filmTitle': return 'Title';
			case 'filmDetails.filmGenre': return 'Genre';
			case 'filmDetails.cast': return 'Cast';
			case 'filmDetails.director': return 'Director';
			case 'filmDetails.production': return 'Production';
			case 'filmDetails.rating': return 'Rating';
			case 'filmDetails.ratingNoData': return 'No data';
			case 'filmDetails.seeTrailer': return 'Watch trailer';
			case 'filmDetails.failedToLoad': return 'Failed to load film details';
			case 'filmDetails.posterError': return 'Failed to load poster';
			case 'filters.name': return 'Filters';
			case 'filters.genre': return 'Genre';
			case 'filters.typeOfShow': return 'Type of session';
			case 'filters.noRating': return 'No rating';
			case 'filters.minimalRating': return 'Minimal rating';
			case 'filters.selectAll': return 'Select all';
			case 'filters.unselectAll': return 'Unselect all';
			case 'cinemas.name': return 'Cinemas';
			case 'cinemas.pickCinemas': return 'Select cinemas';
			case 'cinemas.savedAsFavorite': return 'Saved as favorite';
			case 'cinemas.failedToLoad': return 'Failed to load list of cinemas';
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
			case 'languageType.original': return 'PL';
			case 'languageType.subtitles': return 'Subtitles';
			case 'languageType.dubbing': return 'Dubbing';
			case 'seatplan.availableSeats': return 'Available seats';
			case 'seatplan.ticketingFinished': return 'Ticketing finished';
			case 'seatplan.failedToLoad': return 'No info about available seats';
			default: return null;
		}
	}
}

