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
		let sites = data.filter("name == %@","singh.com").first
		print(sites?.percentSymbolString)
	}
}
