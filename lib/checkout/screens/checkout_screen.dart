import 'package:crafty_bay/checkout/controllers/create_invoice_controller.dart';
import 'package:crafty_bay/checkout/screens/payment_web_view_screen.dart';
import 'package:crafty_bay/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CreateInvoiceController>().createInvoice();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CreateInvoiceController>(builder: (invoice) {
          return Visibility(
            visible: !invoice.inProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total: "),
                    Text(
                        "৳${invoice.paymentGatewayList?.paymentList?.first.total ?? 0}"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("VAT: "),
                    Text(
                        "(+) ৳${invoice.paymentGatewayList?.paymentList?.first.vat ?? 0}"),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payable: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "৳${invoice.paymentGatewayList?.paymentList?.first.payable ?? 0}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Click on payment method below to make payment",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: invoice.paymentGatewayList?.paymentList?.first
                            .paymentMethodList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      var item = invoice.paymentGatewayList?.paymentList?.first
                          .paymentMethodList![index];
                      return ListTile(
                        onTap: () {
                          Get.toNamed(PaymentWebViewScreen.routeName,
                              arguments: item!.redirectGatewayURL!);
                        },
                        leading: Image.network(item?.logo ?? ''),
                        title: Text(item?.name?.toUpperCase() ?? ''),
                        subtitle: Text(item?.type?.toUpperCase() ?? ''),
                        trailing: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
