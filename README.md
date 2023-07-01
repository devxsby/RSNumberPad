# RSNumberPad

RSNumberPad is a library that provides a random number keypad for use in iOS applications.

This library offers a randomly changing number keypad to the user, enhancing security during password input.


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

### 1. Keyboard Setup
Create an instance of RSNumberPad and place it in the required location. The keyboard is automatically configured when added to the view.

- Programmatically

  ```swift
  import RSNumberPad

  let numberPadTextfield = RSNumberPad()

  ```

- Storyboard
  <br><img src="https://github.com/devxsby/RSNumberPad/assets/80062632/bc61e7aa-74cb-4f7c-805b-e78b0107dc2b" width="30%/"><br>

### 2. Password Storage
Use the `savePassword(key: String, password: String)` method to hash and store the password entered by the user. This method uses a key to securely store the password in the keychain.

### 3. Password Verification
Use the `checkPassword(key: String, password: String)` method to verify the password entered by the user. This method uses a key to retrieve the password from the keychain and compares it with the password entered by the user.

<br>

## Key Features

### 1. Random Number Keypad
Each time the user invokes the keypad, **the positions of the numbers are randomly changed**. This makes it difficult to predict the user's password input pattern.

### 2. Password Hashing and Storage
The password input by the user is hashed using the **SHA-256 algorithm**, and this hash value is safely stored in the iOS keychain.

### 3. Password Verification
The password entered by the user is hashed and compared with the value stored in the **keychain**. This verifies the accuracy of the password.


In addition to these, this library applies the MVVM architecture to separate the view and the model and to allow the keypad view to be customized freely according to needs. Therefore, updates to control the state of each button (number, delete, random) or to change the shape, size, etc. of the keypad are planned.



<br>

## Author

devxsby, devxsby@gmail.com

<br>

## License

**RSNumberPad** is under MIT license. See the [LICENSE](LICENSE) file for more info.
