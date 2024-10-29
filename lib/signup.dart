import 'package:flutter/material.dart';
import 'mymoney.dart';
import 'inputs.dart';
import 'resources/app_colors.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _fkeys = GlobalKey<FormState>();
  // This variable will track the loading state
  bool _isLoading = false;
  TextEditingController user_name = TextEditingController();
  TextEditingController e_mail = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController business_name = TextEditingController();
  TextEditingController business_location = TextEditingController();
  TextEditingController pass_word = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    return Consumer<Mymoney>(builder: (context,value,child){
      return Scaffold(
        backgroundColor: AppColors.pearl,
        body: SingleChildScrollView(
          child: Container(
            height: deviceheight*0.758,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            child: Form(
              key: _fkeys,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: const Text(
                          "Join our mailing list.",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    inputs(

                      input_label: 'Full Name',
                      hint_text: 'Enter Full Name',
                      prefix_icon: Icons.person,
                      controller_name: user_name,
                      input_type: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: e_mail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                            label: Text("Email"),
                            hintText:"Enter valid email",
                            prefixIcon: Icon(Icons.email,color: AppColors.menutabs,)
                        ),
                      ),
                    ),
                    inputs(
                      input_label: 'Contact',
                      hint_text: 'Enter Valid Contact',
                      prefix_icon: Icons.phone,
                      controller_name: contact,
                      input_type: TextInputType.phone,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: business_name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Business Name"),
                          hintText:"Business Name",
                          prefixIcon: Icon(Icons.location_city,color: AppColors.menutabs,)
                        ),
                      ),
                    ),
                    inputs(
                      input_label: 'Business Type',
                      hint_text: 'Describe business type',
                      prefix_icon: Icons.shopping_bag,
                      controller_name: pass_word,
                      input_type: TextInputType.text,
                    ),
                    inputs(
                      input_label: 'Business location',
                      hint_text: 'Business location',
                      prefix_icon: Icons.location_on,
                      controller_name: business_location,
                      input_type: TextInputType.text,
                    ),
                    SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.contentColorYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          label: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            "Subscribe",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          onPressed: _isLoading ? null : () async{
                            if (_fkeys.currentState!.validate()) {
                              setState(() {
                                _isLoading=true;
                              });
                              String username = user_name.text;
                              String email=e_mail.text;
                              String phone=contact.text;
                              String pass=pass_word.text;
                              String busName=business_name.text;
                              String buslocation =business_location.text;
                              bool result= await value.addUsers(
                                  username,email,phone,busName,buslocation,pass
                              );
                              if(result)
                              {
                                _fkeys.currentState!.reset();
                                user_name.clear();
                                e_mail.clear();
                                contact.clear();
                                pass_word.clear();
                                business_name.clear();
                                business_location.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Successful"),
                                    backgroundColor: Colors.green,
                                  )
                                );
                              }else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error saving")));
                              }
                              setState(() {
                                _isLoading=false;
                              });

                            }
                          },
                        )),
                  ]),
            ),
          ),
        ),
      );

    },);
  }
}

