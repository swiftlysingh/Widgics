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

	let site = String()

	@ObservedResults(RealtimeVisitor.self) var data

	private init() {
//		let realm = try Realm()
//		let data = realm.object(ofType: RealtimeVisitor.self, forPrimaryKey: "swift")
	}

	func getNewData(for site: String){
		let sites = data.filter("name == swiftlysingh.com").first
		print(sites?.percentSymbolString)
	}
}
