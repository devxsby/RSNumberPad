# RSNumberPad

A library to store and verify algorithmically encrypted numbers in a keychain using a keypad with randomly changing numbers.

<br>

[![CI Status](https://img.shields.io/travis/devxsby/RSNumberPad.svg?style=flat)](https://travis-ci.org/devxsby/RSNumberPad)
[![Version](https://img.shields.io/cocoapods/v/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)
[![License](https://img.shields.io/cocoapods/l/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)
[![Platform](https://img.shields.io/cocoapods/p/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)


## Example
<img src="https://github.com/devxsby/RSNumberPad/assets/80062632/e0683dc7-6ad1-4a91-87a0-f39a3c97090a" width="30%/"><br>

<br>

## Installation

- **Using  [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'RSNumberPad'
    ```

- **Using [Swift Package Manager](https://swift.org/package-manager)**:

    ```swift
    import PackageDescription

    let package = Package(
      name: "AppName",
      dependencies: [
        .Package(url: "https://github.com/devxsby/RSNumberPad", .upToNextMajor(from: "1.0.0")),
      ]
    )
    ```

<br>

## Requirements
- iOS 13.0+

<br>

## Usage

- Programmatically

  ```swift
  import RSNumberPad

  let numberPadTextfield = RSNumberPad()

  ```

- Storyboard
  <br><img src="https://github.com/devxsby/RSNumberPad/assets/80062632/bc61e7aa-74cb-4f7c-805b-e78b0107dc2b" width="30%/"><br>

<br>

## Author

devxsby, devxsby@gmail.com

<br>

## License

**RSNumberPad** is under MIT license. See the [LICENSE](LICENSE) file for more info.
