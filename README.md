# Hawktoons

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: GPL v3][license_badge]][license_link]
[![codecov][codecov_badge]]([hawktoons_code_coverage])

## About this App 📷
Hawkstoons is an educational political cartoon and image app which aims to teach people something new history at different time periods and places. In collaboration with the history department at Hamburg Area High School, who are willing to commit a week analyzing a historical image and putting them on app!



 <img src="https://user-images.githubusercontent.com/41309226/119214362-4aee7600-ba94-11eb-82d4-5ba9fec54760.png" alt="" width="200" height="400" />
 
## Running Tests 🧪

To run all tag and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:io_photobooth/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```
[app_image_1]: https://user-images.githubusercontent.com/41309226/119214362-4aee7600-ba94-11eb-82d4-5ba9fec54760.png
[app_image_2]: https://user-images.githubusercontent.com/41309226/119214363-4c1fa300-ba94-11eb-8f4f-c924b9371588.png
[codecov_badge]: https://codecov.io/gh/DoubleTrio/political_cartoon_app/branch/main/graph/badge.svg
[coverage_badge]: coverage_badge.svg
[firebase_link]: https://firebase.google.com/
[flutter_link]: https://flutter.dev
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[hawktoons_code_coverage]: https://codecov.io/gh/DoubleTrio/political_cartoon_app
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/License-GPLv3-blue.svg
[license_link]: https://www.gnu.org/licenses/gpl-3.0
[logo]: https://raw.githubusercontent.com/VeryGoodOpenSource/very_good_analysis/main/assets/vgv_logo.png
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core
