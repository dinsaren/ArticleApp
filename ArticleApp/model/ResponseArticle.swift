//
//  ResponseArticle.swift
//  ArticleApp
//
//  Created by Dinsaren on 12/17/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseList : Mappable{
    var CODE : String?
    var MESSAGE : String?
    var DATA : String?
    var PAGINATION : String?
    required init?(map: Map) {
        
    }
    
   func mapping(map: Map) {
        CODE <- map["CODE"]
        MESSAGE <- map["MESSAGE"]
        DATA <- map["DATA"]
        PAGINATION <- map["PAGINATION"]
    }
    
   
}
class Article : Mappable {
    var ID: Int?
    var TITLE : String?
    var DESCRIPTION : String?
    var CREATED_DATE : String?
    var AUTHOR : String?
    var STATUS : String?
    var CATEGORY : String?
    var IMAGE : String?
    required init?(map: Map) {
        
    }
     func mapping(map: Map) {
        ID <- map["ID"]
        TITLE <- map["TITLE"]
        DESCRIPTION <- map ["DESCRIPTION"]
        CREATED_DATE <- map ["CREATED_DATE"]
        AUTHOR <- map ["AUTHOR"]
        STATUS <- map ["STATUS"]
        CATEGORY <- map ["CATEGORY"]
        IMAGE <- map ["IMAGE"]
    }
}
class Pagination : Mappable{
    var PAGE : Int?
    var LIMIT : Int?
    var TOTAL_COUNT : Int?
    var TOTAL_PAGES : Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        PAGE <- map["PAGE"]
        LIMIT <- map ["LIMIT"]
        TOTAL_COUNT <- map ["TOTAL_COUNT"]
        TOTAL_PAGES <- map ["TOTAL_PAGES"]
    }
    
   
    
}
class User : Mappable{
    var ID : Int?
    var NAME : String?
    var EMAIL : String?
    var GENDER : String?
    var TELEPHONE : String?
    var STATUS : String?
    var FACEBOOK_ID : String?
    var IMAGE_URL : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ID <- map ["ID"]
        NAME <- map ["NAME"]
        EMAIL <- map ["EMAIL"]
        GENDER <- map ["GENDER"]
        TELEPHONE <- map ["TELEPHONE"]
        STATUS <- map ["STATUS"]
        FACEBOOK_ID <- map ["FACEBOOK_ID"]
        IMAGE_URL <- map ["IMAGE_URL"]
    }
    
   
}
class Category : Mappable {
    var ID : String?
    var NAME : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        ID <- map ["ID"]
        NAME <- map ["NAME"]
    }
    
    
}
