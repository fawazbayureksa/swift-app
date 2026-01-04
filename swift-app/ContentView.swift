//
//  ContentView.swift
//  swift-app
//
//  Created by Fawwaz Bayureksa on 04/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack(spacing:20) {
            Text("\(count)").font(.largeTitle) // call variable count on text
            HStack(spacing: 20) {
                Button(action: {count-=1}){
                    Text("-")
                        .font(.largeTitle)
                        .frame(width: 60,height: 60)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                Button(action:{count+=1}){
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 60,height: 60)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
            }
            Text("App Counter!").font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
