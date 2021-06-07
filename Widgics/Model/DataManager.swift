//
//  DataManager.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 01/05/21.
//

import SwiftUI

struct DataManager{

	@ObservedObject private var userSettings = UserSettings.shared

	static let shared = DataManager()

	private init() { }

	func updateRealtimeVisitors(for site : String, completionHandler: @escaping (_ : Data) -> Void){
		let url = URL(string: "\(userSettings.address)/realtime/visitors?site_id=\(site)")

		callAPI(url: url!){ result in
			switch result {
			case .failure(let error) : print("Fetching realtime viewers failed with error \(error)")
			case .success(let data) : completionHandler(data)
			}
		}

	}

	private func callAPI(url : URL, completion: @escaping (Result<Data,Error>) -> Void) {
		let session = URLSession(configuration: .default)
		var request = URLRequest(url: url)
		request.setValue("Bearer iMYIspVD7eFowdNu3yGu8ScOUOuDvFWKGG2BSdirebKXAXeiwtEk_wezccQdQ7WN", forHTTPHeaderField: "Authorization")

		session.dataTask(with: request) { data, response, error in
			guard let data = data,(error == nil) else {
				completion(.failure(error!))
				return
			}

			completion(.success(data))
		}.resume()
	}
}
