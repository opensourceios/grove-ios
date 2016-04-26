//
//  LocationComment.swift
//  Whereno
//
//  Created by Kyle Bashour on 4/25/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import RealmSwift
import Mapper

final class LocationComment: Object, Mappable, JSONEncodable {

    dynamic var id = 0
    dynamic var text = ""
    dynamic var date = NSDate()

    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init(map: Mapper) throws {
        self.init()

        try id = map.from("id")
        try text = map.from("text")
        try date = map.from("date")
    }

    private static let commentFormatter: NSDateFormatter = {
        let formatter =  NSDateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    var formattedDate: String {
        return "Posted on " + LocationComment.commentFormatter.stringFromDate(date)
    }

    func toJSON() -> [String : AnyObject] {
        return [
            "id": id,
            "text": text,
            "date": formattedDate
        ]
    }
}
