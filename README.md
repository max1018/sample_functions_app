# Sample Functions App

Tiny Flutter sample that bundles a few quick utilities: a counter, Celsius → Fahrenheit conversion, text reversal, and a random number roller. Use the reset action to put everything back to the starting state.

## Run it
1. Ensure Flutter is installed and on your `PATH` (project was upgraded with Flutter 3.38.4).
2. (Optional) Regenerate platform scaffolding after agreeing to the Xcode license:
   ```
   flutter create . --project-name sample_functions_app --platforms=android,ios,macos,web
   ```
   This keeps `lib/main.dart` intact and just fills in any missing platform files.
3. Install packages: `flutter pub get`
4. Start the app on your preferred device or in Chrome: `flutter run -d chrome`
5. Run the sample widget tests: `flutter test`

## Notes
- Flutter upgraded fine; widget tests pass; `flutter build web` succeeds.
- Android side is ready: SDK 36 + Build Tools installed and licenses accepted.
- Local JDK 17 unpacked to `.jdks/jdk-17.0.17+10/Contents/Home`; set `JAVA_HOME` to that path if you want to use it for Android/Gradle:  
  `export JAVA_HOME=$PWD/.jdks/jdk-17.0.17+10/Contents/Home; export PATH="$JAVA_HOME/bin:$PATH"`
- Remaining blocker is Apple-side setup: accept the Xcode license (`sudo xcodebuild -license accept`) and run `sudo xcodebuild -runFirstLaunch` to install required components. CocoaPods is also reported broken; re-install if you plan to build for iOS/macOS.
