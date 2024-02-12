import 'package:json_annotation/json_annotation.dart';

part 'tax_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class TaxInfo {
  bool? usPerson;
  String? usTaxId;
  TaxResidence? primaryTaxResidence;
  List<TaxResidence> secondaryTaxResidence;

  TaxInfo({
    required this.usPerson,
    this.usTaxId,
    this.primaryTaxResidence,
    required this.secondaryTaxResidence,
  });

  factory TaxInfo.fromJson(Map<String, dynamic> json) =>
      _$TaxInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TaxInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class TaxResidence {
  String country;
  String id;

  TaxResidence({
    required this.country,
    required this.id,
  });

  factory TaxResidence.fromJson(Map<String, dynamic> json) =>
      _$TaxResidenceFromJson(json);

  Map<String, dynamic> toJson() => _$TaxResidenceToJson(this);
}
