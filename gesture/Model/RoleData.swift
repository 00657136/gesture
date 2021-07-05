//
//  RoleData.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import Foundation

import SwiftUI

struct Role:Identifiable {
    var id = UUID()
    var JPname:String
    var chname:String
}

struct SingleRole:Identifiable {
    var id = UUID()
    var vocabulary:String
}

var rolesSwordsman = [
    Role(JPname: "nag wi", chname: "乳牛"),
    Role(JPname: "ney wi", chname: "大象"),
    Role(JPname: "pax mi", chname: "地洞"),
    Role(JPname: "seq gi", chname: "公雞"),
    Role(JPname: "tan mi", chname: "禿鷲"),
    Role(JPname: "xaj bi", chname: "狗"),
    Role(JPname: "xar mi", chname: "綿羊"),
    Role(JPname: "yamb wi", chname: "蜜蜂"),
    Role(JPname: "sunel bi", chname: "刺蝟"),
    Role(JPname: "ngej mi", chname: "禿鸛")
]
