//
//  ContentView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 01/05/21.
//

import SwiftUI

struct SettingsView: View {

	@State var isSelfHosted : Bool = false
	@State var url : String = ""
	@State var apiKey : String = ""
	@State var isAPIKeyVisible: Bool = false

	@ObservedObject var viewModel: SettingsViewModel

	var body: some View {
		NavigationView {
			List {
				Section {
					HStack() {
						Text("Is your instance self hosted?")
						Picker(selection: $isSelfHosted, label: Text("Is your instance self hosted?"), content: {
							Text("Yes").tag(true)
							Text("No").tag(false)
						})
						.pickerStyle(SegmentedPickerStyle())
					}
					if isSelfHosted {
						TextField("Enter URL for your instance", text: $url, onCommit:  {
							/* if url != shared.url then shared.url = url*/
						})
				}
				}
				Section {
					HStack {
						SecureField("API key", text: $apiKey, onCommit:  {
							/* if apikey != shared.api then shared.api = api*/
						})
						Button(action: {
							isAPIKeyVisible.toggle()
						}, label: {
							isAPIKeyVisible ? Image(systemName: "eye") : Image(systemName: "eye.slash")
						})
						.buttonStyle(BorderlessButtonStyle())
						Link(destination: URL(string : "https://plausible.io/docs/stats-api#concepts")!){
							Image(systemName: "info.circle")
						}
					}
					if isAPIKeyVisible {
						Text(apiKey)
					}
				}
				Section(footer: footer) {
					ForEach(viewModel.footerItems, id: \.rawValue) { item in
						Button(action: { handleTapOnItem(item) }) {
							SettingsRow(item: item)
						}
					}
				}
			}
			.navigationBarTitle("Settings")
			.listStyle(GroupedListStyle())
		}
	}

	var footer: some View {
		let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
		let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
		let versionString = "version \(String(describing: version)) (\(build))"
		return Text(versionString)
			.textCase(.uppercase)
			.foregroundColor(.secondary)
			.font(.caption2)
			.multilineTextAlignment(.center)
			.frame(maxWidth: .infinity, alignment: .center)
			.listRowInsets(EdgeInsets(top: 24.0, leading: 0.0, bottom: 24.0, trailing: 0.0))
	}

}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(viewModel: SettingsViewModel())
	}
}

//MARK: - Private Functions based on https://github.com/AnderGoig/github-contributions-ios

extension SettingsView {
	private func handleTapOnItem(_ item: SettingsItem) {
		switch item {
		case .rate:
			openURL(viewModel.rateURL)
		case .share:
			present(UIActivityViewController(activityItems: [viewModel.shareURL], applicationActivities: nil), animated: true)
		case .feedback:
			openURL(viewModel.feedbackURL)
		case .openSource:
			openURL(viewModel.openSourceURL)
		}
	}
	private func openURL(_ url: URL) {
		UIApplication.shared.open(url)
	}

	private func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
		guard var topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }

		while let presentedViewController = topController.presentedViewController {
			topController = presentedViewController
		}

		topController.present(viewController, animated: animated, completion: completion)
	}

}
