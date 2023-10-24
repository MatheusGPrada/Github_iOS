//
//  Settings.swift
//  Github
//
//  Created by Matheus Prada on 19/10/23.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    
    init(title: String, handler: (() -> Void)? = nil) {
        self.title = title
        self.handler = handler
    }
    
    let title: String
    let handler: (() -> Void)?
}
