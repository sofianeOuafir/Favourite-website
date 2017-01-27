//
//  Event.swift
//  TD3
//
//  Created by GELE Axel on 23/01/2017.
//  Copyright © 2017 GELE Axel. All rights reserved.
//

import Foundation

class Event {
    var _id : String
    var _date : Date
    var _name : String
    var _url : URL
    
    init(id: String, date: Date, name:String, url:URL)
    {
        _id = id
        _date = date
        _name = name
        _url = url
    }
    
}
