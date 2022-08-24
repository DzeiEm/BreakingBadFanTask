//
//  QuatesAPI.swift
//  BreakingBadFan
//
//  Created by Julija M. on 2022-08-18.
//

import Foundation


struct QuotesResponse: Decodable {
    
    let id: Int
    let quoteTitle: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case quoteTitle
        case author
    }
}
