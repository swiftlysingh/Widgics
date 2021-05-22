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
			GraphView(visitors: [0,123,678,345,784,100,606,6,0600,0606,50,2000])

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

	fileprivate func GraphView(visitors : [Double]) -> some View {
		return GeometryReader { reader in
			GeometryReader{ geometry in
				Line(data: ChartData(points: visitors), frame: .constant(geometry.frame(in: .local)),color: [.red])

				.offset(x: 0, y: 0)
			}
//			.offset(x: 0, y: 0)
		}
	}
}
