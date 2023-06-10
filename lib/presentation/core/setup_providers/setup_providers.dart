import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../screens/map/provider/map_net_provider.dart';
import '../../screens/provider/test_net_provider.dart';

List<SingleChildWidget> providers = [...independentServices];

List<SingleChildWidget> independentServices = [
  // Map
  ChangeNotifierProvider<MapNetProvider>(
    create: (_) => MapNetProvider(
    ),
    lazy: true,
  ),

  // // Test Net
  ChangeNotifierProvider<TestNetProvider>(
    create: (_) => TestNetProvider(
    ),
    lazy: true,
  )
];
