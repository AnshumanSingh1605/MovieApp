//
//  MovieView.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import SwiftUI

struct MovieView: View {
    
    @State var movie : Movie
    @State var isSelected : Bool = false
    var didStarSelected : (Movie,Bool) -> Void = { _,_  in }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment : .leading,spacing : 0) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + movie.backdropPath)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: geo.size.width, height: 300)
                            .offset(x: 0, y: 0)
                    case .failure(let error):
                        let _ = print(error)
                        Text("error: \(error.localizedDescription)")
                    case .empty:
                        ZStack {
                            Color.white
                            VStack {
                                ProgressView()
                            }
                        }
                    @unknown default:
                        fatalError()
                    }
                }
                ZStack {
                    Color.gray
                    HStack {
                        VStack(alignment: .leading,spacing: 10) {
                            Text(movie.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                            
                            
                            Text(String(format: "Rating: %.1f", movie.voteAverage))
                                .foregroundColor(.primary)
                                .font(.body)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: isSelected ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(isSelected ? .yellow : .white)
                                .onTapGesture {
                                    self.isSelected.toggle()
                                    didStarSelected(movie,isSelected)
                                }
                        }
                        .padding(.horizontal)
                    }
                    .frame(width: geo.size.width,height: 100)
                    .layoutPriority(100)
                }
            }
        }
    }
}


