//
//  Knight.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 23/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Knight : Warrior {
    init(name: String) {
        super.init(
            name: name,
            weapon: Weapon(weaponType: .spear, isRandom: false),
            healthPoints: 150
        )
    }
}
