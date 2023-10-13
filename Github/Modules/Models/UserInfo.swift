//
//  UserInfo.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

struct UserInfo: Codable {
    let login: String
    let avatar_url: String
    let url: String
    let company: String
    let location: String
    let bio: String
    let public_repos: Int
}
