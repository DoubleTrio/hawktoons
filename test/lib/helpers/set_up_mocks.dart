import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = Function(MethodCall call);

void setupCloudFirestoreMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        // ignore: avoid_dynamic_calls
        'name': call.arguments['appName'] as Object,
        // ignore: avoid_dynamic_calls
        'options': call.arguments['options'] as Object,
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

const String kTestString = 'Hello World';
const String kBucket = 'gs://fake-storage-bucket-url.com';
const String kSecondaryBucket = 'gs://fake-storage-bucket-url-2.com';

const String testString = 'Hello World';
const String testBucket = 'test-bucket';

const String testName = 'bar';
const String testFullPath = 'foo/$testName';

const String testToken = 'mock-token';
const String testParent = 'test-parent';
const String testDownloadUrl = 'test-download-url';
const Map<String, dynamic> testMetadataMap = <String, dynamic>{
  'contentType': 'gif'
};
const int testMaxResults = 1;
const String testPageToken = 'test-page-token';


void setupFirebaseStorageMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
            'storageBucket': kBucket
          },
          // 'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        // ignore: avoid_dynamic_calls
        'name': call.arguments['appName'] as Object,
        // ignore: avoid_dynamic_calls
        'options': call.arguments['options'] as Object,
      };
    }

    return null;
  });
}