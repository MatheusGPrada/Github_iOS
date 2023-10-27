//
//  UserInfo.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

struct UserInfo: Codable {
    let avatar_url: URL
    let url: URL
    let company: String
    let location: String
    let bio: String
    let name: String
    let repos_url: URL
}
