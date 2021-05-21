//
//  Path.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 18/05/21.
//

import SwiftUI

struct Graph: Shape {

	var data : [Int]
	@Binding var frame : CGRect
	var padding : CGFloat

	init(data : [Int], frame : Binding<CGRect>, padding:CGFloat = 30) {
		self.data = data
		self._frame = frame
		self.padding = padding
	}
	var stepWidth: CGFloat {
		if data.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(data.count-1)
	}
	var stepHeight: CGFloat {
		var min: Int?
		var max: Int?
		if let minPoint = data.min(), let maxPoint = data.max(), minPoint != maxPoint {
			min = minPoint
			max = maxPoint
		}else {
			return 0
		}
		if let min = min, let max = max, min != max {
			if (min <= 0){
				return (frame.size.height-padding) / CGFloat(max - min)
			}else{
				return (frame.size.height-padding) / CGFloat(max + min)
			}
		}

		return 0
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()
		if (data.count < 2){
			return path
		}
		guard let offset = data.min() else { return path }
		let p1 = CGPoint(x: 0, y: CGFloat(data[0]-offset)*stepHeight)
		path.move(to: p1)
		for pointIndex in 1..<data.count {
			let p2 = CGPoint(x: stepWidth * CGFloat(pointIndex), y: stepHeight*CGFloat(data[pointIndex]-offset))
			path.addLine(to: p2)
		}
		return path
	}
}
