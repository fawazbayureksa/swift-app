//
//  ContentView.swift
//  swift-app
//
//  Created by Fawwaz Bayureksa on 04/01/26.
//

import SwiftUI
import PhotosUI
import UIKit
#if canImport(UIKit)
#endif

struct ContentView: View {
    @State private var count: Int = 0
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [Image] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Counter Section
                Text("\(count)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 20) {
                    Button(action: { count -= 1 }) {
                        Text("-")
                            .font(.largeTitle)
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { count += 1 }) {
                        Text("+")
                            .font(.largeTitle)
                            .frame(width: 60, height: 60)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                    }
                }
                
                Text("App Counter!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Divider()
                    .padding(.vertical)
                
                // MARK: - Photo Picker Section
                if selectedImages.isEmpty {
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundStyle(.tint)
                        .padding()
                } else {
                    TabView {
                        ForEach(0..<selectedImages.count, id: \.self) { index in
                            selectedImages[index]
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(12)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 300)
                }
                
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Label("Select Photos from Gallery", systemImage: "photo.stack")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .onChange(of: selectedItems) {
                        Task {
                            var loadedImages: [Image] = []
                            for item in selectedItems {
                                if let data = try? await item.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    loadedImages.append(Image(uiImage: uiImage))
                                }
                            }
                            selectedImages = loadedImages
                        }
                    }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
