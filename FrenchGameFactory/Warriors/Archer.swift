//
//  Archer.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 23/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Archer : Warrior {
    init(name: String) {
        super.init(
            name: name,
            weapon: Weapon(weaponType: .bow, isRandom: false),
            healthPoints: 120
        )
    }
}

