import 'package:firebase_data_connect/firebase_data_connect.dart'
    as data_connect;

import '../../../../core/config/env/env.dart';

class FirebaseDataConnect {
  FirebaseDataConnect({required this.dataConnect});

  data_connect.FirebaseDataConnect dataConnect;

  static final instance = FirebaseDataConnect(
    dataConnect: data_connect.FirebaseDataConnect.instanceFor(
      connectorConfig: connectorConfig,
    ),
  );

  static final connectorConfig = data_connect.ConnectorConfig(
    Env.instance.firebaseDataConnectLocation,
    Env.instance.firebaseDataConnectConnector,
    Env.instance.firebaseDataConnectServiceId,
  );
}
