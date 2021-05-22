//
//  VisitorView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 03/05/21.
//

import SwiftUI

struct VisitorView: View {

	@ObservedObject private var dataManager = DataManager.shared

	var body: some View {
		VStack {
			StatisticsView()
//			Spacer()
			GraphView(visitors: [0,123,678,345,784,100,606,06,0600,0606,50,900])

		}
		.frame(width: 170, height: 170)
	}
}

struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorView()
			.previewLayout(PreviewLayout.fixed(width: 170, height: 170))
    }
}

// MARK: - View Functions

extension VisitorView {

	fileprivate func StatisticsView() -> some View {
		return HStack {
			VStack {
				Text("\(dataManager.visitors)")
					.font(.system(size: 56))
					.fontWeight(.bold)
					.multilineTextAlignment(.trailing)
					.padding([.bottom],-15.0)
				HStack {
					Image(systemName: "arrow.up")
						.font(.system(size: 20))
						.padding(.trailing, -4.0)
					Text("10%")
						.font(.system(size: 20))
						.padding(.leading, -4.0)
				}
				.foregroundColor(.green)
				Spacer()
			}
			.padding(.leading,7.0)
			Spacer()
		}
	}

	fileprivate func GraphView(visitors : [Int]) -> some View {
		return GeometryReader { reader in
			GeometryReader{ geometry in
				Line(data: ChartData(points: [12.3,2.0,23.0]), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil),gradient: GradientColor(start: Color.blue, end: Color.blue))

				.offset(x: 0, y: 0)
			}
//			.offset(x: 0, y: 0)
		}
	}
}
