//
//  main.swift
//  PasswordGenerator
//
//  Created by Валерия Пономарева on 11.05.2026.
//

import Foundation

// Модель данных
struct PasswordSettings {
    var length: Int = 12
    var useDigits: Bool = true
    var useUppercase: Bool = true
    var useLowercase: Bool = true
    var useSymbols: Bool = false
}

// Команды
enum Command: String {
    case generate = "generate"
    case setLength = "set length"
    case toggleDigits = "toggle digits"
    case toggleUppercase = "toggle uppercase"
    case toggleLowercase = "toggle lowercase"
    case toggleSymbols = "toggle symbols"
    case showSettings = "show settings"
    case exit = "exit"
}

// Глобальные настройки
var settings = PasswordSettings()

// Главный цикл
while true {
    print("\n> ", terminator: "")
    guard let input = readLine()?.trimmingCharacters(in: .whitespaces), !input.isEmpty else { continue }
    
    let parts = input.split(separator: " ").map(String.init)
    let commandRaw = parts[0]
    
    guard let command = Command(rawValue: commandRaw) else {
        print("❌ Unknown command")
        continue
    }
    
    switch command {
    case .generate:
        // TODO
        print("generate (stub)")
    case .setLength:
        // TODO
        print("set length (stub)")
    case .toggleDigits:
        settings.useDigits.toggle()
        print("✅ Digits: \(settings.useDigits ? "✅" : "❌")")
    case .toggleUppercase:
        settings.useUppercase.toggle()
        print("✅ Uppercase: \(settings.useUppercase ? "✅" : "❌")")
    case .toggleLowercase:
        settings.useLowercase.toggle()
        print("✅ Lowercase: \(settings.useLowercase ? "✅" : "❌")")
    case .toggleSymbols:
        settings.useSymbols.toggle()
        print("✅ Symbols: \(settings.useSymbols ? "✅" : "❌")")
    case .showSettings:
        print("""
        🔧 Settings:
          Length: \(settings.length)
          Digits: \(settings.useDigits ? "✅" : "❌")
          Uppercase: \(settings.useUppercase ? "✅" : "❌")
          Lowercase: \(settings.useLowercase ? "✅" : "❌")
          Symbols: \(settings.useSymbols ? "✅" : "❌")
        """)
    case .exit:
        print("👋 Bye!")
        
    }
}
