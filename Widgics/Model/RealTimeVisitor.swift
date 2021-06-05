//
//  RealTimeVisitor.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 03/06/21.
//

import SwiftUI

struct RealTimeVisitor {
	var visitors: [Int]
	var percentage : RealtimePercentage
}

struct RealtimePercentage {
	var value : Int?
	var symbol : Image
	var color : Color
}
