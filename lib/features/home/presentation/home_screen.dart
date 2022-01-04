import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

	@override
	createState() => _HomePage();
}
class _HomePage extends State<HomePage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(),
		);
	}
}
