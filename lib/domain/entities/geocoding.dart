class GeocodingLocation {
  const GeocodingLocation({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  factory GeocodingLocation.fromMap(Map<String, dynamic> json) =>
      GeocodingLocation(
        name: json['name'] as String? ?? '',
        localNames: LocalNames.fromMap(
          json['local_names'] as Map<String, dynamic>? ?? {},
        ),
        lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
        lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
        country: json['country'] as String? ?? '',
        state: json['state'] as String?,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'local_names': localNames.toMap(),
      'lat': lat,
      'lon': lon,
      'country': country,
    };
    if (state != null) {
      map['state'] = state;
    }
    return map;
  }

  GeocodingLocation copyWith({
    String? name,
    LocalNames? localNames,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) => GeocodingLocation(
    name: name ?? this.name,
    localNames: localNames ?? this.localNames,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    country: country ?? this.country,
    state: state ?? this.state,
  );

  final String name;
  final LocalNames localNames;
  final double lat;
  final double lon;
  final String country;
  final String? state;
}

class LocalNames {
  const LocalNames({
    this.ja,
    this.pt,
    this.zh,
    this.eo,
    this.fr,
    this.es,
    this.ko,
    this.be,
    this.pl,
    this.ru,
    this.ar,
    this.en,
    this.nl,
    this.it,
    this.uk,
    this.de,
  });

  factory LocalNames.fromMap(Map<String, dynamic> json) => LocalNames(
    ja: json['ja'] as String?,
    pt: json['pt'] as String?,
    zh: json['zh'] as String?,
    eo: json['eo'] as String?,
    fr: json['fr'] as String?,
    es: json['es'] as String?,
    ko: json['ko'] as String?,
    be: json['be'] as String?,
    pl: json['pl'] as String?,
    ru: json['ru'] as String?,
    ar: json['ar'] as String?,
    en: json['en'] as String?,
    nl: json['nl'] as String?,
    it: json['it'] as String?,
    uk: json['uk'] as String?,
    de: json['de'] as String?,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (ja != null) map['ja'] = ja;
    if (pt != null) map['pt'] = pt;
    if (zh != null) map['zh'] = zh;
    if (eo != null) map['eo'] = eo;
    if (fr != null) map['fr'] = fr;
    if (es != null) map['es'] = es;
    if (ko != null) map['ko'] = ko;
    if (be != null) map['be'] = be;
    if (pl != null) map['pl'] = pl;
    if (ru != null) map['ru'] = ru;
    if (ar != null) map['ar'] = ar;
    if (en != null) map['en'] = en;
    if (nl != null) map['nl'] = nl;
    if (it != null) map['it'] = it;
    if (uk != null) map['uk'] = uk;
    if (de != null) map['de'] = de;
    return map;
  }

  LocalNames copyWith({
    String? ja,
    String? pt,
    String? zh,
    String? eo,
    String? fr,
    String? es,
    String? ko,
    String? be,
    String? pl,
    String? ru,
    String? ar,
    String? en,
    String? nl,
    String? it,
    String? uk,
    String? de,
  }) => LocalNames(
    ja: ja ?? this.ja,
    pt: pt ?? this.pt,
    zh: zh ?? this.zh,
    eo: eo ?? this.eo,
    fr: fr ?? this.fr,
    es: es ?? this.es,
    ko: ko ?? this.ko,
    be: be ?? this.be,
    pl: pl ?? this.pl,
    ru: ru ?? this.ru,
    ar: ar ?? this.ar,
    en: en ?? this.en,
    nl: nl ?? this.nl,
    it: it ?? this.it,
    uk: uk ?? this.uk,
    de: de ?? this.de,
  );

  final String? ja; // Japanese
  final String? pt; // Portuguese
  final String? zh; // Chinese
  final String? eo; // Esperanto
  final String? fr; // French
  final String? es; // Spanish
  final String? ko; // Korean
  final String? be; // Belarusian
  final String? pl; // Polish
  final String? ru; // Russian
  final String? ar; // Arabic
  final String? en; // English
  final String? nl; // Dutch
  final String? it; // Italian
  final String? uk; // Ukrainian
  final String? de; // German
}
