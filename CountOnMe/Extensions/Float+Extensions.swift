//
//  Float+Extensions.swift
//  CountOnMe
//
//  Created by ousama boujaouane on 26/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
