//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

class CaseViewModel: ObservableObject {
    @Published var cases: [CaseModel] = [
        CaseModel(title: "Murder Case", hint: "Tap to choose the murder case"),
        CaseModel(title: "Disappearance Case", hint: "Tap to choose the disappearance case"),
        CaseModel(title: "Theft Case", hint: "Tap to choose the theft case")
    ]
}
