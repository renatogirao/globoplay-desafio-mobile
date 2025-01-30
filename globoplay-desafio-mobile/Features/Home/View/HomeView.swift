//
//  HomeView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.sections) { section in
                            SectionView(section: section)
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


struct SectionView: View {
    var section: MovieSection
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(section.title)
                .font(.title2)
                .fontWeight(.bold)
                .padding([.top, .leading])
                .foregroundColor(.textColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(section.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCell(movie: movie)
                                .frame(width: 120)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.4))
            .edgesIgnoringSafeArea(.all)
    }
}
