//
//  Weapon.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 27/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Weapon {
    // MARK: Enums
    
    /// The different types of weapons
    enum WeaponType {
        case wand, bow, spear, axe
    }
    
    // MARK: Initializers
    init(name: String, attackBonus: Int, magicBonus: Int, weaponType: WeaponType) {
        self.name = name
        self.attackBonus = attackBonus
        self.magicBonus = magicBonus
        self.weaponType = weaponType
    }
    
    // Initialization which allows you to set the attack strength or healing power of a warrior, and modify it according to the value of a random number
    //      If isRandom = true, return a new weapon with random magicpoints/attackpoints
    //      If isRandom = false, return basic magicpoints/attackpoints
    convenience init(weaponType: WeaponType, isRandom: Bool) {
        switch weaponType {
        case .wand:
            let magicBonus = isRandom ? Int.random(in: 25...65) : 45
            self.init(name: "wand", attackBonus: 0, magicBonus: magicBonus, weaponType: weaponType)
        case .bow:
            let attackBonus = isRandom ? Int.random(in: 50...100) : 75
            self.init(name: "bow", attackBonus: attackBonus, magicBonus: 0, weaponType: weaponType)
        case .spear:
            let attackBonus = isRandom ? Int.random(in: 35...95) : 65
            self.init(name: "spear", attackBonus: attackBonus, magicBonus: 0, weaponType: weaponType)
        case .axe:
            let attackBonus = isRandom ? Int.random(in: 65...115) : 90
            self.init(name: "axe", attackBonus: attackBonus, magicBonus: 0, weaponType: weaponType)
        }
    }
    
    // MARK: Properties
    private var name: String
    var attackBonus: Int
    var magicBonus: Int
    var weaponType: WeaponType
}

