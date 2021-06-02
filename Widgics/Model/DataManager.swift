//
//  DataManager.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 01/05/21.
//

import SwiftUI

class DataManager: ObservableObject{

	@ObservedObject private var userSettings = UserSettings.shared
	@ObservedObject private var visitorViews = VisitorsModel.shared

	static let shared = DataManager()

	private init() { }

	func updateData<T>(for data: T) {
		let session = URLSession(configuration: .default)
		let url = URL(string: ("https://analytics.swiftlysingh.com/api/v1/stats/realtime/visitors?site_id=swiftlysingh.com"))
		var request = URLRequest(url: url!)
		request.setValue("Bearer iMYIspVD7eFowdNu3yGu8ScOUOuDvFWKGG2BSdirebKXAXeiwtEk_wezccQdQ7WN", forHTTPHeaderField: "Authorization")

		session.dataTask(with: request) { data,response, error in
			guard let data = data,(error == nil) else {return}

			guard let decodeData = try? JSONDecoder().decode(Int.self, from: data) else {return}

			DispatchQueue.main.async {
				self.visitorViews.views.append(decodeData)
			}
		}.resume()
	}
}
