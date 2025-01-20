//
//  MainView.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 19/01/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem.init(.adaptive(minimum: 80, maximum: 100))]) {
                    ForEach(vm.images, id: \.self) { nsimage in
                        Image(nsImage: nsimage)
                            .resizable()
                            .scaledToFit()
                            .draggable(nsimage)
                            .frame(maxHeight: 130)
                    }
                }
                .id(vm.images.count)
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                ScreenshotButton(symbol: "viewfinder.rectangular", title: "") {
                    vm.takeScreenShot(type: .area)
                }
                
                ScreenshotButton(symbol: "macwindow", title: "") {
                    vm.takeScreenShot(type: .window)
                }
                
                ScreenshotButton(symbol: "macbook.gen2", title: "") {
                    vm.takeScreenShot(type: .full)
                }
                
                Spacer()
                
                
                SettingsLink {
                    Image(systemName: "gear")
                }
                
                ScreenshotButton(symbol: "trash.fill", title: "") {
                    vm.images = []
                }
            }

        }
        .navigationTitle("Screenshots")
        .padding()
    }
}

#Preview {
    MainView()
}






extension MainView {
    @ViewBuilder private func ScreenshotButton(symbol: String, title: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: symbol)
                    .font(.body)
                
//                Text(title)
//                    .font(.body)
//                    .padding(5)
            }
        }
    }
}
