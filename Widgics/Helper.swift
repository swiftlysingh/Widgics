//
//  Helper.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI

public class ChartData: ObservableObject, Identifiable {
	@Published var points: [(String,Double)]
	var valuesGiven: Bool = false
	var ID = UUID()

	public init<N: BinaryFloatingPoint>(points:[N]) {
		self.points = points.map{("", Double($0))}
	}
	
	public func onlyPoints() -> [Double] {
		return self.points.map{ $0.1 }
	}
}
