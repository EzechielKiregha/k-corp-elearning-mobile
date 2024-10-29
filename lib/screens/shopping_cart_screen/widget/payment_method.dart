import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  Methods _paymentMethod = Methods.netbanking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<Methods>(value: Methods.netbanking,
        groupValue: _paymentMethod,
        onChanged: (Methods? value){
          setState(() {
            _paymentMethod = value!;
          });
        },
        title: const Text("Net Banking"),
        ),
        RadioListTile<Methods>(value: Methods.cards,
        groupValue: _paymentMethod,
        onChanged: (Methods? value){
          setState(() {
            _paymentMethod = value!;
          });
        },
        title: const Text("Credit/Debut Card"),
        ),
        RadioListTile<Methods>(value: Methods.MTN,
        groupValue: _paymentMethod,
        onChanged: (Methods? value){
          setState(() {
            _paymentMethod = value!;
          });
        },
        title: const Text("MTN Mobile Money"),
        ),
        RadioListTile<Methods>(value: Methods.Airtel,
        groupValue: _paymentMethod,
        onChanged: (Methods? value){
          setState(() {
            _paymentMethod = value!;
          });
        },
        title: const Text("Airtel Money"),
        ),
        RadioListTile<Methods>(value: Methods.Orange,
        groupValue: _paymentMethod,
        onChanged: (Methods? value){
          setState(() {
            _paymentMethod = value!;
          });
        },
        title: const Text("Orange Money"),
        ),
      ],
      
    );
  }
}

enum Methods{
  netbanking,
  cards,
  Airtel,
  Orange,
  MTN
}