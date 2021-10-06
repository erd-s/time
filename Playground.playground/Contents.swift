import UIKit



func hours(from seconds: TimeInterval) -> Int {
	return Int(seconds) / 3600
}

func minutes(from seconds: TimeInterval) -> Int {
	let leftovers: Int = Int(seconds) % 3600
	return leftovers / 60
}

func seconds(from seconds: TimeInterval) -> Int {
	let hourLeftovers: Int = Int(seconds) % 3600
	return hourLeftovers % 60
}

let seconds: TimeInterval = 3666
print("\(hours(from: seconds)):\(minutes(from: seconds)):\(seconds(from: seconds))")
