//
//  HomeView.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(hex: "#F6F6F6")
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                SenderView(viewModel: viewModel)
                
                Divider()
                    .background(Color.init(hex: "#999999"))
                
                ReceiverView(viewModel: viewModel)
            }
            .background(Color.init(hex: "#F6F6F6"))
            .navigationBarTitle("Bob", displayMode: .inline)
        }
    }
    
}

#Preview {
    HomeView()
}
