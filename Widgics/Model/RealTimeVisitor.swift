//
//  RealTimeVisitor.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 03/06/21.
//

import SwiftUI
import RealmSwift

final class RealtimeVisitor: Object,ObjectKeyIdentifiable {

	@objc dynamic var name = String()

	@objc dynamic var visitors = [Int]()

	@objc dynamic var showPercent = false

	@objc dynamic var percentValue = Int()

	@objc dynamic var percentSymbolString = "arrow.up"

//	@objc dynamic var color = Color.green

	override class func primaryKey() -> String? {
		"name"
	}

}
