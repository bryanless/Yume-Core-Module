//
//  StringExtTests.swift
//  
//
//  Created by Bryan on 04/02/23.
//

import XCTest
@testable import Core

final class StringExtTests: XCTestCase {

  func testFormatStringDateToDate() {
    XCTAssertEqual(try formatDate(stringDate: "2023-01", dateFormatComponents: [.monthFull, .yearFull]), "January 2023")
    XCTAssertEqual(try formatDate(stringDate: "2023-04", dateFormatComponents: [.monthFull, .yearFull]), "April 2023")
  }

  func testFormatYearMonthStringDateToYearMonthDate() {
    XCTAssertEqual("2023-01".apiShortStringDateToYearMonthStringDate(), "January 2023")
    XCTAssertEqual("2023-04".apiShortStringDateToYearMonthStringDate(locale: Locale(identifier: "en_us")), "April 2023")
    XCTAssertEqual("2023-04".apiShortStringDateToYearMonthStringDate(locale: Locale(identifier: "id")), "April 2023")
  }

  func testFormatFullStringDateToFullDate() {
    XCTAssertEqual("2023-01-01".apiFullStringDateToFullStringDate(), "1 January 2023")
    XCTAssertEqual("2023-04-21".apiFullStringDateToFullStringDate(locale: Locale(identifier: "en_us")), "April 21, 2023")
    XCTAssertEqual("2023-04-21".apiFullStringDateToFullStringDate(locale: Locale(identifier: "id")), "21 April 2023")
  }

  func formatDate(stringDate: String, dateFormatComponents: [Date.DateFormatComponents]) throws -> String {
    guard let date = stringDate.apiStringDateToDate()?.format(with: dateFormatComponents) else {
      throw FormatDateError.invalidInput
    }

    return date
  }

}

enum FormatDateError: Error {
  case invalidInput
}
