//
//  Helper.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI
import RealmSwift

class VisitorsViewModel: ObservableObject {

	let dataManager = DataManager.shared
	let site: String

	var realtimeVisitor : RealtimeVisitor {
		return  self.data.filter("name == %@",site).first!
	}

	@ObservedResults(RealtimeVisitor.self) var data


	init(for site:String) {
		self.site = site
	}

	func getNewData(){
		dataManager.updateRealtimeVisitors(for: site) { visitors in

			let newVisitors = try! JSONDecoder().decode(Int.self, from: visitors)

			let latestVisitor = self.realtimeVisitor.visitors.last!
			self.realtimeVisitor.visitors.append(newVisitors)

			if latestVisitor == 0 {
				self.realtimeVisitor.showPercent = false
			} else {
				self.realtimeVisitor.percentValue = ((newVisitors - latestVisitor)/latestVisitor*100)

				if self.realtimeVisitor.percentValue > 0 {
					self.realtimeVisitor.percentSymbolString = "arrow.up"
				} else {
					self.realtimeVisitor.percentSymbolString = "arrow.down"
				}
			}

			let realm = try!   Realm()

			try! realm.write({
				realm.add(self.realtimeVisitor)
			})
		}
	}
}
