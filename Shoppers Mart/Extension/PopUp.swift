//
//  PopUp.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import Foundation
import SwiftUI

extension View {
    // MARK: - Camera & Gallary image selection PopUp
    func mediaSelectionView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping ()-> Content) -> some View {
        
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                
                if show.wrappedValue {
                    
                    // MARK: - Geometry Reader for reading Container Frame
                    GeometryReader { proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        
                        NavigationView {
                            content()
                        }
                        .frame(width: 300, height: 150, alignment: .center)
                        // Corner Radius
                        .cornerRadius(5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
