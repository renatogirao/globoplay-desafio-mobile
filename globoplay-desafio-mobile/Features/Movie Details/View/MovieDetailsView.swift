//
//  MovieDetailsView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieId: Int
    
    var body: some View {
        Text("Movie ID: \(movieId)")
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieId: 123)
    }
}
