//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

class MindEyeViewModel: ObservableObject {

    @Published var title: String = "عين العقل"
    @Published var subtitle: String = "كلُ صوتٍ سرْ، كلُ دليلٍ خُطوةْ"
    @Published var buttonText: String = "التالي"

  
    @Published var isNextViewActive: Bool = false

    func navigateToNext() {
        isNextViewActive = true
    }
}
