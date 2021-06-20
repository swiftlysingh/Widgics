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
	let realm  = try? Realm()

	var token : NotificationToken? = nil

	@Published var data = RealtimeVisitor()

	init(for site:String) {
		print(Realm.Configuration.defaultConfiguration.fileURL!)

		if let data = realm?.object(ofType: RealtimeVisitor.self, forPrimaryKey: site) {
			self.data = data
		} else {
			data = RealtimeVisitor(value: [site,[0]])
			try? realm?.write({
				realm?.add(data)
			})
		}

		token = data.observe { [unowned self] changes in
			switch changes {
			case .error(_): break
			case.change(_, _): self.objectWillChange.send()
			case .deleted: break
			}
		}
	}

	func getNewData(){
		dataManager.updateRealtimeVisitors(for: data.name) { visitors in

			let newVisitors = try! JSONDecoder().decode(Int.self, from: visitors)

			let latestVisitor = self.data.visitors.last!
			self.data.visitors.append(newVisitors)

			if latestVisitor == 0 {
				self.data.showPercent = false
			} else {
				self.data.percentValue = ((newVisitors - latestVisitor)/latestVisitor*100)
				//TODO: Add color option here
				if self.data.percentValue > 0 {
					self.data.percentSymbolString = "arrow.up"
				} else {
					self.data.percentSymbolString = "arrow.down"
				}
			}

			try? self.realm?.write({
				self.realm?.add(self.data)
			})
		}
	}

	func updateTest() {
		print("Updating LALALALA")
		try? self.realm?.write({
			self.data.visitors.append(101)
		})
	}
}
