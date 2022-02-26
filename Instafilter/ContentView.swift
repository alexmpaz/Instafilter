//
//  ContentView.swift
//  Instafilter
//
//  Created by Alex Paz on 25/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello, Netherlands!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            Button("Random blur") {
                blurAmount = Double.random(in: 0...20)
            }
            .onChange(of: blurAmount) { newValue in
                print("New value is \(newValue)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
