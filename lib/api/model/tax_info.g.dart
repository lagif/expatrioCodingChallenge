// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxInfo _$TaxInfoFromJson(Map<String, dynamic> json) => TaxInfo(
      usPerson: json['usPerson'] as bool,
      usTaxId: json['usTaxId'] as String?,
      primaryTaxResidence: json['primaryTaxResidence'] == null
          ? null
          : TaxResidence.fromJson(
              json['primaryTaxResidence'] as Map<String, dynamic>),
      secondaryTaxResidence: (json['secondaryTaxResidence'] as List<dynamic>)
          .map((e) => TaxResidence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaxInfoToJson(TaxInfo instance) => <String, dynamic>{
      'usPerson': instance.usPerson,
      'usTaxId': instance.usTaxId,
      'primaryTaxResidence': instance.primaryTaxResidence?.toJson(),
      'secondaryTaxResidence':
          instance.secondaryTaxResidence.map((e) => e.toJson()).toList(),
    };

TaxResidence _$TaxResidenceFromJson(Map<String, dynamic> json) => TaxResidence(
      country: json['country'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$TaxResidenceToJson(TaxResidence instance) =>
    <String, dynamic>{
      'country': instance.country,
      'id': instance.id,
    };
