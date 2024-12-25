//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

class CaseViewModel: ObservableObject {
    @Published var cases: [CaseModel] = [
        CaseModel(
            title: NSLocalizedString("Murder Case", comment: "Title for the murder case"),
            hint: NSLocalizedString("Tap to choose the murder case", comment: "Hint for the murder case selection")
        ),
        CaseModel(
            title: NSLocalizedString("Disappearance Case", comment: "Title for the disappearance case"),
            hint: NSLocalizedString("Tap to choose the disappearance case", comment: "Hint for the disappearance case selection")
        ),
        CaseModel(
            title: NSLocalizedString("Theft Case", comment: "Title for the theft case"),
            hint: NSLocalizedString("Tap to choose the theft case", comment: "Hint for the theft case selection")
        )
    ]
}
