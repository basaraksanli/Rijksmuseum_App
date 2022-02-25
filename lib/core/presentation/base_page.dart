import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BasePage extends StatefulWidget{
  const BasePage({Key? key}): super(key: key);

  @override
  BasePageState createState() => BasePageState();
}
class BasePageState<T extends BasePage> extends State<T>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  showToastMessage(String message){
    EasyLoading.showToast(message);
  }
  showErrorMessage(String message){
    EasyLoading.showError(message);
  }
}