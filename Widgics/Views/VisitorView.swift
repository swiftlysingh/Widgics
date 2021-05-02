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
		VStack() {
			Spacer()
			HStack {
				Spacer()
				Text("\(dataManager.visitors)")
					.font(.system(size: 70))
					.fontWeight(.bold)
					.multilineTextAlignment(.trailing)
			}
			Spacer()
			HStack {
				Spacer()
				Text("Current Visitors")
					.fontWeight(.medium)
					.foregroundColor(.primary)
					.font(.headline)
			}
			HStack {
				Spacer()
				Image(systemName: "circle.fill")
					.font(.caption2)
					.foregroundColor(.green)
				Text("Updated 5mins ago")
					.font(.caption2)
					.foregroundColor(.secondary)
			}
		}
	}
}

struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorView()
			.previewLayout(PreviewLayout.fixed(width: 170, height: 170))
			.padding()
    }
}
