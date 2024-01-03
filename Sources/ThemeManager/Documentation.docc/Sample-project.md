# NightOwl: Integrating ThemeManager into an App

Integrate ThemeManager into an iOS app to create a visual appealing design with custom fonts and color schemes alongside SwiftUI.

@Metadata {
    @CallToAction( purpose: link, url: "https://github.com/ScribbleLabApp/Composify")
    @PageKind(sampleCode)
    @SupportedLanguage(swift)
    @SupportedLanguage(cpp)
    @Available(macOS, introduced: "14.1.2")
    @Available(iOS, introduced: "17.2.1")
    @Available(iPadOS, introduced: "17.2.1")
    @Available(Xcode, introduced: "15.1")
}

## Overview

> This sample project is associated with SLDC session [2: Meet ThemeManager](https://github.com/ScribbleLabApp/docs).

The NightOwl sample project builds an app for macOS, iOS, and iPadOS that implemets ThemeManager's features like font modifying, and visually appealing color schemes. It also contains [SwiftUI]() plattform features like widgets, App Clips, and localization. It contains two targets:

- Simple iOS and macOS app targets that help you build using [Personal Team](https://developer.apple.com/support/code-signing/) signing. This iOS App runs on the Simulator, and only requires a standard Apple ID to install on a device. This simple App implements a rich, localized [SwiftUI](https://developer.apple.com/xcode/swiftui/) interface. Users learn intresting facts about owls and much more.
- Full featured iOS All and macOS All app targets. The full iOS App runs on Simulator, and on devices with an Apple Developer membership. This App includes interactive widget extensions that enable users to add a Widget to their iOS Home Screen or macOS Desktop/Notification Center, and allow users to see facts about owl, and many more. This app also embeds an App Clip. With the App Clip, users can discover and instantly launch some of the app's functionality on their iPhone or iPad without installing the app.

The Composify sample app leverages [Sign in with Apple]() and other API's to provide a streamlined user experience.

You can access the source code for this sample on [GitHub]().

### Configure the Sample Code Project

To build this project for iOS 17.2.1, use Xcode 15.1. The runtime requirement is iOS 17.2. To build this project for macOS 14.1.2, use Xcode 15.1.

To configure the iOS and macOS targets without an Apple Developer Account, follow these steps:

1. In the targets' Signing & Capabilities panes click Add Account, and log in with your Apple ID.
2. Choose the Your Name (Personal Team) from the drop down menu.
3. Click build-and-run.
4. On iOS and iPad OS devices you need to navigate to Settings > General > VPN & Device Management and trust your developer certificate.

To configure the iOS All and macOS All apps, follow these steps:
1. To run on your devices, including on macOS, set your team in the targets’ Signing & Capabilities panes. Xcode manages the provisioning profiles for you.
2. To run on an iOS or iPadOS device, open the iOSClip.entitlements file and update the value of the Parent Application Identifiers Entitlement to match the iOS app’s bundle identifier.

## See Also

- <doc:GettingStarted>
