import 'package:flutter/material.dart';

void main() => runApp(WattCalculatorApp());

class WattCalculatorApp extends StatefulWidget {
  @override
  WattCalculatorAppState createState() => WattCalculatorAppState();
}

class WattCalculatorAppState extends State<WattCalculatorApp> {
  String inputwatt = "";
  String inputtime = "";
  String result = "";
  String pricing = "";
  String currency = "USD";
  String timeUnit = "hours";
  String powerUnit = "Watts";
  final double pricePerKwh = 0.1106;

  void calculateCost() {
    try {
      double power = double.parse(inputwatt);
      double time = double.parse(inputtime);

      // Convert to kilowatts
      if (powerUnit == "Watts") {
        power = power / 1000; // Convert W to KW
      }

      // Calculate hours
      double hours;
      if (timeUnit == "Months") {
        hours = time * 30 * 24; // Month = 30 days
      } else {
        hours = time; // Already in hours
      }

      // Calculate cost
      double cost = power * hours * pricePerKwh;

      if (currency == "LBP") {
        cost *= 89000;
      }

      pricing = 'Pricing: \$0.1106 per KWH';
      result = 'Cost: ${cost.toStringAsFixed(2)} $currency';
    } catch (e) {
      pricing = '';
      result = 'Please fill all fields correctly';
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateCost();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watt Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Electric Consumption Calculator'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 24, 111, 182),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Want to calculate the consumption of your electronic devices? '
                    'Please fill out the details below. The prices are according to the Lebanese pricing of watts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 230,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        inputwatt = value;
                        calculateCost();
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter power consumption',
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: powerUnit,
                  items: ["Watts", "Kilowatts"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      powerUnit = newValue!;
                      calculateCost();
                    });
                  },
                ),
                SizedBox(
                  width: 230,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        inputtime = value;
                        calculateCost();
                      });
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter time',
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: timeUnit,
                  items: ["hours", "Months"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      timeUnit = newValue!;
                      calculateCost();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Currency: ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: currency,
                      items: ["USD", "LBP"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          currency = newValue!;
                          calculateCost();
                        });
                      },
                    ),
                  ],
                ),
                if (currency == "LBP")
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Rate: 89,000 LBP',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Text(
                        pricing,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        result,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
