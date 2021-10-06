//
//  UserDefaults+Extension.swift
//  Time
//
//  Created by Christopher Erdos on 10/5/21.
//

import Foundation
import WidgetKit

extension UserDefaults {
	var kDate: String { "kDate" }
	private static let formatter: ISO8601DateFormatter = ISO8601DateFormatter()
	static let mine = UserDefaults(suiteName: "group.com.erdos.Time")!
	
	func getTime() -> Date? {
		guard let dateString = self.string(forKey: self.kDate) else {
			return nil
		}
		return UserDefaults.formatter.date(from: dateString)
	}
	
	func saveTime(date: Date) {
		let dateString = UserDefaults.formatter.string(from: date)
		self.set(dateString, forKey: self.kDate)
		WidgetCenter.shared.reloadAllTimelines()
	}
}
