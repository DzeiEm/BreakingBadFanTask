

import Foundation


struct Episode: Hashable {
    let id: Int
    let title: String
    let season: String
    let airDate: String
    let characters: [String]
}

extension Episode: Comparable {
    
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        if lhs.title == rhs.title {
            return lhs.title > rhs.title
        }
        return lhs.title < rhs.title
    }
    
}
