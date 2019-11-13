//
//  Barbarian.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 23/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Barbarian : Warrior {
    init(name: String) {
        super.init(
            name: name,
            weapon: Weapon(weaponType: .axe, isRandom: false),
            healthPoints: 100
        )
    }
}
