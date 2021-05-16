//
//  SettingsItem.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 02/05/21.
//

import SwiftUI

struct SettingsRow: View {

	let item: SettingsItem

	var body: some View {
		HStack(alignment: .center, spacing: 16.0) {
			Image(systemName: item.systemImageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 17.0, height: 17.0)
				.padding(6.0)
				.background(item.color)
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))

			VStack(alignment: .leading, spacing: 3.0) {
				Text(item.title)
					.font(.body)
					.foregroundColor(.primary)
					.lineLimit(1)

				Text(item.subtitle)
					.font(.footnote)
					.foregroundColor(.secondary)
					.lineLimit(1)
			}
		}
		.padding(.vertical, 5.0)
	}

}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
		SettingsRow(item: .feedback)
    }
}

enum SettingsItem: Int {

	case rate, share, feedback

	var title: LocalizedStringKey {
		switch self {
		case .rate: return "Rate the App"
		case .share: return "Share"
		case .feedback: return "Feedback"
		}
	}

	var subtitle: LocalizedStringKey {
		switch self {
		case .rate: return "Are you loving it?"
		case .share: return "Spread the word!"
		case .feedback: return "pushpinderpal19@gmail.com"
		}
	}

	var systemImageName: String {
		switch self {		case .rate: return "star.fill"
		case .share: return "square.and.arrow.up"
		case .feedback: return "at"
		}
	}

	var color: Color {
		switch self {
		case .rate: return .pink
		case .share: return .green
		case .feedback: return .blue		}
	}

}
