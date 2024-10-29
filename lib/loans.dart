
import 'package:flutter/material.dart';
import 'mymoney.dart';
import 'package:provider/provider.dart';
import 'inputs.dart';
import 'resources/app_colors.dart';

class loans extends StatefulWidget {
  const loans({super.key});

  @override
  State<loans> createState() => _loansState();
}

final _myformKey = GlobalKey<FormState>();
TextEditingController loanAmountController = TextEditingController();
TextEditingController interestRateController = TextEditingController();
TextEditingController durationController = TextEditingController();
TextEditingController chargeController = TextEditingController();

class _loansState extends State<loans> {
  String dropdownValue ="GH₵";
  @override
  Widget build(BuildContext context) {
    return Consumer<Mymoney>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Container(
          height: 500,
          decoration: const BoxDecoration(
            color: AppColors.aliceblue,
          ),
          margin: const EdgeInsets.all(5),
          child: Form(
            key: _myformKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                DropdownButtonFormField<String>(
                  padding: const EdgeInsets.all(5.0),
                  value: dropdownValue,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Select Currency',
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                    print("$newValue"); // This line prints the selected value
                  },
                  items: <String>[
                    'GH₵',
                    '\$',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: inputs(
                        input_label: 'Loan Amount',
                        hint_text: 'Enter amount',
                        prefix_icon: Icons.attach_money,
                        controller_name: loanAmountController,
                        input_type: TextInputType.number,
                        onChanged: (val){
                          if(val.isEmpty)
                            {
                              print("empty");
                              double prin=double.parse("0");

                              value.setprin(prin);
                              value.simpleInterest();
                            }
                          else{
                            double prin=double.parse(val);

                            value.setprin(prin);
                            value.simpleInterest();
                          }

                        },
                      ),
                    ),
                    const SizedBox(width: 10), // Add some space between the columns
                    Expanded(
                      child: inputs(
                        onChanged: (val){
                          if(val.isEmpty)
                          {
                            print("empty rate");
                            double rate=double.parse("0.00");

                            value.setrate(rate);
                            value.simpleInterest();
                          }else
                            {
                              double rate=double.parse(val);
                              value.setrate(rate);
                              value.simpleInterest();
                            }


                        },
                        input_label: 'Interest Rate %',
                        hint_text: 'Enter interest rate',
                        prefix_icon: Icons.star,
                        controller_name: interestRateController,
                        input_type: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Add some vertical space between rows
                Row(
                  children: <Widget>[
                    Expanded(
                      child: inputs(
                        input_label: 'Period',
                        hint_text: 'Enter period',
                        prefix_icon: Icons.access_time,
                        controller_name: durationController,
                        input_type: TextInputType.number,
                        onChanged: (Mymoney) {
                          double principalAmount = double.tryParse(loanAmountController.text) ?? 0.0;
                          double interestRate = double.tryParse(interestRateController.text) ?? 0.0;
                          double loanCharge = double.tryParse(chargeController.text) ?? 0.0;
                          int numberMonths = int.tryParse(durationController.text) ?? 0;

                          // Update the values in mymoney
                          value.principalAmount = principalAmount;
                          value.interestRate = interestRate;
                          value.numberMonths = numberMonths;
                          value.mycurrency = dropdownValue;
                          if(numberMonths.isNaN)
                            {
                              numberMonths=0;
                              return;
                            }
                          value.setmonth(numberMonths);
                          value.simpleInterest();

                          if (_myformKey.currentState!.validate()) {
                            // If the form is valid, convert controller to proper datatypes


                            //_myformKey.currentState!.reset();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10), // Add some space between the columns
                    Expanded(
                      child: TextFormField(
                        decoration:const InputDecoration(
                          hintText: "Enter Charge",
                          labelText: "charge %",
                          prefixIcon: Icon(Icons.payment,color: AppColors.menutabs),
                          border: OutlineInputBorder(

                          )
                        ),
                        controller: chargeController,
                        keyboardType: TextInputType.number,
                        onChanged: (val){
                          if(val.isEmpty)
                          {
                            print("no charge");
                            double charge=double.parse("0.00");

                            value.setcharge(charge);
                            value.simpleInterest();
                          }else
                          {
                            double charge=double.parse(val);
                            value.setcharge(charge);
                            value.simpleInterest();
                          }


                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.contentColorGreen,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        "Your monthly installment is $dropdownValue${value.monthlyPayment} \n "
                        "You will pay a total amount of $dropdownValue${value.amountTopay}\n"
                        " for ${value.numberMonths} months at a charge of $dropdownValue${value.loanCharge}\n"),
                  ),
                ),
                Text(value.balanceNotice,style: const TextStyle(color: Colors.red,),textAlign: TextAlign.center,),

                SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.contentColorYellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      label: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () async{
                        if (_myformKey.currentState!.validate()) {
                        bool result=  await value.addLoanToFirestore(
                            value.principalAmount,value.interestRates,value.numberMonths,value.mycurrency
                        );
                        if(result){
                          // Clear the input fields
                          _myformKey.currentState!.reset();
                          loanAmountController.clear();
                          interestRateController.clear();
                          durationController.clear();
                          chargeController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Successful"),backgroundColor: Colors.green,),);

                        }else{
                          print("failed to add loan");
                        }

                        }

                      },
                    )),

              ],
            ),
          ),
        ),
      );
    });
  }
}
