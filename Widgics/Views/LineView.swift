//
//  LineView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 18/05/21.
//

import SwiftUI

struct Line: View {
	var data: [(Int)]
	@Binding var frame: CGRect

	let padding:CGFloat = 30

	var stepWidth: CGFloat {
		if data.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(data.count-1)
	}
	var stepHeight: CGFloat {
		var min: Int?
		var max: Int?
		let points = self.data
		if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
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
	var path: Path {
		let points = self.data
		return Path.lineChart(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
	}

	public var body: some View {

		ZStack {
			Path { path in
				Path.lineChart(points: self.data, step: CGPoint(x: stepWidth, y: stepHeight))
			}
			self.path
				.stroke(Color.blue ,style: StrokeStyle(lineWidth: 5, lineCap: .round,lineJoin: .round))
				.rotationEffect(.degrees(180), anchor: .center)
				.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
				.drawingGroup()
		}
	}
}
