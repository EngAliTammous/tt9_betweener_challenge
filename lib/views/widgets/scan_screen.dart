import 'package:flutter/material.dart';



class ScanView extends StatelessWidget {
  static String id = '/scan_screen';
  const ScanView({super.key});




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const Spacer(flex: 3,),
        const  Text('Scan Your QR Code',style: TextStyle(fontSize: 30.0 , color: Colors.white,fontWeight: FontWeight.bold),),
         const Spacer(),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Image.asset('assets/imgs/qr-code-512.png',height: 500,width: 500,),
          ),
          const Spacer(flex: 3,),

        ],
      ),
    );
  }
}
