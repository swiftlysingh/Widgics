//
//  HomeView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 02/05/21.
//

import SwiftUI

struct HomeView: View {

	@ObservedObject private var userSettings = UserSettings.shared
	@State private var isAlertShown = false

	private var addButton: some View {
		AnyView(Button(action: { isAlertShown = true }) {
			Image(systemName: "plus")
		})
	}

	var body: some View {
		NavigationView {
			List {
				ForEach(userSettings.sites,id: \.self) { site in
					Section(header: Text(site)) {
						VisitorView(site: site)
							.frame(width: 170, height: 170)
							.cornerRadius(20)
							.overlay(RoundedRectangle(cornerRadius: 20)
										.stroke(Color.secondary, lineWidth: 1))
					}
				}

			}
			.navigationBarTitle("Home")
			.navigationViewStyle(StackNavigationViewStyle())
			.listStyle(GroupedListStyle())
			.navigationBarItems(trailing: addButton)
		}
		.alert(isPresented: $isAlertShown, TextAlert(title: "Add Sites", placeholder: "Enter a URL for a site", accept: "Add", cancel: "Cancel", action: onAdd ))
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}

//MARK: - Private

extension HomeView {
	private func onAdd(site: String?){
		guard let site = site else { return }
		userSettings.sites.append(site)
	}
}
