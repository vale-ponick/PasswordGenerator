//
//  main.swift
//  PasswordGenerator
//
//  Created by Валерия Пономарева on 11.05.2026.
//

import Foundation

// Модель данных
struct PasswordSettings { // структура хранит данные пароля: длина + исп.цифры+заглавные буквы + строчные буквы + использ.символы
    var length: Int = 12
    var useDigits: Bool = true
    var useUppercase: Bool = true
    var useLowercase: Bool = true
    var useSymbols: Bool = false
}

// Команды
enum Command: String { // команды
    case generate = "generate" // создать
    case setLength = "set length" // установить длину
    case toggleDigits = "toggle digits" //проверить наличие цифр
    case toggleUppercase = "toggle uppercase" // проверить наличие заглавных букв
    case toggleLowercase = "toggle lowercase" // проверить наличие строчных букв
    case toggleSymbols = "toggle symbols" // проверить наличие символов
    case showSettings = "show settings" // показать настройки пароля
    case exit = "exit" // выход из программы
}

// Глобальные настройки
var settings = PasswordSettings() //// создаём экземпляр структуры с настройками по умолчанию (длина 12, цифры и буквы включены, символы выключены)

// Главный цикл
while true {
    print("\n> ", terminator: "")
    guard let input = readLine()?.trimmingCharacters(in: .whitespaces), !input.isEmpty else { continue }
    
    let parts = input.split(separator: " ").map(String.init) // разбиваем ввод на части по пробелам (например, "set length 12" → ["set", "length", "12"])
    let commandRaw = parts[0] // первая часть ввода — это название команды (например, "generate", "set", "toggle", "show")
    
    guard let command = Command(rawValue: commandRaw) else { // преобразуем строку команды в значение enum Command; если не получилось — ошибка
        print("❌ Unknown command") // если введённая строка не соответствует ни одному case в enum Command
        continue
    }
    
    switch command {
    case .generate:
        // TODO: реализовать генерацию пароля
        print("generate (stub)") // временная заглушка, вместо реальной генерации пароля
    case .setLength:
        guard parts.count == 3, parts[1] == "length" else { // проверяет, что ввели set length N (три части, вторая — "length")
            print("❌ Invalid format. Use: set length <N>")
            continue
        }
        guard let length = Int(parts[2]), length >= 8, length <= 20 else { //преобразует "12" в число 12, проверяет диапазон
            print("❌ Length must be between 8 and 20")
            continue
        }
        settings.length = length // сохраняет новую длину
        print("✅ Length set to \(length)") // подтверждение
    case .toggleDigits:
        settings.useDigits.toggle() // переключаем флаг использования цифр
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
