//
//  Helper.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI

class VisitorsModel: ObservableObject {

	static let shared = VisitorsModel()
	
	@Published var views : [Int] {
		didSet {
			UserDefaults.standard.set(views, forKey: "visitorViewData")
		}
	}

	private init() {
		self.views = UserDefaults.standard.object(forKey: "visitorViewData") as? [Int] ?? [0]
	}
}
