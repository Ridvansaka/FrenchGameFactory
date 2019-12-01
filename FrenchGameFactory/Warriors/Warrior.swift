//
//  Warrior.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 21/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Warrior {
    // MARK: Enums
    
    /// The different types of warriors
    enum WarriorType {
        case archer, magus, knight, barbarian
    }
    
    // MARK: Static
    static func createWarriorAccordingTo(type: WarriorType, warriorName: String) -> Warrior {
        switch type {
        case .archer:
            return Archer(name: warriorName)
        case .magus:
            return Magus(name: warriorName)
        case .knight:
            return Knight(name: warriorName)
        case .barbarian:
            return Barbarian(name: warriorName)
        }
    }
    
    // MARK: Initializers
    init(name: String, weapon: Weapon, healthPoints: Int) {
        self.name = name
        self.weapon = weapon
        self.currentHealthPoints = healthPoints
        self.maxHealthPoints = healthPoints
    }
    
    // MARK: Properties
    
    /// Property which represents the warrior's name to differentiate them
    var name: String
    
    /// Property which represents the warrior's weapon type to vary the type of attack
    var weapon: Weapon
    
    /// Property which represents the warrior's healthpoints, represents its resistance to opponent attacks
    var currentHealthPoints = 100 {
        didSet {
            if currentHealthPoints < 0 {
                currentHealthPoints = 0
            } else if currentHealthPoints > maxHealthPoints {
                currentHealthPoints = maxHealthPoints
            }
        }
    }
    
    /// Property which represents the warrior's maximum healthpoints, he can't have more healthpoints than this number
    var maxHealthPoints: Int
    
    /// Property which is set to true if the warrior's current healthpoints > 0
    var isAlive: Bool {
        return currentHealthPoints > 0
    }
    
    /// Property which determines the attack strength of a warrior
    var attackPoints: Int {
        return weapon.attackBonus
    }
    
    /// Property which determines the heal strength of a warrior
    var magicPoints: Int {
        return weapon.magicBonus
    }

    // MARK: Public Methods
    
    /// Function that lowers the healthpoints of the opponent team's warrior during an attack according to the attackpoints of our warrior
    func attack(opponent: Warrior) {
        opponent.takeDamage(attackPoints)
    }
    
    /// Function that lowers current healthpoints by amount
    func takeDamage(_ amount: Int) {
        currentHealthPoints -= amount
    }
    
    /// Function that increases current healthpoints by amount
    func earnHealthPoints(_ amount: Int) {
        currentHealthPoints += amount
    }
    
    /// Function which allows to change the warrior's weapon during fight phase according to a random number
    ///      If the random number = 0, return true, the weapon change
    ///      If the number random != 0, return false, the weapon remains unchanged
    func mightFindTreasure() {
        let randomNumber = Int.random(in: 0...2)
        if randomNumber == 0 {
            print("🔫 The warrior has found a new weapon")
            let newWeapon = Weapon(weaponType: weapon.weaponType, isRandom: true)
            print("It has \(newWeapon.attackBonus) attackpoints")
            weapon = newWeapon
        } else {
            print("❌ The warrior did not find treasure")
        }
    }
}
