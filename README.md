# RSNumberPad

RSNumberPad is a library that provides a randomized numeric keypad for use in iOS applications.

By providing the user with a randomly changing numeric keypad, this library improves security during password entry. The library also supports dark mode and landscape mode, and automatically raises the view when the keyboard covers a text field to give the user a visual representation of the text field.

<br>

[![CI Status](https://img.shields.io/travis/devxsby/RSNumberPad.svg?style=flat)](https://travis-ci.org/devxsby/RSNumberPad)
[![Version](https://img.shields.io/cocoapods/v/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)
[![License](https://img.shields.io/cocoapods/l/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)
[![Platform](https://img.shields.io/cocoapods/p/RSNumberPad.svg?style=flat)](https://cocoapods.org/pods/RSNumberPad)


## Example

| Light Mode | Dark Mode |
|:------------:|:-----------:|
|<img src="https://github.com/devxsby/RSNumberPad/assets/80062632/0a7cfff3-84d4-4922-b522-730316dadb5eb" width="50%">|<img src="https://github.com/devxsby/RSNumberPad/assets/80062632/cea8634f-9c8c-4f1a-a65b-f65de12910f4" width="50%">|


| Landscape Mode (Light) | Landscape Mode (Dark) |
|:------------:|:-----------:|
|<img src="https://github.com/devxsby/RSNumberPad/assets/80062632/3e6ad5f3-0e11-4d69-8ca7-e6642a95c0f0" width="50%">|<img src="https://github.com/devxsby/RSNumberPad/assets/80062632/9cc42c8f-3b5d-48bf-a977-c4973d0d416f" width="50%">|



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
        .Package(url: "https://github.com/devxsby/RSNumberPad", .upToNextMajor(from: "1.3.0")),
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
The password input by the user is hashed using the UUID를 조합한 **SALT algorithm**, and this hash value is safely stored in the iOS keychain.

### 3. Password Verification
The password entered by the user is hashed and compared with the value stored in the **keychain**. This verifies the accuracy of the password.

### 4. Dark Mode Support
RSNumberPad fully supports iOS's dark mode. When dark mode is enabled, the keypad's theme will automatically change to a dark color.

### 5. Rotate Mode (Landscape Mode) Support
RSNumberPad fully supports landscape mode. When the device is rotated to landscape orientation, the keypad view will automatically adjust to landscape mode.

### 6. Prevent keypad obstruction
If the keypad covers the text field, the view will automatically rise to allow the user to visually see the text field.

### 7. Enhanced Security with Paste Prevention
For enhanced security, RSNumberPad disables the copy and paste function within the text field. This makes it impossible for users to paste copied content into the text field, further securing sensitive data entry.

### 8. Improve usability by dismissing the keypad
In addition to the 'Done' button, RSNumberPad improves usability by allowing users to dismiss the keypad by tapping outside of the text field area. This feature provides a more intuitive way for users to control the keypad's visibility.

In addition to these, this library applies the MVVM architecture to separate the view and the model and to allow the keypad view to be customized freely according to needs. Therefore, updates to control the state of each button (number, delete, random) or to change the shape, size, etc. of the keypad are planned.


<br>

## Author

devxsby, devxsby@gmail.com

<br>

## License

**RSNumberPad** is under MIT license. See the [LICENSE](LICENSE) file for more info.
