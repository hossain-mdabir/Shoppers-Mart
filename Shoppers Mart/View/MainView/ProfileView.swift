//
//  ProfileView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - PROPERTIES
    
    @State private var isEdit: Bool = false
    @State private var name: String = ""
    @State private var email: String = ""
    
    // Profile Image
    @EnvironmentObject var profileImage: ImageViewModel
    @State var isShowMedia: Bool = false
    
    // MARK: - BODY

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Button {
                    isShowMedia = true
                } label: {
                    VStack {
                        if let image = profileImage.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 143, height: 143)
                                .cornerRadius(80)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
                                .padding()
                                .foregroundColor(Color(.label))
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 80)
                        .stroke(Color.black, lineWidth: 3)
                    )
                }
                
                VStack(spacing: 20) {
                    if isEdit {
                        TextField("Enter Name", text: $name)
                        TextField("Enter e-mail", text: $email)
                        
                        Button {
                            isEdit.toggle()
                        } label: {
                            Text("Save")
                                .padding()
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .background(Color("Background"))
                                .cornerRadius(15)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                    } else {
                        Text("Name: ") +
                        Text(name)
                            .foregroundColor(Color.gray)
                        
                        Text("E-mail: ") +
                        Text(email)
                            .foregroundColor(Color.gray)
                    }
                }
//                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .onAppear(perform: {
                
            })
            
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdit.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            })
            
            // ChatImage Picker PopUp
            .fullScreenCover(isPresented: $profileImage.showPicker, onDismiss: nil) { // Whee 8nser focke
                ImagePicker(sourceType: profileImage.source == .library ? .photoLibrary : .camera, selectedImage: $profileImage.image)
                    .ignoresSafeArea()
            }
            
            // Chat image Error Warning
            .alert("Camera Permission Needed", isPresented: $profileImage.showCameraAlert, presenting: profileImage.cameraError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
            //MARK: - Camera & Gallary PopUp View
            .mediaSelectionView(horizontalPadding: 40, show: $isShowMedia) {
                
                // MARK: - Your PopUp Content which will also perform navigations
                VStack(alignment: .leading) {
                    VStack {
                        Text("Choose")
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .bold, design: .default))
                    }
                    .padding(20)
                    
                    HStack(alignment: .center) {
                        // Camera Selection from PopUp
                        Button(action: {
                            profileImage.source = .camera
                            profileImage.showPhotoPicker()
                            
                            withAnimation {self.isShowMedia = false}
                        }, label: {
                            Image(systemName: "camera.shutter.button.fill")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        })
                        
                        // Gallary Selection from PopUp
                        Button(action: {
                            profileImage.source = .library
                            profileImage.showPhotoPicker()
                            
                            withAnimation {self.isShowMedia = false}
                        }, label: {
                            Image(systemName: "photo.tv")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        })
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isShowMedia = false
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(Color.black)
                        })
                        .padding(20)
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
