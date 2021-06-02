//
//  UserDefaults.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 02/05/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {

	static let shared = UserSettings()

	@Published var address : String {
		didSet {
			print(address)
			UserDefaults.standard.set(address, forKey: "address")
		}
	}

	@Published var apiKey : String {
		didSet {
			UserDefaults.standard.set(apiKey, forKey: "apiKey")
		}
	}
 
	@Published var sites : [String] {
		didSet {
			print(sites)
			UserDefaults.standard.set(sites, forKey: "sites")
		}
	}

	@Published var isSelfHosted : Bool {
		didSet {
			address = isSelfHosted ? "" : "https://plausible.io/api/v1/stats"
			UserDefaults.standard.set(isSelfHosted, forKey: "selfHosted")
		}
	}

	private init() {
		self.address = UserDefaults.standard.object(forKey: "address") as? String ?? "https://plausible.io/api/v1/stats"
		self.apiKey = UserDefaults.standard.object(forKey: "apiKey") as? String ?? "NULL"
		self.sites = UserDefaults.standard.object(forKey: "sites") as? [String] ?? []
		self.isSelfHosted = UserDefaults.standard.object(forKey: "selfHosted") as? Bool ?? false
	}
}
