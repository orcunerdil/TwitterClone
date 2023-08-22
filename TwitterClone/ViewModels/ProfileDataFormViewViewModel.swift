//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 22.08.2023.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel : ObservableObject {
    
    @Published var displayName :String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    
}

