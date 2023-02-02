//
//  String+Ext.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Foundation

extension String {
  // MARK: - Localization
  public func localized(bundle: Bundle?) -> String {
    let bundle = bundle ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }

  // MARK: - Date
  public func apiStringDateToDate() -> Date? {
    let yearMonthDateDateFormatter = DateFormatter()
    let yearMonthDateFormatter = DateFormatter()

    yearMonthDateDateFormatter.dateFormat = "yyyy-MM-dd"
    yearMonthDateFormatter.dateFormat = "yyyy-MM"

    return yearMonthDateDateFormatter.date(from: self) ?? yearMonthDateFormatter.date(from: self)
  }

  public func apiToShortDate(locale: Locale = .current) -> String {
    guard let date = self.apiStringDateToDate() else {
      return self
    }

    let dateFormatterResult = DateFormatter()
    let template = "d MMM yyyy"
    
    guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
      return self.apiToFullYearMonthDate(locale: locale)
    }

    dateFormatterResult.dateFormat = localizedFormat

    return dateFormatterResult.string(from: date)
  }

  public func apiToFullDate(locale: Locale = .current) -> String {
    guard let date = self.apiStringDateToDate() else {
      return self
    }

    let dateFormatterResult = DateFormatter()
    let template = "d MMMM yyyy"

    guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
      return self.apiToFullYearMonthDate(locale: locale)
    }

    dateFormatterResult.dateFormat = localizedFormat

    return dateFormatterResult.string(from: date)
  }

  public func apiToFullYearMonthDate(locale: Locale = .current) -> String {
    guard let date = self.apiStringDateToDate() else {
      return self
    }

    let dateFormatterResult = DateFormatter()
    let template = "MMMM yyyy"

    guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
      return self
    }

    dateFormatterResult.dateFormat = localizedFormat

    return dateFormatterResult.string(from: date)
  }

  // MARK: - Other
  public func snakeCaseToTitleCase() -> String {
    return self.replacingOccurrences(of: "_", with: " ").capitalized
  }

  public func containsWords(_ words: String, caseInsensitive: Bool = true) -> Bool {
    // Check if it should be case insensitive
    let firstString = caseInsensitive ? self.lowercased() : self
    let secondString = caseInsensitive ? words.lowercased() : words

    // Trim whitespaces, split by dash, joined by whitespace, remove punctuation, split by whitespace
    let firstStringCharacters = firstString
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: "-")
      .joined(separator: " ")
      .trimmingCharacters(in: .punctuationCharacters)
      .split(separator: " ")
    let secondStringCharacters = secondString.filter { !$0.isPunctuation }
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: "-")
      .joined(separator: " ")
      .trimmingCharacters(in: .punctuationCharacters)
      .split(separator: " ")

    return secondStringCharacters.allSatisfy { secondCharacter in
      firstStringCharacters.contains(where: { $0.hasPrefix(secondCharacter)  })
    }
  }
}
