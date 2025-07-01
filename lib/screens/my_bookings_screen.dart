import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class MyQRcodeScreen extends StatelessWidget {
  const MyQRcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppStyle.maincolor, width: 1),
            ),
            child: QrImageView(
              data: BlocProvider.of<UserCubit>(context, listen: false).user.id,
              version: QrVersions.auto,
              size: 250.0,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: Text(
              'Scan this QR code to before throwing the trash',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppStyle.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QRCodeExample extends StatelessWidget {
  const QRCodeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Generator")),
      body: Center(
        child: QrImageView(
          data: "https://example.com",
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
