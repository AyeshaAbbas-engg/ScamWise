class ScamAlertModel {
  final String regionEn;
  final String regionUr;
  final String scamEn;
  final String scamUr;
  final String awareEn;
  final String awareUr;

  ScamAlertModel({
    required this.regionEn,
    required this.regionUr,
    required this.scamEn,
    required this.scamUr,
    required this.awareEn,
    required this.awareUr,
  });

  factory ScamAlertModel.fromJson(Map<String, dynamic> json) {
    return ScamAlertModel(
      regionEn: json['region_en'] ?? '',
      regionUr: json['region_ur'] ?? '',
      scamEn: json['scam_en'] ?? '',
      scamUr: json['scam_ur'] ?? '',
      awareEn: json['awareness_en'] ?? '',
      awareUr: json['awareness_ur'] ?? '',
    );
  }
}
