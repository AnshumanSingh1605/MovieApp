//
//  BaseView.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import SwiftUI

// Creating BaseView with common/reusable UI components....
struct BaseView<Content : View> : View {
    
    @Binding var isAPICallActive : Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isAPICallActive)
                    .blur(radius: self.isAPICallActive ? 3 : 0)
                
                VStack {
                    ProgressView()
                    Text("Please wait...")
                        .foregroundColor(.primary)
                }
                .frame(width: geo.size.width / 2,
                       height: geo.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isAPICallActive ? 1 : 0)
                
                //Bottom floater View
                ZStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                debugPrint("Filter button pressed")
                            } label: {
                                Image(systemName: "f.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .foregroundColor(.blue)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            .padding([.trailing,.bottom])
                        }
                    }
                }
            }
        }
    }
}

extension View {
    public func showAlert(show : Binding<Bool>,message : String?, action : @escaping () -> Void) -> some View {
        return alert(isPresented: Binding(projectedValue: show)) {
            Alert(title: Text("Warning"), message: Text(message ?? "NA"), dismissButton: .default(Text("OK"), action: action))
        }
    }
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}
