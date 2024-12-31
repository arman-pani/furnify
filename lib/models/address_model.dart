import 'package:uuid/uuid.dart';

class AddressModel {
  final String id;
  final bool isDefault;
  final String tag;
  final String address1;
  final String? address2;
  final int pincode;
  final String country;
  final String state;
  final String district;

  AddressModel({
    String? id,
    required this.isDefault,
    required this.tag,
    required this.address1,
    this.address2,
    required this.pincode,
    required this.country,
    required this.state,
    required this.district,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isDefault': isDefault ? 1 : 0,
      'tag': tag,
      'address1': address1,
      'address2': address2,
      'pincode': pincode,
      'country': country,
      'state': state,
      'district': district,
    };
  }

  Map<String, dynamic> toMapForOrdersCollection() {
    return {
      'address1': address1,
      'address2': address2 ?? "",
      'pincode': pincode,
      'country': country,
      'state': state,
      'district': district,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      isDefault: map['isDefault'] == 1,
      tag: map['tag'] as String,
      address1: map['address1'] as String,
      address2: map['address2'] as String?,
      pincode: map['pincode'] as int,
      country: map['country'] as String,
      state: map['state'] as String,
      district: map['district'] as String,
    );
  }
}
