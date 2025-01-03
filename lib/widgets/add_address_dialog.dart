import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/address_model.dart';
import 'package:furnify/riverpod/address_notifier.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';

void showAddAddressBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  AddressModel? oldAddress,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      final TextEditingController tagController = TextEditingController();
      final TextEditingController address1Controller = TextEditingController();
      final TextEditingController address2Controller = TextEditingController();
      final TextEditingController pincodeController = TextEditingController();
      final TextEditingController countryController = TextEditingController();
      final TextEditingController stateController = TextEditingController();
      final TextEditingController districtController = TextEditingController();

      if (oldAddress != null) {
        tagController.text = oldAddress.tag;
        address1Controller.text = oldAddress.address1;
        address2Controller.text = oldAddress.address2 ?? "";
        pincodeController.text = oldAddress.pincode.toString();
        countryController.text = oldAddress.country;
        stateController.text = oldAddress.state;
        districtController.text = oldAddress.district;
      }

      bool areFieldsValid() {
        return tagController.text.trim().isNotEmpty &&
            address1Controller.text.trim().isNotEmpty &&
            pincodeController.text.trim().isNotEmpty &&
            countryController.text.trim().isNotEmpty &&
            stateController.text.trim().isNotEmpty &&
            districtController.text.trim().isNotEmpty;
      }

      void showError(String message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }

      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Symbols.add_location_rounded,
                    size: 30,
                    weight: 600,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Add New Address',
                    style: TextStyleConstants.titleRegular,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: tagController,
                hintText: 'Tag',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: address1Controller,
                hintText: 'Address Line 1',
                maxInputLimit: 40,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: address2Controller,
                hintText: 'Address Line 2',
                maxInputLimit: 40,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: pincodeController,
                hintText: 'Pincode',
                maxInputLimit: 6,
                onlyDigits: true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: countryController,
                hintText: 'Country',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: stateController,
                hintText: 'State',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: districtController,
                hintText: 'District',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyleConstants.smallText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (!areFieldsValid()) {
                        showError("Please fill in all the fields.");
                        return;
                      }

                      final AddressModel newAddress = AddressModel(
                        id: oldAddress != null
                            ? oldAddress.id
                            : const Uuid().v4(),
                        tag: tagController.text.trim(),
                        address1: address1Controller.text.trim(),
                        address2: address2Controller.text.trim(),
                        isDefault:
                            oldAddress != null ? oldAddress.isDefault : false,
                        pincode:
                            int.tryParse(pincodeController.text.trim()) ?? 0,
                        country: countryController.text.trim(),
                        state: stateController.text.trim(),
                        district: districtController.text.trim(),
                      );

                      if (oldAddress != null) {
                        ref
                            .read(addressProvider.notifier)
                            .updateAddress(newAddress);
                      } else {
                        ref
                            .read(addressProvider.notifier)
                            .addNewAddress(newAddress);
                      }

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            oldAddress != null
                                ? 'Address Updated Successfully!!'
                                : 'Address Added Successfully!!',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      oldAddress != null ? 'Update' : 'Add',
                      style: TextStyleConstants.smallText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
