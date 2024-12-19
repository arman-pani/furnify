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
      if (address.id == newAddress.id) {
        return newAddress;
      }
      return address;
    }).toList();
  }

  AddressModel? getDefaultAddress() {
    return state.firstWhere(
      (address) => address.isDefault,
      orElse: () => null,
    );
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

final defaultAddressProvider = Provider<AddressModel?>((ref) {
  final addressList = ref.watch(addressProvider);
  return addressList.firstWhere(
    (address) =>
        address.isDefault, // Assume `isDefault` indicates the default address
    orElse: () => null,
  );
});
