import 'package:flutter/cupertino.dart';

class ErrorImageWidget extends StatelessWidget{
  const ErrorImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/images/no_image_available.jpg'),);
  }

}