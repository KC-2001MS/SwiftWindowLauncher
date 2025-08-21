# SwiftWindowLauncher
SwiftWindowLauncher is an easy way to open any window from the CLI or main function. It is also designed to integrate seamlessly with SwiftUI and AppKit.

## Requirement
The following environment is required to use this library.

<p align="center">
    <img src="https://img.shields.io/badge/macOS-14.0+-red.svg" />
    <img src="https://img.shields.io/badge/Swift-6.1-DE5D43.svg" />
    <a href="https://twitter.com/IroIro1234work">
        <img src="https://img.shields.io/badge/Contact-@IroIro1234work-lightgrey.svg?style=flat" alt="Twitter: @IroIro1234work" />
    </a>
</p>

## Demo
This package includes sample projects that demonstrate how to use it in practice.

## Usage
By using this package, you can open any window during CLI or main function execution as follows.
```swift
import WindowLauncher
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, Swift Window Launcher!")
    }
}

let launcher = WindowLauncher.shared
launcher.launchWindow(view: ContentView())
```

## Install
Add the following files to the Package.swift file for use. For more information, please visit [swift.org](https://www.swift.org/documentation/package-manager/).
``` swift
    dependencies: [
        // Add this code
        .package(url: "https://github.com/KC-2001MS/SwiftWindowLauncher.git", from: "0.0.1"),
    ],
```

## Swift-DocC
Swift-DocC is currently being implemented.
[Documentation](https://kc-2001ms.github.io/SwiftWindowLauncher/documentation)

## Contribution
See [CONTRIBUTING.md](https://github.com/KC-2001MS/SwiftWindowLauncher/blob/main/CONTRIBUTING.md) if you want to make a contribution.

## Licence
[SwiftWindowLauncher](https://github.com/KC-2001MS/SwiftWindowLauncher/blob/main/LICENSE)

## Supporting
If you would like to make a donation to this project, please click here. The money you give will be used to improve my programming skills and maintain the application.  
<a href="https://www.buymeacoffee.com/iroiro" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" >
</a>  
[Pay by PayPal](https://paypal.me/iroiroWork?country.x=JP&locale.x=ja_JP)

## Author
[Keisuke Chinone](https://github.com/KC-2001MS)
