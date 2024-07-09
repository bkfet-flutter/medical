import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/button_arrow_back.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodePayCounter extends StatefulWidget {
  const QrCodePayCounter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodePayCounterState();
}

class _QrCodePayCounterState extends State<QrCodePayCounter> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              _buildQrView(context),
              result == null
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: const ButtonArrowBack()),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          await controller?.toggleFlash();
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                          AppImages.iconFlashSlash,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Quét mã sản phẩm",
                            style: AppFonts.bold(
                              28,
                              Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            "Vui lòng hướng máy ảnh vào BarCode",
                            style: AppFonts.light(
                              14,
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "BarCode",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${result!.code}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
            ],
          )),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimens.spaceMediumLarge,
              ),
              child: MepharButton(
                titleButton: "Xem đơn",
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
