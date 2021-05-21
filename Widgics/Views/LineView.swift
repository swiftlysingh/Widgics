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

	public var body: some View {

		ZStack {

			Graph(data: data, frame: $frame)
				.stroke(Color.blue ,style: StrokeStyle(lineWidth: 5, lineCap: .round,lineJoin: .round))
				.rotationEffect(.degrees(180), anchor: .center)
				.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
				.drawingGroup()
		}
	}
}
