import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Mymoney extends ChangeNotifier {
  late int income = 0;
  late int expense = 0;
  late int balance = 0;
  late double principalAmount = 0;
  late double interestRates = 0;
  late double interestRate = 0;
  late int numberMonths = 0;
  late double loanCharge = 0;
  late double monthlyPayment = 0;
  late double amountTopay = 0;
  String actvity = "";
  String mycurrency = "";
  Color ActiveKolor = Colors.black26;
  late double calculatedInterest = 0;
  double my_principal = 0;
  int my_month = 0;
  double my_rate = 0;
  double my_charge = 0;
  String username = "";
  String email = "";
  int contact = 0;
  String businessname = "";
  String businesslocation = "";
  String password = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String balanceNotice = "";

  List<Map<String, dynamic>> _loansList = [];

  List<Map<String, dynamic>> get loansList => _loansList;

  // Method to fetch loan data from Firestore
  Future<void> fetchLoans() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('loans').get();
      _loansList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      notifyListeners(); // Notify the listeners after fetching data
    } catch (e) {
      print("Error fetching loans: $e");
    }
  }

//function to add loan transactions to db document
  Future<bool> addLoanToFirestore(
    double principalAmount,
    double interestRates,
    int numberMonths,
    String mycurrency,
  ) async {
    //reference to db
    CollectionReference loans = firestore.collection("loans");
    // Create a document with the controller values
    try {
      await loans.add({
        'loanAmount': principalAmount,
        'rate': interestRates,
        'period': numberMonths,
        'created_at': Timestamp.now(),
        'monthlypay': monthlyPayment,
        'totalpayment': amountTopay,
        'currency': mycurrency,
      });
      print("loan data added");
      return true; // Return true on success
    } catch (e) {
      print("error adding data:$e");
      return false; // Return false on failure
    }
  }

//function to add users to db
  Future<bool> addUsers(String username, String email, String contact,
      String businessname, String businessloaction, String password) async {
    CollectionReference uzers = firestore.collection("users");
    try {
      await uzers.doc(contact).set({
        'username': username,
        'email': email,
        'contact': contact,
        'businessname': businessname,
        'businesslocation': businessloaction,
        'password': password,
        'created': Timestamp.now(),
      });
      print("records added successfuly");
      return true;
    } catch (e) {
      print("error adding user $e");
      return false;
    }
  }

  setprin(double prin) {
    my_principal = prin;
    notifyListeners();
  }

  setmonth(int month) {
    my_month = month;
    notifyListeners();
  }

  setrate(double rate) {
    my_rate = rate;
    notifyListeners();
  }

  setcharge(double charge) {
    my_charge = charge;
    notifyListeners();
  }

  showActivity(String activityName, Color mycolor) {
    actvity = activityName;
    ActiveKolor = mycolor;
    notifyListeners();
  }

  incomeDeposit(int incomeDep) {
    income = incomeDep;
    calculateBalance();
    notifyListeners();
  }

  expenseDeposit(int expenseDep) {
    expense = expenseDep;
    calculateBalance();
    notifyListeners();
  }

  calculateBalance() {
    balance = income - expense;
  }

  simpleInterest() {
    try {
      interestRates = my_rate;
      numberMonths = my_month;
      numberMonths = my_month;
      principalAmount = my_principal;
      double rateFraction = my_rate / 100;
      double ChargeRate = my_charge / 100;
      //calc. interest
      interestRate = principalAmount * rateFraction * numberMonths;
      //calc loancharges
      loanCharge = ChargeRate * principalAmount;
      //calc amountopay
      amountTopay = (interestRate + principalAmount);
      amountTopay = double.parse(amountTopay.toStringAsFixed(2));
      // Check for zero or invalid numberMonths
      if (numberMonths > 0 && amountTopay.isFinite) {
        monthlyPayment = amountTopay / numberMonths;
        monthlyPayment = double.parse(monthlyPayment.toStringAsFixed(2));
      } else {
        // Handle the error
        monthlyPayment = 0.0;
      }
      //balance notification
      if (balance < monthlyPayment) {
        balanceNotice = "Warning: Your loan payment each month is more than your income. Please check your numbers or look at other loan choices.";
      } else {
        balanceNotice = "";
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // double get monthlyInstallment => monthlyPayment;
  //
  // double get amtTopay => amountTopay;
  //
  // get getInterestRate {
  //   interestRate;
  // }

  int get SavingsBalance {
    return balance;
  }
}
