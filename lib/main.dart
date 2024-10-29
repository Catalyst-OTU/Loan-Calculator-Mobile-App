import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'menutabs.dart';
import 'mymoney.dart';
import 'signup.dart';
import 'package:provider/provider.dart';
import 'resources/app_colors.dart';
import 'incomeiconz.dart';
import 'loans.dart';
import 'myquotes.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

void main() async {
  // Ensure Flutter engine is fully initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and handle potential errors
  await _initializeFirebase();

  // Run app with ChangeNotifierProvider
  runApp(ChangeNotifierProvider(
    create: (context) => Mymoney(),
    child: const MyApp(),
  ));
}

//  Firebase initialization here
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Firebase initialization successful
  } catch (e) {
    // Handle initialization error
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SikaMate',
      theme: ThemeData(
        // This is the theme of your application.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),

        useMaterial3: true,
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splash,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final String videoUrl = "https://www.menayefinanceinitiative.com/menaye-toolkit";
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showModalBottomSheet(BuildContext context, Widget SheetPage) {
    double deviceheight = MediaQuery.of(context).size.height;
    showModalBottomSheet<void>(
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.4,
              maxChildSize: 1.0,
              expand: false,
              snap: false,
              builder: (BuildContext, ScrollController scrollController) {
                return Stack(
                  children: [
                    //main content with scrolling here
                    ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(10.0),
                      children: [
                        Container(
                          color: AppColors.customWhiteColors,
                          padding: const EdgeInsets.all(10.0),
                          height: deviceheight * 0.59,
                          child: SheetPage,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Closes the modal
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> launchUrl(String urlString) async {
      final String url = urlString; // Pass the String directly
      try {
        await launchUrl(url); // Call the function, no need to check return value
      } catch (e) {
        throw 'Could not launch $url: $e'; // Handle error if launching fails
      }
    }

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceheight = MediaQuery.of(context).size.height;
    List<String> appBarTitles = ["SikaMate", "Subscribe", "LearnHub"];
    return Consumer<Mymoney>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: AppColors.offwhite,
          appBar: AppBar(
            backgroundColor: AppColors.contentColorYellow,
            title: Text(
              appBarTitles[_selectedIndex],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: AppColors.textColor,
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
            ),
            child: NavigationBar(
              backgroundColor: AppColors.contentColorYellow,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.textColor,
                    size: 30,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.textColor,
                    size: 30,
                  ),
                  label: 'Subscribe',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.thumb_up_sharp,
                    color: AppColors.textColor,
                    size: 30,
                  ),
                  label: 'LearnHub',
                ),
              ],
            ),
          ),
          body: <Widget>[
            Container(
              height: deviceheight * 0.69,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: <Widget>[
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                    color: AppColors.textColor,
                    elevation: 3,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: deviceWidth * 0.9,
                      height: deviceheight * 0.23,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          const Text(
                            "Balance",
                            style: TextStyle(
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "₵${value.SavingsBalance}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Divider(
                            thickness: 1.0,
                            color: Colors.black,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Income",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "₵${value.income}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.green),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 1,
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Expense",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      "₵${value.expense}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.amber[800]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceheight * 0.25,
                  ),
                  menutabs(
                      iconz: Icons.savings,
                      menutext: "SikaTracker",
                      bottm_sheet: () =>
                          _showModalBottomSheet(context, const SavingSheet())),
                  menutabs(
                    iconz: Icons.attach_money,
                    menutext: "LoanMate",
                    bottm_sheet: () =>
                        _showModalBottomSheet(context, const LoanPage()),
                  ),
                  menutabs(
                    iconz: Icons.bar_chart,
                    menutext: "Graph",
                    bottm_sheet: () => _showModalBottomSheet(
                        context,
                        IncomeExpenseChart(
                          income: value.income,
                          expense: value.expense,
                        )),
                  ),
                  menutabs(
                    iconz: Icons.history,
                    menutext: "History",
                    bottm_sheet: () =>
                        _showModalBottomSheet(context, const LoanHistory()),
                  ),
       SizedBox(width: deviceWidth*0.9,height: deviceheight*0.05,),
        SizedBox(width: deviceWidth*0.15,),
      SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed:() async {

          await  launchUrl(videoUrl);

        },
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.menutabs,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10))),
          label: const Text(
      "Menaye Toolkit",
      style: TextStyle(color: Colors.white, fontSize: 25),
      ),
        // Launch the video URL

      )),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0), // Adjust the value as needed
                      child: Text(
                        "Menaye Finance Initiative",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dustyRose,
                        ),
                      ),
                    ),
                  )


                ],
              ),
            ),
            const SignUpScreen(),
            const quotesPage()
          ][_selectedIndex]);
    });
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUp();
  }
}

class SavingSheet extends StatefulWidget {
  const SavingSheet({super.key});

  @override
  State<SavingSheet> createState() => _SavingSheetState();
}

class _SavingSheetState extends State<SavingSheet> {
  String dropdownValue = "Weekly";
  String dropdownValue1 = "Activity";
  bool isVisible = false;
  bool exVisible = false;
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    return Consumer<Mymoney>(builder: (context, value, child) {
      return Container(
        height: deviceheight * 0.15,
        color: Colors.white38,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: 350,
              height: deviceheight * 0.18,
              decoration: BoxDecoration(
                color: value.ActiveKolor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.actvity,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter amount",
                      hintStyle: TextStyle(
                        color: Colors.black,fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              height: 450,
              child: Column(children: [
                DropdownButtonFormField<String>(
                  padding: const EdgeInsets.all(5.0),
                  value: dropdownValue,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Select Period',
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
                    'Weekly',
                    'Monthly',
                    'Annually',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  padding: const EdgeInsets.all(5),
                  value: dropdownValue1,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Select Activity',
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue1) {
                    dropdownValue1 = newValue1!;

                    setState(() {
                      if (dropdownValue1 == 'expense') {
                        isVisible = false;
                        exVisible = true;
                        value.actvity = dropdownValue1;
                        value.ActiveKolor = AppColors.coconut;
                      } else if (dropdownValue1 == 'income') {
                        exVisible = false;
                        isVisible = true;
                        value.actvity = dropdownValue1;
                        value.ActiveKolor = AppColors.contentColorGreen;
                      } else {
                        exVisible = false;
                        isVisible = false;
                        value.actvity = "Select activity";
                        value.ActiveKolor = AppColors.aliceblue;
                      }
                    });
                  },
                  items: <String>[
                    'Activity',
                    'income',
                    'expense',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isVisible,
                  child: Wrap(children: buildIncomeIcons()),
                ),
                Visibility(
                  visible: exVisible,
                  child: Wrap(children: buildExpenseIcons()),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.contentColorYellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      label: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        String selectedPeriod = dropdownValue;
                        String selectedActivity = dropdownValue1;
                        String enteredamount = amount.text;
                        num parsedAmount = int.tryParse(enteredamount) ?? 0.0;

                        setState(() {
                          if (selectedActivity == "expense") {
                            value.expenseDeposit(parsedAmount as int);
                            value.expense = parsedAmount;
                            amount.clear();
                          } else if (selectedActivity == "income") {
                            value.incomeDeposit(parsedAmount as int);
                            value.income = parsedAmount;
                            amount.clear();
                          }
                        });
                      },
                    )),
              ]),
            )
          ],
        ),
      );
    });
  }
}

List<Widget> buildIncomeIcons() {
  return [
    IncomeIconz(
      Iconz: Icons.attach_money_rounded,
      Icon_text: "Personal",
    ),
    IncomeIconz(
      Iconz: Icons.payment,
      Icon_text: "Business",
    ),
    const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black,
      endIndent: 10,
    ),
  ];
}

List<Widget> buildExpenseIcons() {
  return [
    IncomeIconz(
      Iconz: Icons.restaurant,
      Icon_text: "Food",
    ),
    IncomeIconz(
      Iconz: Icons.directions_car,
      Icon_text: "Transport",
    ),
    IncomeIconz(
      Iconz: Icons.health_and_safety,
      Icon_text: "Health",
    ),
    IncomeIconz(
      Iconz: Icons.school,
      Icon_text: "Education",
    ),

    const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black,
      endIndent: 10,
    ),
  ];
}

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  Widget build(BuildContext context) {
    return const loans();
  }
}

class LoanHistory extends StatefulWidget {
  const LoanHistory({super.key});

  @override
  State<LoanHistory> createState() => _LoanHistoryState();
}

class _LoanHistoryState extends State<LoanHistory> {
  @override
  void initState() {
    super.initState();
    // Fetch loans when the widget initializes
    final mymoney = Provider.of<Mymoney>(context, listen: false);
    mymoney.fetchLoans();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Mymoney>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Loan History")),
          body: value.loansList.isEmpty
              ? const Center(child: Text("No records"))
              : ListView.builder(
                  itemCount: value.loansList.length,
                  itemBuilder: (context, index) {
                    final loan = value.loansList[index];
                    // Format date and time
                    DateTime dateTime = loan['created_at'].toDate();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(dateTime); // Only Date
                    String formattedTime =
                        DateFormat('hh:mm a').format(dateTime); // Only Time

                    return Card(
                      child: ListTile(
                        title: Text(
                            'Principal: ${loan['currency']} ${loan['loanAmount']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rate: ${loan['rate']}%'),
                            Text(
                                'Installment:  ${loan['currency']} ${loan['monthlypay']}'),
                            Text('Period: ${loan['period']} months'),
                            Text(
                                'Total Payment: ${loan['totalpayment']} ${loan['currency']}'),
                            Text('Date: $formattedDate'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class quotesPage extends StatefulWidget {
  const quotesPage({super.key});

  @override
  State<quotesPage> createState() => _quotesPageState();
}

class _quotesPageState extends State<quotesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.offwhite,
      body: myquotes(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation for 60 seconds (1 minute)
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/sikamate.png',
              width: 300, // Adjust width as needed
              height: 400, // Adjust height as needed
              fit: BoxFit.contain, // Adjust the image fit
            ),

          ],
        ),
      ),
    );
  }
}

class IncomeExpenseChart extends StatelessWidget {
  final int income;
  final int expense;

  const IncomeExpenseChart({super.key, required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Income & Expense Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (income > expense ? income : expense).toDouble() + 10,
            // Set maxY slightly higher than the largest value
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Income');
                      case 1:
                        return const Text('Expense');
                      default:
                        return const Text('No data');
                    }
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: income.toDouble(),
                    color: Colors.green,
                    width: 20,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: expense.toDouble(),
                    color: Colors.amber,
                    width: 20,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppRoutes {
  static const String home = "home";
  static const String signup = "/signup";
  static const String splash = "/splashscreen";
  static const String quotes = "/quotes";

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const MyHomePage(
          title: 'SikaMate',
        ),
    signup: (context) => const SignUpScreen(),
    splash: (context) => const SplashScreen(),
    quotes: (context) => const quotesPage(),
  };
}
