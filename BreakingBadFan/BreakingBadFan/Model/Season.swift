

import Foundation

struct Season: Hashable {
    let title: String
    var episodes: [Episode]
}

//extension Season: Comparable {
//
//    static func < (lhs: Season, rhs: Season) -> Bool {
//        if lhs.title == rhs.title {
//            return lhs.title > rhs.title
//        }
//        return lhs.title < rhs.title
//    }
//}
