//
//  LineView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 18/05/21.
//

import SwiftUI

struct Line: View {
	@ObservedObject var data: ChartData
	@Binding var frame: CGRect
	@State private var showFull: Bool = false

	var color: [Color] = [.blue]
	var minDataValue: Double = 0.0
	var maxDataValue: Double? = nil
	var index:Int = 0
	let padding:CGFloat = 30

	var stepWidth: CGFloat {
		if data.points.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(data.points.count-1)
	}
	var stepHeight: CGFloat {
		let min = minDataValue
		let max = data.onlyPoints().max()
		if let max = max, min != max {
			if (min <= 0){
				return (frame.size.height-padding) / CGFloat(max - min)
			}else{
				return (frame.size.height-padding) / CGFloat(max - min)
			}
		}
		return 0
	}
	var path: Path {
		let points = self.data.onlyPoints()
		return Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue)
	}
	var closedPath: Path {
		let points = self.data.onlyPoints()
		return Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue)
	}

	public var body: some View {
		ZStack {
			self.closedPath
				.fill(LinearGradient(gradient: Gradient(colors: color), startPoint: .bottom, endPoint: .top))
				.rotationEffect(.degrees(180), anchor: .center)
				.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
				.transition(.opacity)
				.animation(.easeIn(duration: 1.6))
			self.path
				.trim(from: 0, to: self.showFull ? 1:0)
				.stroke(LinearGradient(gradient: Gradient(colors: color), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
				.rotationEffect(.degrees(180), anchor: .center)
				.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
				.animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
				.onAppear {
					self.showFull = true
				}
				.onDisappear {
					self.showFull = false
				}
		}
	}

}

struct Line_Previews: PreviewProvider {

	static var previews: some View {
		let visitors : [Float] = [12.3,23.0,900.0,-100.0,2200]
		GeometryReader{ geometry in
			Line(data: ChartData(points: visitors), frame: .constant(geometry.frame(in: .local)))
		}.frame(width: 320, height: 160)
	}
}
