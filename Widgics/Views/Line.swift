//
//  LineView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 18/05/21.
//

import SwiftUI

struct Line: View {

	@Binding var frame: CGRect
	@State private var showFull: Bool = false

	var visitors: [Int]
	var color: [Color] = [.blue]
	var minDataValue: Int = 0
	var maxDataValue: Int? = nil
	var index:Int = 0
	let padding:CGFloat = 30

	var stepWidth: CGFloat {
		if visitors.count < 2 {
			return 0
		}
		return frame.size.width / CGFloat(visitors.count-1)
	}
	var stepHeight: CGFloat {
		let min = minDataValue
		let max = visitors.max()
		if let max = max, min != max {
			if (min <= 0){
				return (frame.size.height-padding) / CGFloat(max - min)
			}else{
				return (frame.size.height-padding) / CGFloat(max - min)
			}
		}
		return 0
	}
	var closedPath: Path {
		let points = visitors
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
		}
	}

}

struct Line_Previews: PreviewProvider {

	static var previews: some View {
		GeometryReader{ geometry in
			Line(frame: .constant(geometry.frame(in: .local)), visitors: [0,56,7])
		}.frame(width: 320, height: 160)
	}
}
