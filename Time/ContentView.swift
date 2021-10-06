//
//  ContentView.swift
//  Time
//
//  Created by Christopher Erdos on 10/5/21.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var timeContainer: TimeContainer = TimeContainer()
	@State var startTime: Date = Date()
	@State var hideSetTime: Bool = UserDefaults.mine.getTime() != nil
	
    var body: some View {
		VStack(spacing: 60) {
			Text(self.timeContainer.time)
				.font(Font.system(size: 40))
			Divider()
				.padding(.horizontal, 30)
				.hidden(self.$hideSetTime)
			VStack(spacing: 20) {
				DatePicker("Date:", selection: self.$startTime)
				Button {
					self.timeContainer.startTime = self.startTime
					UserDefaults.mine.saveTime(date: self.startTime)
					self.timeContainer.startTimer()
				} label: {
					Text("Update")
				}
				.frame(maxWidth: .infinity, maxHeight: 44)
				.foregroundColor(Color.white)
				.background(Color.accentColor)
				.cornerRadius(10)
			}.hidden(self.$hideSetTime)
		}
		.ignoresSafeArea()
		.animation(.default)
		.padding(.horizontal, 40)
		.onAppear {
			if let startTime = UserDefaults.mine.getTime() {
				self.startTime = startTime
			}
			self.timeContainer.setTime()
			self.timeContainer.startTimer()
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					self.hideSetTime.toggle()
				} label: {
					Image(systemName: self.hideSetTime ? "calendar.circle" : "calendar.circle.fill")
						.animation(.default)
				}
			}
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					self.timeContainer.startTime = Date()
					UserDefaults.mine.saveTime(date: self.timeContainer.startTime)
					self.timeContainer.startTimer()
				} label: {
					Image(systemName: "clock.arrow.circlepath")
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			ContentView()
		}
    }
}
