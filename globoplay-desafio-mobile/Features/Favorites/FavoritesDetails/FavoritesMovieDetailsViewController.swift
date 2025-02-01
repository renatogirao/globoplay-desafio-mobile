//
//  FavoritesMovieDetailsViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit

class FavoritesMovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: FavoritesMovieDetailsViewModel
    private var customView: FavoritesMovieDetailsView!
    
    // MARK: - Initializer
    init(movie: Movie) {
        self.viewModel = FavoritesMovieDetailsViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        customView = FavoritesMovieDetailsView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.fetchMovieDetails()
    }
    
    // MARK: - Setup Bindings
    private func setupBindings() {
        viewModel.loadingPublisher
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.customView.startLoading()
                } else {
                    self?.customView.stopLoading()
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.movieDetailsPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Erro ao carregar detalhes: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] details in
                if let details = details {
                    self?.customView.updateUI(with: details)
                } else {
                    print("Detalhes do filme não encontrados.")
                }
            })
            .store(in: &viewModel.cancellables)
    }
}
