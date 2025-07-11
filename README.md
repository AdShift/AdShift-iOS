# ADShift - SDK

[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)

# Requirements
  - **iOS version 14.0 & Above**

# Table Of Contents

1. [Installation](#Installation)
1. [Integration](#Integration)
1. [Consents](#Consents)
1. [Deeplinking](#Deeplinking)
1. [SKAN Postback](#SKAN)
1. [Usage](#Usage)
1. [Support](#support)


---


## [Installation](#Installation)

#### [Swift Package Manager - SPM](#SPM)

The [Swift Package Manager](https://swift.org/package-manager/) is Swift's native dependency management tool, built directly into the `swift` compiler. To integrate AdShift into your project:

To install the SDK into your project, navigate to "File" -> "Add Package Dependencies" and use this link:

```swift
https://github.com/adshift/adshift-swift.git
```

After setting up your Swift package, simply add AdShift to the `dependencies` section in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/adshift/adshift-swift.git")
]
```

#### [Cocoapods](#Cocoapods)

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate AdShift into your Xcode project using CocoaPods, specify it in your `Podfile`:

**Note:** It could be necessary to set "User Script Sandboxing" to "No" in your build settings.

- Add below in podfile - in respective target block

```swift
pod 'AdShiftIOS'
```

- Execute below command in terminal

```swift
pod install
```

---


## [Integration](#Integration)
<ins> If you use AppDelegate, configure your AdShift Api Key in `didFinishLaunchingWithOptions`. </ins>

Simply import the SDK using:

```swift
import AdshiftSDK
```

To integrate the AdShift SDK, simply call the `setApiKey` method with your unique API key.

```swift
Adshift.shared.setApiKey(apiKey: "[YOUR_API_KEY]")
```

Set a unique User ID if there is one:
```swift
Adshift.shared.setCustomerUserId(userId: "[USER_ID]")
```


Here is a complete example of how SDK initialization should look:
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    Adshift.shared.setApiKey(apiKey: "[YOUR_API_KEY]")
    Adshift.shared.setCustomerUserId(userId: "[USER_ID]")

    return true
}
```

Or, if you use the App file, call these methods within your @main App class:

```swift
@main
struct adshiftSampleAppApp: App {

    init() {
        Adshift.shared.setApiKey(apiKey: "[YOUR_API_KEY]")
        Adshift.shared.setCustomerUserId(userId: "[USER_ID]")    
    }

    ...
}
```swift

Use the `start` method to initialize and begin running the SDK.

**Note:** <ins> The SDK will not send any events or handle deep link requests until this method is called.</ins> 
```swift 
Adshift.shared.start()
```

---


## [Consents](#Consents)

[More information here](https://developer.apple.com/documentation/bundleresources/information-property-list/nsusertrackingusagedescription)
Manually set given consents 
```swift
Adshift.shared.setConsentData(newConsent: AdShiftConsent.forGDPRUser(
    hasConsentForDataUsage: true,
    hasConsentForAdsPersonalization: true,
    hasConsentForAdStorage: true)
)
```

---

## [Deeplinking](#Deeplinking)

#### Sets a callback to handle any incoming deeplink response that was sent to the backend.
```swift
Adshift.shared.onDeeplinkReceived { response in
    // Your response handling
}
```

#### Handles a received deeplink and notifies all registered listeners via  `onDeeplinkReceived`.
**func setDeeplinkListener(url: URL)**
<ins>Call this method every time your app receives a deep link to ensure proper attribution and event tracking.</ins>

If you're using a scene-based architecture, register the deep link in your app’s scene configuration using `.onOpenURL { url in }`:
```swift
.onOpenURL { url in
    Adshift.shared.setDeeplinkListener(url: url)
}
```

Or If you're using the App Delegate, handle the deep link in the `application(_:continue:restorationHandler:)` method:
```swift
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
        Adshift.shared.setDeeplinkListener(url: url.absoluteString)
        return true
    }
    return false
}
```


---


## [SKAN Postback](#SKAN)

To configure direct install postbacks, add Adjust’s callback URL to your Info.plist file:

1. In Xcode, open the Info.plist file from the Project Navigator.
2. Click the Add button next to any key in the property list editor and press Return.
3. Set the key name to: `NSAdvertisingAttributionReportEndpoint`
4. Change the type to String.
5. Set the value to: 
    
```swift
https://adshift-skadnetwork.com
```

Or open your `info.plist` as a source code and enter this key-value pair manualy:

```swift
<key>NSAdvertisingAttributionReportEndpoint</key>
<string>https://adshift-skadnetwork.com/</string>
```


---


## [Usage](#Usage)

#### `func isStarted() -> Bool`
Returns `true` if the SDK has already been started.

```swift
Adshift.shared.isStarted()
```

#### `func start(onStart: (() -> Void)? = nil)`
Starts the SDK if a valid API key is set. Calls `onStart` closure if provided.
**note:** You can't start the SDK without setting a valid API key.

```swift
Adshift.shared.start { 
///Your logic after starting the SDK
}
```

#### `func stop(onStop: (() -> Void)? = nil)`
Stops the SDK. Calls `onStop` closure if provided.

```swift
Adshift.shared.stop { 
///Your logic after stopping the SDK
}
```

#### `func setCustomerUserId(_ userId: String)`
Associates a custom user ID with all future tracked events.

```swift
Adshift.shared.setCustomerUserId("YOUR_USER_ID")
```

#### `func trackPurchase(productId: String, price: Double, currency: String, token: String)`
Sends a purchase event to the backend with price, currency, and token metadata.

```swift
Adshift.shared.trackPurchase(
    productId: "YOUR_PRODUCT_ID", 
    price: "YOUR_PRICE", 
    currency: "CURRENT_CURRENCY", 
    token: "UNIQUE_PURCHASE_TOKEN")
```

#### `func setConsentData(newConsent: AdShiftConsent)`
Stores user consent settings within the SDK for compliant tracking.

**Note:** You have two accessible initializers.

The first option is for non-GDPR users. If you don’t have any consents, use `AdShiftConsent.forNonGDPRUser()`.
It sets all consent statuses to `false`.

```swift
Adshift.shared.setConsentData(newConsent: .forNonGDPRUser())
```

Or you can manualy setup consents using `AdShiftConsent.forNonGDPRUser()` 

```swift
Adshift.shared.setConsentData(newConsent: .forGDPRUser(
                            hasConsentForDataUsage: [YOUR_VALUE],
                            hasConsentForAdsPersonalization: [YOUR_VALUE],
                            hasConsentForAdStorage: [YOUR_VALUE]))
```

Check [THIS](https://developer.apple.com/documentation/uikit/requesting-access-to-protected-resources) to learn how to retrieve user consent values.

#### `func setApiKey(apiKey: String)`
Sets the API key to initialize the SDK. Triggers deferred deep link resolution.

```swift
Adshift.shared.setApiKey(apiKey: "[YOUR_UNIQUE_API_KEY]")
```

#### `func setLogLevel(_ logLevel: LoggerLevel)`
Sets the desired verbosity level of SDK logs (`debug`, `info`, `warning`, `error`).

enum LoggerLevel {
    case trace
    case debug
    case info
    case warning
    case error
}

| Level     | Description                                                                         |
| --------- | ----------------------------------------------------------------------------------- |
| `trace`   | Finest-grained messages,for detailed debugging and tracing program flow. |
| `debug`   | General debugging information useful during development.                            |
| `info`    | Informational messages highlighting normal operation events.                        |
| `warning` | Indications of potential issues or important situations that are not errors.        |
| `error`   | Error messages indicating failures or serious issues that need attention.           |


Usage example:
```swift
Adshift.shared.setLogLever(.debug)
```

#### `func trackEvent(eventName: ASInAppEventType)`
Tracks a general in-app event like `login`, `signup`, or custom events.

Here is a complete list of default events that you can use:

enum ASInAppEventType {
    case levelAchieved
    case addPaymentInfo
    case addToCart
    case addToWishList
    case completeRegistration
    case tutorialCompletion
    case initiatedCheckout
    case purchase
    case rate
    case search
    case spentCredit
    case achievementUnlocked
    case contentView
    case travelBooking
    case share
    case invite
    case login
    case reEngage
    case update
    case openedFromPushNotification
    case listView
    case subscribe
    case startTrial
    case adClick
    case adView
    case locationChanged
    case locationCoordinates
    case orderId
    case customerSegment
    case customEvent(String)
}

Usage example: 
```swift
Adshift.shared.trackEvent(eventName: .customEvent("YOUR_EVENT_NAME"))
```


---


## [Support](#support)

If you have any questions, need help with integration, or encounter issues using the AdShift SDK, feel free to reach out to our support team.

📧 Email: kacper.wozniak@adshift.com
