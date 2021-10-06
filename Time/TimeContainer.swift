//
//  TimeContainer.swift
//  Time
//
//  Created by Christopher Erdos on 10/6/21.
//

import Foundation
import SwiftUI

class TimeContainer: ObservableObject {
	@Published var time: String = """
		0 years,
		0 months,
		0 days,
		0 hours,
		0 minutes,
		0 seconds
		"""
	var startTime: Date = UserDefaults.mine.getTime() ?? Date() {
		didSet {
			self.setTime()
		}
	}
	private var timer: Timer?
	
	func startTimer() {
		let hasSetTimer = UserDefaults.mine.getTime() != nil
		guard hasSetTimer else {
			return
		}
		self.timer?.invalidate()
		self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
			self.setTime()
		}
	}

	func setTime() {
		let calendar = Calendar.autoupdatingCurrent
		let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
												 from: self.startTime,
												 to: Date())
		self.time =
		"""
		\(components.year!) years,
		\(components.month!) months,
		\(components.day!) days,
		\(components.hour!) hours,
		\(components.minute!) minutes,
		\(components.second!) seconds
		"""
	}
}

