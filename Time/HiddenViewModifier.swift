//
//  SwiftUIView.swift
//  Time
//
//  Created by Christopher Erdos on 10/6/21.
//

import SwiftUI

extension View {
	func hidden(_ binding: Binding<Bool>) -> some View {
		return self.modifier(HiddenViewModifier(isHidden: binding))
	}
}

struct HiddenViewModifier: ViewModifier {
	@Binding var isHidden: Bool
	
	func body(content: Content) -> some View {
		if self.isHidden  {
			
		} else {
			content
		}
	}
}
