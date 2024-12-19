import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/address_model.dart';
import 'package:furnify/riverpod/address_notifier.dart';
import 'package:furnify/widgets/add_address_dialog.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddressCard extends ConsumerWidget {
  final AddressModel addressModel;
  final bool isEditable;
  const AddressCard({
    super.key,
    required this.addressModel,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color textColor =
        addressModel.isDefault ? Colors.white : Colors.black;
    final Color containerColor =
        addressModel.isDefault ? Colors.black : ColorConstants.primaryColor;
    return GestureDetector(
      onTap: () {
        ref.read(addressProvider.notifier).setDefaultAddress(addressModel.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        decoration: ThemeConstants.greyBoxDecoration.copyWith(
          color: containerColor,
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Symbols.location_city_rounded,
                size: 50,
                color: Colors.black,
                weight: 600,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addressModel.tag,
                        style: TextStyleConstants.titleRegular
                            .copyWith(color: textColor),
                      ),
                      isEditable
                          ? GestureDetector(
                              onTap: () => showAddAddressBottomSheet(
                                context: context,
                                ref: ref,
                                oldAddress: addressModel,
                              ),
                              child: Icon(
                                Symbols.edit_rounded,
                                size: 25,
                                weight: 600,
                                color: textColor,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${addressModel.address1}\n${addressModel.address2}",
                    style: TextStyleConstants.addressCardSubTitle
                        .copyWith(color: textColor),
                    softWrap: true,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
