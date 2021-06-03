//
//  RealTimeVisitor.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 03/06/21.
//

import SwiftUI

struct RealTimeVisitor: Codable {
	var visitors: [Int]
	var percentage : RealtimePercentage
}

struct RealtimePercentage : Codable {
	var value : Int?
//	let symbol : Image
//	let color : Color
}
