//
//  Image.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import Foundation
import SwiftUI


// Chat image View Model
class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: ImgPicker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: ImgPicker.CameraErrorType?
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try ImgPicker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = ImgPicker.CameraErrorType(error: error as! ImgPicker.PickerError)
        }
    }
}
