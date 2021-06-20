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
			data = RealtimeVisitor(value: [site,[0,30,20,68,58,100]])
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
							if self.data.percentValue > 0 {
								self.data.percentSymbolString = "arrow.up"
								self.data.color = "3BC452"
							} else {
								self.data.percentSymbolString = "arrow.down"
								self.data.color = "FA2B2D"
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
}
