//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

class MindEyeViewModel: ObservableObject {

    @Published var title: String = "MindEye"
    @Published var subtitle: String = "Every voice holds a secret, Every  \n guide leads a step"
    @Published var buttonText: String = "Next"

  
    @Published var isNextViewActive: Bool = false

    func navigateToNext() {
        isNextViewActive = true
    }
}
