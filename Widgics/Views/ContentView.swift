//
//  ContentView.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 02/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			HomeView()
				.tabItem {
					Image(systemName: "house.fill")
					Text("Home")
				}
			SettingsView(viewModel: .init())
				.tabItem {
					Image(systemName: "gearshape.fill")
					Text("Settingss")
				}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
