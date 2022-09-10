//
//  HomeView.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            BaseView(isAPICallActive: $viewModel.isLoaderPresenting) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.currentMovies,id: \.id) { movie in
                            MovieView(movie: movie)
                                .frame(height: 400)
                        }
                    }
                }
            }
            .navigationTitle("Movies")
            .onAppear() {
                viewModel.loadData()
            }
            .showAlert(show: $viewModel.showAlert, message: viewModel.alertMessage) {
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
