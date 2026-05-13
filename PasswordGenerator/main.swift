//
//  main.swift
//  PasswordGenerator
//
//  Created by Валерия Пономарева on 11.05.2026.
//

import Foundation

struct PasswordSettings {
    var length = 12
    var useDigits = true
    var useUppercase = true
    var useLowercase = true
    var useSymbols = false
}

func generatePassword(_ settings: PasswordSettings) -> String? {
    guard settings.useDigits || settings.useUppercase || settings.useLowercase || settings.useSymbols else { return nil }

    let digits = Array("0123456789")
    let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let lowercase = Array("abcdefghijklmnopqrstuvwxyz")
    let symbols = Array("!@#$%^&*()_+-=[]{};':\",.<>?/")

    var required: [Character] = []
    var all: [Character] = []

    if settings.useDigits { required.append(digits.randomElement()!); all += digits }
    if settings.useUppercase { required.append(uppercase.randomElement()!); all += uppercase }
    if settings.useLowercase { required.append(lowercase.randomElement()!); all += lowercase }
    if settings.useSymbols { required.append(symbols.randomElement()!); all += symbols }

    guard settings.length >= required.count else { return nil }

    var password = required
    for _ in 0..<(settings.length - required.count) {
        password.append(all.randomElement()!)
    }

    password.shuffle()
    return String(password)
}

var passwordSettings = PasswordSettings()

outer: while true {
    print("\n> ", terminator: "")
    let parts = (readLine() ?? "").split(separator: " ").map(String.init)
    guard let cmd = parts.first else { continue }

    switch cmd {
    case "generate":
        if let password = generatePassword(passwordSettings) {
            print("🔐 Generated password: \(password)")
        } else {
            print("❌ Error: invalid settings")
        }

    case "set":
        guard parts.count == 3, parts[1] == "length",
              let n = Int(parts[2]), (8...20).contains(n) else {
            print("❌ Use: set length <8...20>")
            continue
        }
        passwordSettings.length = n
        print("✅ Length set to \(n)")

    case "toggle":
        guard parts.count == 2 else {
            print("❌ Use: toggle digits|uppercase|lowercase|symbols")
            continue
        }

        switch parts[1] {
        case "digits":
            passwordSettings.useDigits.toggle()
            print("✅ Digits: \(passwordSettings.useDigits ? "✅" : "❌")")
        case "uppercase":
            passwordSettings.useUppercase.toggle()
            print("✅ Uppercase: \(passwordSettings.useUppercase ? "✅" : "❌")")
        case "lowercase":
            passwordSettings.useLowercase.toggle()
            print("✅ Lowercase: \(passwordSettings.useLowercase ? "✅" : "❌")")
        case "symbols":
            passwordSettings.useSymbols.toggle()
            print("✅ Symbols: \(passwordSettings.useSymbols ? "✅" : "❌")")
        default:
            print("❌ Unknown toggle option")
        }

    case "show":
        guard parts.count == 2, parts[1] == "settings" else {
            print("❌ Unknown command")
            continue
        }
        print("""
        🔧 Settings:
          Length: \(passwordSettings.length)
          Digits: \(passwordSettings.useDigits ? "✅" : "❌")
          Uppercase: \(passwordSettings.useUppercase ? "✅" : "❌")
          Lowercase: \(passwordSettings.useLowercase ? "✅" : "❌")
          Symbols: \(passwordSettings.useSymbols ? "✅" : "❌")
        """)

    case "exit":
        print("👋 Bye!")
        break outer

    default:
        print("❌ Unknown command")
    }
}
