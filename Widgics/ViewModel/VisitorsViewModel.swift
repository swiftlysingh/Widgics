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
		let latestVisitor = self.data.visitors.last!

		dataManager.updateRealtimeVisitors(for: data.name) { data in
			if let currentVisitor = try? JSONDecoder().decode(Int.self, from: data) {
				DispatchQueue.main.async {
					try! self.realm?.write({

						self.data.visitors.append(currentVisitor)
						if latestVisitor == 0 {
							self.data.showPercent = false
						} else {
							self.data.showPercent = true
							self.data.percentValue = ((currentVisitor - latestVisitor)/latestVisitor*100)
							//TODO: Add color option here
							if self.data.percentValue > 0 {
								self.data.percentSymbolString = "arrow.up"
							} else {
								self.data.percentSymbolString = "arrow.down"
							}
						}

					})
				}
			} else {
				//Handle Error
				print("Error Decoding")
			}
		}

	}

	func updateTest() {
		print("Updating LALALALA")
		try? self.realm?.write({
			self.data.visitors.append(101)
		})
	}
}
