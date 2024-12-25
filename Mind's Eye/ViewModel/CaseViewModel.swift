//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//


import SwiftUI

class CaseViewModel: ObservableObject {
    @Published var cases: [CaseModel] = [
        CaseModel(title: "قضية قتل", hint: "اضغط لاختيار قضية القتل"),
        CaseModel(title: "قضية إختفاء", hint: "اضغط لاختيار قضية الإختفاء"),
        CaseModel(title: "قضية سرقة", hint: "اضغط لاختيار قضية السرقة")
    ]
}
