//
//  Repos.swift
//  Github
//
//  Created by Matheus Prada on 23/10/23.
//

import Foundation

struct Repos: Codable, Equatable {
    let name: String
    let html_url: String
    let description: String?
    let language: String?
    let updated_at: String?
}
