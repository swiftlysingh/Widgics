//
//  Helper.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI

class VisitorsViewModel: ObservableObject {

	let dataManager = DataManager.shared
	
	@Published var data: [String : RealTimeVisitor] = [String:RealTimeVisitor]() {
		didSet {
			let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
			UserDefaults.standard.set(encodedData, forKey: "visitorViewData")
		}
	}

	func getNewData(for site: String){
		let startingViewers = data[site]?.visitors.last

		dataManager.updateRealtimeVisitors(for: site) { data in
			guard let endingViewers = try? JSONDecoder().decode(Int.self, from: data) else {return}

			self.data[site]?.visitors.append(endingViewers)
			if startingViewers == nil || startingViewers == 0 {
				self.data[site]?.percentage.value = nil
			} else {
				self.data[site]?.percentage.value = ((endingViewers - startingViewers!)/startingViewers!)*100

				if (self.data[site]?.percentage.value)! >= 0 {
					self.data[site]?.percentage.color = Color.green
					self.data[site]?.percentage.symbol = Image(systemName: "arrow.up")
				} else {
					self.data[site]?.percentage.color = Color.red
					self.data[site]?.percentage.symbol = Image(systemName: "arrow.down")
				}
			}
		}
	}
}
