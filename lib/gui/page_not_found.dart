import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("No se encontro la pagina"),
          InkWell(
            onTap: () => Get.offAllNamed("/"),
            child: const Text(
              'Ir a página principal',
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
