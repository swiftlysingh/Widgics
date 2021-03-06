//
//  SettingsViewModel.swift
//  GitHubContributions
//
//  Created by Ander Goig on 20/10/2020.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {

    @Published private(set) var footerItems: [SettingsItem] = [.rate, .share, .feedback]

	@Published var isAPIKeyVisible: Bool = false

    var rateURL: URL {
        URL(string: "itms-apps://apps.apple.com/app/id1537192731?action=write-review")!
    }

    var shareURL: URL {
        URL(string: "https://apps.apple.com/app/")!
    }

    var feedbackURL: URL {
        URL(string: "mailto:puspinderpal19@gmail.com")!
    }

    var openSourceURL: URL {
        URL(string: "https://github.com/AnderGoig/github-contributions-ios")!
    }

}
