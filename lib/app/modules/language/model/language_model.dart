class  CommonLanguageCalenderModel{
  int? id;
  String? title;


  CommonLanguageCalenderModel({this.id,this.title});
}

class LoginTypeModel{
  String? title;
  String? asset;
  bool isSelect=false;


  LoginTypeModel(this.title, this.asset, {this.isSelect = false});


}


class ButtonTypeModel{
  String? title;
  String? asset;
  bool isSelect=false;


  ButtonTypeModel(this.title, this.asset, {this.isSelect = false});



}