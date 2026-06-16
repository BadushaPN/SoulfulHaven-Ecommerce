import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projectone/view/parenting_guide_view.dart';
import 'package:projectone/view/audio_gallery_view.dart';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return MockHttpClient();
  }
}

class MockHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #getUrl || 
        invocation.memberName == #openUrl || 
        invocation.memberName == #get || 
        invocation.memberName == #open) {
      return Future.value(MockHttpClientRequest());
    }
    return null;
  }

  @override
  set authenticate(Future<bool> Function(Uri url, String scheme, String? realm)? f) {}
  @override
  set authenticateProxy(Future<bool> Function(String host, int port, String scheme, String? realm)? f) {}
  @override
  set badCertificateCallback(bool Function(X509Certificate cert, String host, int port)? callback) {}
  @override
  set connectionFactory(Future<ConnectionTask<Socket>> Function(Uri url, String? proxyHost, int? proxyPort)? f) {}
  @override
  set findProxy(String Function(Uri url)? f) {}
  @override
  set keyLog(Function(String line)? callback) {}
}

class MockHttpClientRequest implements HttpClientRequest {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #headers) {
      return MockHttpHeaders();
    }
    if (invocation.memberName == #close) {
      return Future.value(MockHttpClientResponse());
    }
    if (invocation.memberName == #done) {
      return Future.value(MockHttpClientResponse());
    }
    return null;
  }

  @override
  bool bufferOutput = true;
  @override
  String get method => 'GET';
  @override
  Future flush() => Future.value();
}

class MockHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

  @override
  void clear() {}
  @override
  DateTime? ifModifiedSince;
  @override
  void noFolding(String name) {}
}

class MockHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  final List<int> _transparentImage = [
    71, 73, 70, 56, 57, 97, 1, 0, 1, 0, 128, 0, 0, 0, 0, 0, 255, 255, 255, 33, 249, 4, 1, 0, 0, 0, 0, 44, 0, 0, 0, 0, 1, 0, 1, 0, 0, 2, 2, 76, 1, 0, 59
  ];

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #statusCode) {
      return 200;
    }
    if (invocation.memberName == #contentLength) {
      return _transparentImage.length;
    }
    if (invocation.memberName == #headers) {
      return MockHttpHeaders();
    }
    return null;
  }

  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  @override
  X509Certificate? get certificate => null;
  @override
  HttpConnectionInfo? get connectionInfo => null;
  @override
  Future<Socket> detachSocket() => throw UnimplementedError();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

void main() {
  testWidgets('Parenting Guide screen rendering test', (WidgetTester tester) async {
    HttpOverrides.global = MockHttpOverrides();
    // Set screen size to desktop size to show desktop navbar and layouts without overflow
    tester.view.physicalSize = const Size(2200, 1080);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build ParentingGuideView and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: const ParentingGuideView(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the Hero Banner text exists.
    expect(find.text('Parenting'), findsWidgets);
    expect(find.text('Guide'), findsWidgets);

    // Verify that the "AS SEEN ON SHARK TANK INDIA" elements are rendered
    expect(find.text('SHARK'), findsOneWidget);
    expect(find.text('TANK'), findsOneWidget);

    // Verify that some article titles exist
    expect(find.text('10 Easy Mantras Every Child Can Learn'), findsOneWidget);
    expect(find.text('Why Do We Offer Water to the Sun?'), findsOneWidget);
  });

  testWidgets('Audio Gallery screen rendering test', (WidgetTester tester) async {
    HttpOverrides.global = MockHttpOverrides();
    // Set screen size to desktop size to show desktop navbar and layouts without overflow
    tester.view.physicalSize = const Size(2200, 1080);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build AudioGalleryView and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: const AudioGalleryView(),
      ),
    );
    await tester.pump();

    // Verify that the Hero Banner text exists.
    expect(find.text('Listen to the Divine'), findsOneWidget);

    // Verify that the screen title "Audio Gallery" is rendered
    expect(find.text('Audio Gallery'), findsWidgets);

    // Verify that some deity audio tracks exist in the grid
    expect(find.text('Devi Lakshmi Mantras'), findsOneWidget);
    expect(find.text('Lord Ganesh Mantras'), findsOneWidget);
    expect(find.text('Little Sardarji'), findsOneWidget);

    // Verify that the interactive player is NOT visible initially
    expect(find.byType(Slider), findsNothing);

    // Click on a track card to launch the interactive player
    await tester.tap(find.text('Devi Lakshmi Mantras'));
    await tester.pump();

    // Now check if the audio player sheet appeared and contains the track title
    expect(find.text('Playing...'), findsWidgets);
    expect(find.byType(Slider), findsWidgets);

    // Tap the close button to stop playback and cancel the periodic progress timer
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    // Pump a 3-second duration to let the snackbar auto-dismiss timer finish
    await tester.pump(const Duration(seconds: 3));
  });
}
