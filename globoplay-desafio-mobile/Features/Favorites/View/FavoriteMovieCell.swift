//
//  FavoriteMovieCell.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func configure(with movie: Movie) {
        if let posterPath = movie.posterPath, let posterURL = URL(string: posterPath) {
            posterImageView.loadImage(from: posterURL)
        } else {
            posterImageView.image = UIImage(named: "placeholderImage")
        }
    }
}
