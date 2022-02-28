//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Alex Paz on 26/02/2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    // empty class to create coordinator that bridges UIkit and SwitUI, see related func makeCoordinator
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
         // refer to the parent struct, which is an ImagePicker
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
        
        
    }
    
    // below is the little hack to make Xcode generate the correct stubs for PHPickerViewController
    //     typealias UIViewControllerType = PHPickerViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    // this function starts the coordinator which will act as a bridge between UIkit and SwiftUI
    func makeCoordinator() -> Coordinator {
        // pass in the ImagePicker struct w/ the binding so we can modify the binding from the Coordinator instance
        Coordinator(self)
    }

}
