//
//  Path.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI

extension Path {

	static func quadClosedCurvedPathWithPoints(points:[Int], step:CGPoint, globalOffset: Int? = nil) -> Path {
		var path = Path()
		if (points.count < 2){
			return path
		}
		let offset = globalOffset ?? points.min()!

		path.move(to: .zero)
		var p1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
		path.addLine(to: p1)
		for pointIndex in 1..<points.count {
			let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset) + 20.0)
			let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
			path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
			path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
			p1 = p2
		}
		path.addLine(to: CGPoint(x: p1.x, y: 0))
		path.closeSubpath()
		return path
	}
}
