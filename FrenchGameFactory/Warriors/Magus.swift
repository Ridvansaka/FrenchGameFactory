//
//  Magus.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 23/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Magus : Warrior {
    init(name: String) {
        super.init(
            name: name,
            weapon: Weapon(weaponType: .wand, isRandom: false),
            healthPoints: 120
        )
    }
    
    /// Function which increases the healthpoints of the selected teammate during an attack, according to magic points of the magus
    func heal(warrior: Warrior) {
        warrior.earnHealthPoints(magicPoints)
    }
}
