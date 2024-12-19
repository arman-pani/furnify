import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/address_model.dart';
import 'package:furnify/riverpod/address_notifier.dart';
import 'package:furnify/widgets/add_address_dialog.dart';
import 'package:furnify/widgets/address_card.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:material_symbols_icons/symbols.dart';

class ShippingAddressPage extends ConsumerStatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  ConsumerState<ShippingAddressPage> createState() =>
      _ShippingAddressPageState();
}

class _ShippingAddressPageState extends ConsumerState<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    final List<AddressModel> addressList = ref.watch(addressProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: 'Shipping Address',
        context: context,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Column(
          children: [
            addressList.isNotEmpty
                ? ListView.separated(
                    itemCount: addressList.length,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final AddressModel addressModel = addressList[index];
                      return AddressCard(
                        addressModel: addressModel,
                        isEditable: true,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                  )
                : Container(),
            const SizedBox(height: 25),
            CustomButton(
              icon: Symbols.add_location_rounded,
              label: 'Add new address',
              onPressed: () =>
                  showAddAddressBottomSheet(context: context, ref: ref),
              isBlack: true,
            )
          ],
        ),
      ),
    );
  }
}
