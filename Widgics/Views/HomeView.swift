//
//  HomeView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 02/05/21.
//

import SwiftUI

struct HomeView: View {

	@State private var isAlertShown = false

	private var addButton: some View {
		AnyView(Button(action: { isAlertShown = true }) {
			Image(systemName: "plus")
		})
	}

	var body: some View {
		NavigationView {
			List {
				
			}
			.navigationBarTitle("Home")
			.navigationViewStyle(StackNavigationViewStyle())
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
	private func onAdd(username: String?){
		guard let username = username else { return }
		// Add site into Singleton.
	}
}
