//
//  SelectImagesView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 12/04/24.
//

//
//  AddPostView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 13/03/24.
//

import SwiftUI
import Photos

struct SelectImagesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var assets: [PHAsset] = []
    @State private var images: [UIImage] = []
    
    @State private var selectedImageIndex: Int? = nil
    @State private var selectedImage: UIImage? = nil
    @State var shouldShowImagesScreen = true
    
    let screenWidth = UIScreen.main.bounds.width
    let numberOfColumns: CGFloat = 4
    let spacing: CGFloat = 1
    let itemWidth: CGFloat
    
    init() {
        let totalSpacing = (numberOfColumns - 1) * spacing
        self.itemWidth = (screenWidth - totalSpacing) / numberOfColumns
    }
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 1){
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                }
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: Int(numberOfColumns)), spacing: spacing) {
                        ForEach(assets.indices, id: \.self) { index in
                            Button {
                                selectedImageIndex = index
                                loadHighResolutionImage(for: assets[index])
                            } label: {
                                Image(uiImage: images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: itemWidth, height: itemWidth)
                                    .clipped()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }.foregroundStyle(.black)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SharePostView(), label: {
                        Text("Next").foregroundStyle(.black)
                    })
                }
            }
        }.onAppear {
            fetchPhotos()
        }
    }
    
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        if self.selectedImage == nil {
                            self.loadHighResolutionImage(for: asset)
                        }
                    }
                }
            }
        }
    }
    
    func loadHighResolutionImage(for asset: PHAsset) {
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 600, height: 600)
        let requestOptions = PHImageRequestOptions()
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
            if let image = image {
                DispatchQueue.main.async {
                    selectedImage = image
                }
            }
        }
    }
}



#Preview {
    SelectImagesView()
}
