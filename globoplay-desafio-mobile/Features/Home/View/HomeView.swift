//
//  HomeView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = UIColor(Color.navigationBarBackground)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.textColor)]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.sections, id: \.title) { section in
                            VStack(alignment: .leading) {
                                Text(section.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                    .foregroundColor(.textColor)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(section.items, id: \.id) { movie in
                                            MovieCell(movie: movie)
                                                .frame(width: 120)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .onAppear {
                        viewModel.getNowPlaying()
                        viewModel.getPopular()
                        viewModel.getTopRated()
                        viewModel.getUpcoming()
                    }
                }
                .background(Color.appBackground)

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.4))
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Pviews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
