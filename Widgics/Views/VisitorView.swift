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
	HStack {
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
			Spacer()
		}
	.frame(width: 170, height: 170)
	}
}
struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorView()
			.previewLayout(PreviewLayout.fixed(width: 170, height: 170))
			.padding()
    }
}
