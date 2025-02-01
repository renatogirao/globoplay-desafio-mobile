//
//  FavoriteMovieCell.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit
import Combine
import SwiftUI

class FavoriteMovieCell: UICollectionViewCell {

    static let identifier = "FavoriteMovieCell"

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var viewModel: FavoriteMovieCellViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with movie: Movie) {
        viewModel = FavoriteMovieCellViewModel(movie: movie)
        
        viewModel.$imageData
            .sink { [weak self] data in
                if let data = data {
                    self?.posterImageView.image = UIImage(data: data)
                } else {
                    self?.posterImageView.image = UIImage(named: "placeholderImage")
                }
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func setupView() {
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
