import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/address_model.dart';
import 'package:furnify/sqlflite/local_database_helper.dart';

class AddressNotifier extends StateNotifier<List<AddressModel>> {
  final LocalDatabaseHelper db;

  AddressNotifier(this.db) : super([]) {
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final addresses = await db.getAddressesFromLocalDB();
    state = addresses;
  }

  Future<void> addNewAddress(AddressModel address) async {
    await db.addAddressToLocalDB(address: address);
    state = [...state, address];
  }

  Future<void> updateAddress(AddressModel newAddress) async {
    await db.updateAddressInLocalDB(address: newAddress);

    state = state.map((address) {
      return address.id == newAddress.id ? newAddress : address;
    }).toList();
  }

  Future<AddressModel?> getDefaultAddress() async {
    final defaultAddress = await db.getDefaultAddress();
    return defaultAddress;
  }

  Future<void> setDefaultAddress(String addressId) async {
    await db.setDefaultAddress(addressId);
    await _loadAddresses();
  }
}

final addressProvider =
    StateNotifierProvider<AddressNotifier, List<AddressModel>>(
  (ref) => AddressNotifier(LocalDatabaseHelper()),
);
