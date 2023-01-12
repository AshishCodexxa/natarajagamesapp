import 'package:flutter/material.dart';
import 'package:nataraja_games/presentation/payment.dart';
import 'package:nataraja_games/presentation/webViewController.dart';

class HomeScreen extends StatefulWidget {
  final String coin;

  const HomeScreen({super.key, required this.coin});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _links = 'https://natarajagames.in/app/login.php';

  TextEditingController amountController = TextEditingController();


  @override
  void initState() {
    super.initState();
    print("WebBalance ${widget.coin}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              getCoinInfo(),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: getRechargeButton(),
              ),
            ],
          ),
         /* Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: getWebViewButton(_links),
          )*/
        ],
      ),
    );
  }

  Widget getCoinInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   height: 30,
          //   width: 150,
          //   decoration: BoxDecoration(
          //     color: Colors.black12,
          //     borderRadius: BorderRadius.circular(7),
          //   ),
          //   child:  const Center(
          //     child: Text("Current Balance : ",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 17,
          //       fontWeight: FontWeight.bold
          //     ),),
          //   ),
          // ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Current Balance :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Image(
                    image: AssetImage("assets/images/coin.png"),
                    height: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.coin,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRechargeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            showDialog(
                context: context,
                builder: (ctxt) => AlertDialog(
                      title: const Text(
                        "Recharge Amount",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Container(
                        height: 115,
                        width: 100,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.red, width: 1)),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: amountController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    hintText: "Enter Amount",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 15)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onDoubleTap: () {},
                                onTap: () {
                                  if (amountController.text.isNotEmpty) {
                                    int amount =
                                        int.parse(amountController.text);
                                    if (amount >= 200 && amount <= 1000) {
                                      print("Hiiiii");
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height: 200,
                                              color: Colors.amber,
                                              child: Payment(
                                                amount: amountController.text,
                                              ));
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please Enter Amount Maximum 200 and Minimum 1000")));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Amount Maximum 200 and Minimum 1000")));
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: const Center(
                                    child: Text(
                                      "RECHARGE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              "Recharge Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }

  Widget getWebViewButton(String url) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            _handleURLButtonPress(context, url);
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              "Nataraja Games Web",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url,"")));
  }
}
