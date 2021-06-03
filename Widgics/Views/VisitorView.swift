//
//  VisitorView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 03/05/21.
//

import SwiftUI

struct VisitorView: View {

	@ObservedObject private var viewModel = VisitorsViewModel.shared
	let site: String

	var body: some View {
		VStack {
			StatisticsView()
			GraphView()
		}
		.onAppear(perform: {
			viewModel.getNewData(for: site)
		})
	}
}

struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
		VisitorView(site: "swiftlysingh.com")
			.previewLayout(PreviewLayout.fixed(width: 170, height: 170))
    }
}

// MARK: - View Functions

extension VisitorView {

	fileprivate func StatisticsView() -> some View {
		return HStack {
			VStack {
				Text("\(viewModel.data[site]!.visitors.last!)" as String)
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

	fileprivate func GraphView() -> some View {
		return GeometryReader { reader in
			GeometryReader{ geometry in
				ZStack {
					Line(frame: .constant(geometry.frame(in: .local)),site: site, color: [Color.init(red: 0.380, green: 0.44, blue: 0.9, opacity: 0.5)])
						.offset(x: 0, y: -10)
					Line(frame: .constant(geometry.frame(in: .local)),site: site, color: [Color.init(red: 0.380, green: 0.44, blue: 0.9)])
						.offset(x: 0, y: 0)
				}
			}
		}
	}
}
