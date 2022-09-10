//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var currentMovies : [Movie] = []
    @Published var isLoaderPresenting = false
    
    @Published var showAlert = false
    var alertMessage = String()
    
    private func handleLoader(show : Bool = false) {
        DispatchQueue.main.async {
            self.isLoaderPresenting = show
        }
    }
    
    func loadData() {
        handleLoader(show: true)
        UserEndpoints.movies(1).request { [weak self] (response : Result<MovieResponse,APIErrors>) in
            
            self?.handleLoader()
            
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.currentMovies = model.results
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.alertMessage = failure.message
                DispatchQueue.main.async {
                    self?.showAlert = true
                }
            }
        }
    }
}
