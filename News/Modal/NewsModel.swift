//
//  News.swift
//  News
//
//  Created by Marco on 2024-08-01.
//

import Foundation

struct News: Codable{
    var author: String
    var title: String
    var desription: String
    var imageUrl: String
    var url: String
    var publishedAt: String
}
