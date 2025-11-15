///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

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

	/// en: 'Cinema City Repertoire'
	String get appName => 'Cinema City Repertoire';

	/// en: 'Cinema City'
	String get appBarTitlePart1 => 'Cinema City';

	/// en: 'Repertoire'
	String get appBarTitlePart2 => 'Repertoire';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Display'
	String get display => 'Display';

	/// en: 'Buy ticket on website'
	String get buyTicket => 'Buy ticket on website';

	/// en: 'Schedule reminder'
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

	/// en: 'No films to display. Pick another date or adjust filters.'
	String get noFilmsToDisplayPickAnotherDate => 'No films to display. Pick another date or adjust filters.';

	/// en: 'Pick a different date'
	String get pickDifferentDate => 'Pick a different date';

	/// en: 'Adjust filters'
	String get adjustFilters => 'Adjust filters';

	/// en: 'No films to display'
	String get noFilmsToDisplay => 'No films to display';

	/// en: 'Pick cinemas'
	String get pickCinemas => 'Pick cinemas';

	/// en: 'Failed to load data'
	String get failedToLoad => 'Failed to load data';
}

// Path: filmDetails
class TranslationsFilmDetailsEn {
	TranslationsFilmDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Premiere'
	String get premiere => 'Premiere';

	/// en: 'Film length'
	String get filmLength => 'Film length';

	/// en: '$val min'
	String filmLengthValue({required Object val}) => '${val} min';

	/// en: 'Title'
	String get filmTitle => 'Title';

	/// en: 'Genre'
	String get filmGenre => 'Genre';

	/// en: 'Cast'
	String get cast => 'Cast';

	/// en: 'Director'
	String get director => 'Director';

	/// en: 'Production'
	String get production => 'Production';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'No data'
	String get ratingNoData => 'No data';

	/// en: 'Watch trailer'
	String get seeTrailer => 'Watch trailer';

	/// en: 'Failed to load film details'
	String get failedToLoad => 'Failed to load film details';

	/// en: 'Failed to load poster'
	String get posterError => 'Failed to load poster';
}

// Path: filters
class TranslationsFiltersEn {
	TranslationsFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Filters'
	String get name => 'Filters';

	/// en: 'Genre'
	String get genre => 'Genre';

	/// en: 'Type of session'
	String get typeOfShow => 'Type of session';

	/// en: 'No rating'
	String get noRating => 'No rating';

	/// en: 'Minimal rating'
	String get minimalRating => 'Minimal rating';

	/// en: 'Select all'
	String get selectAll => 'Select all';

	/// en: 'Unselect all'
	String get unselectAll => 'Unselect all';
}

// Path: cinemas
class TranslationsCinemasEn {
	TranslationsCinemasEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cinemas'
	String get name => 'Cinemas';

	/// en: 'Select cinemas'
	String get pickCinemas => 'Select cinemas';

	/// en: 'Saved as favorite'
	String get savedAsFavorite => 'Saved as favorite';

	/// en: 'Failed to load list of cinemas'
	String get failedToLoad => 'Failed to load list of cinemas';
}

// Path: reminders
class TranslationsRemindersEn {
	TranslationsRemindersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reminder - $time'
	String filmReminder({required Object time}) => 'Reminder - ${time}';

	/// en: 'Reminder scheduled'
	String get reminderScheduled => 'Reminder scheduled';

	/// en: 'Select reminder time'
	String get selectReminderTime => 'Select reminder time';
}

// Path: genres
class TranslationsGenresEn {
	TranslationsGenresEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Action'
	String get action => 'Action';

	/// en: 'Adventure'
	String get adventure => 'Adventure';

	/// en: 'Animation'
	String get animation => 'Animation';

	/// en: 'Bollywoood'
	String get bollywood => 'Bollywoood';

	/// en: 'Comedy'
	String get comedy => 'Comedy';

	/// en: 'Crime'
	String get crime => 'Crime';

	/// en: 'Documentary'
	String get documentary => 'Documentary';

	/// en: 'Drama'
	String get drama => 'Drama';

	/// en: 'Family'
	String get family => 'Family';

	/// en: 'Fantasy'
	String get fantasy => 'Fantasy';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Horror'
	String get horror => 'Horror';

	/// en: 'Kids club'
	String get kidsClub => 'Kids club';

	/// en: 'Love'
	String get live => 'Love';

	/// en: 'Musical'
	String get musical => 'Musical';

	/// en: 'Romance'
	String get romance => 'Romance';

	/// en: 'Sci-fi'
	String get sciFi => 'Sci-fi';

	/// en: 'Sport'
	String get sport => 'Sport';

	/// en: 'Thriller'
	String get thriller => 'Thriller';

	/// en: 'War'
	String get war => 'War';

	/// en: 'Western'
	String get western => 'Western';

	/// en: 'Unspecified'
	String get unspecified => 'Unspecified';
}

// Path: languageType
class TranslationsLanguageTypeEn {
	TranslationsLanguageTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PL'
	String get original => 'PL';

	/// en: 'Subtitles'
	String get subtitles => 'Subtitles';

	/// en: 'Dubbing'
	String get dubbing => 'Dubbing';
}

// Path: seatplan
class TranslationsSeatplanEn {
	TranslationsSeatplanEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Available seats'
	String get availableSeats => 'Available seats';

	/// en: 'Ticketing finished'
	String get ticketingFinished => 'Ticketing finished';

	/// en: 'No info about available seats'
	String get failedToLoad => 'No info about available seats';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		return switch (path) {
			'appName' => 'Cinema City Repertoire',
			'appBarTitlePart1' => 'Cinema City',
			'appBarTitlePart2' => 'Repertoire',
			'refresh' => 'Refresh',
			'back' => 'Back',
			'apply' => 'Apply',
			'reset' => 'Reset',
			'confirm' => 'Confirm',
			'save' => 'Save',
			'display' => 'Display',
			'buyTicket' => 'Buy ticket on website',
			'scheduleReminder' => 'Schedule reminder',
			'repertoire.noFilmsToDisplayPickAnotherDate' => 'No films to display. Pick another date or adjust filters.',
			'repertoire.pickDifferentDate' => 'Pick a different date',
			'repertoire.adjustFilters' => 'Adjust filters',
			'repertoire.noFilmsToDisplay' => 'No films to display',
			'repertoire.pickCinemas' => 'Pick cinemas',
			'repertoire.failedToLoad' => 'Failed to load data',
			'filmDetails.premiere' => 'Premiere',
			'filmDetails.filmLength' => 'Film length',
			'filmDetails.filmLengthValue' => ({required Object val}) => '${val} min',
			'filmDetails.filmTitle' => 'Title',
			'filmDetails.filmGenre' => 'Genre',
			'filmDetails.cast' => 'Cast',
			'filmDetails.director' => 'Director',
			'filmDetails.production' => 'Production',
			'filmDetails.rating' => 'Rating',
			'filmDetails.ratingNoData' => 'No data',
			'filmDetails.seeTrailer' => 'Watch trailer',
			'filmDetails.failedToLoad' => 'Failed to load film details',
			'filmDetails.posterError' => 'Failed to load poster',
			'filters.name' => 'Filters',
			'filters.genre' => 'Genre',
			'filters.typeOfShow' => 'Type of session',
			'filters.noRating' => 'No rating',
			'filters.minimalRating' => 'Minimal rating',
			'filters.selectAll' => 'Select all',
			'filters.unselectAll' => 'Unselect all',
			'cinemas.name' => 'Cinemas',
			'cinemas.pickCinemas' => 'Select cinemas',
			'cinemas.savedAsFavorite' => 'Saved as favorite',
			'cinemas.failedToLoad' => 'Failed to load list of cinemas',
			'reminders.filmReminder' => ({required Object time}) => 'Reminder - ${time}',
			'reminders.reminderScheduled' => 'Reminder scheduled',
			'reminders.selectReminderTime' => 'Select reminder time',
			'genres.action' => 'Action',
			'genres.adventure' => 'Adventure',
			'genres.animation' => 'Animation',
			'genres.bollywood' => 'Bollywoood',
			'genres.comedy' => 'Comedy',
			'genres.crime' => 'Crime',
			'genres.documentary' => 'Documentary',
			'genres.drama' => 'Drama',
			'genres.family' => 'Family',
			'genres.fantasy' => 'Fantasy',
			'genres.history' => 'History',
			'genres.horror' => 'Horror',
			'genres.kidsClub' => 'Kids club',
			'genres.live' => 'Love',
			'genres.musical' => 'Musical',
			'genres.romance' => 'Romance',
			'genres.sciFi' => 'Sci-fi',
			'genres.sport' => 'Sport',
			'genres.thriller' => 'Thriller',
			'genres.war' => 'War',
			'genres.western' => 'Western',
			'genres.unspecified' => 'Unspecified',
			'languageType.original' => 'PL',
			'languageType.subtitles' => 'Subtitles',
			'languageType.dubbing' => 'Dubbing',
			'seatplan.availableSeats' => 'Available seats',
			'seatplan.ticketingFinished' => 'Ticketing finished',
			'seatplan.failedToLoad' => 'No info about available seats',
			_ => null,
		};
	}
}

