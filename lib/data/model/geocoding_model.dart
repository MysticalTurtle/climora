class GeocodingLocationModel {
  const GeocodingLocationModel({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  factory GeocodingLocationModel.fromMap(Map<String, dynamic> json) =>
      GeocodingLocationModel(
        name: json['name'] as String? ?? '',
        localNames: LocalNamesModel.fromMap(
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

  GeocodingLocationModel copyWith({
    String? name,
    LocalNamesModel? localNames,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) => GeocodingLocationModel(
    name: name ?? this.name,
    localNames: localNames ?? this.localNames,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    country: country ?? this.country,
    state: state ?? this.state,
  );

  final String name;
  final LocalNamesModel localNames;
  final double lat;
  final double lon;
  final String country;
  final String? state;
}

class LocalNamesModel {
  const LocalNamesModel({
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

  factory LocalNamesModel.fromMap(Map<String, dynamic> json) => LocalNamesModel(
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

  LocalNamesModel copyWith({
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
  }) => LocalNamesModel(
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

  final String? ja;
  final String? pt;
  final String? zh;
  final String? eo;
  final String? fr;
  final String? es;
  final String? ko;
  final String? be;
  final String? pl;
  final String? ru;
  final String? ar;
  final String? en;
  final String? nl;
  final String? it;
  final String? uk;
  final String? de;
}

typedef GeocodingResultList = List<GeocodingLocationModel>;

extension GeocodingResultListFromJson on GeocodingResultList {
  static GeocodingResultList fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) =>
              GeocodingLocationModel.fromMap(json as Map<String, dynamic>),
        )
        .toList();
  }
}
