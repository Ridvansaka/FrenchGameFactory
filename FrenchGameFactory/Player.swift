//
//  Player.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 21/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class Player {
    
    //MARK: Enums
    
    /// Player color to identify them
    enum Color: String {
        case blue, red
    }
    
    //MARK: Inits
    init(number: Int) {
        switch number {
        case 1:
            color = .red
        default:
            color = .blue
        }
    }
    
    //MARK: Properties & Constants
    
    /// Constant which defines the number of warriors per player
    private let numberOfWarriorPerTeam = 3
    
    /// Property which is used to identify the player
    let color: Color
    
    /// Property which represents the player's warrior team
    var warriors: [Warrior] = []
    
    /// Computed property which is set to true if one of the player's warriors is alive
    var isAlive: Bool {
        for warrior in warriors where warrior.isAlive {
            return true
        }
        return false
    }
    
    //MARK: Public Methods
    
    /// Function which create all the warriors which constitute the team
    ///     1. Asks warrior's name
    ///     2. Asks warrior's type
    ///     3. Create warrior according to type
    ///     4. Add the warrior to the team
    ///     5. Repeat according to number of warriors per team
    func makeTeam(opponent: Player) {
        for warriorNumber in 1...numberOfWarriorPerTeam {
            
            let warriorName = getWarriorName(warriorNumber: warriorNumber, opponent: opponent)
            let warriorType = getWarriorType()
            let warriorToAdd = Warrior.createWarriorAccordingTo(type: warriorType, warriorName: warriorName)

             warriors.append(warriorToAdd)
        }
    }
    
    /// Display the warriors within the team with all their stats
    func displayWarriors() {
        print("\nThe \(color) team is composed of the following warriors:")
        for (index, warrior) in warriors.enumerated() {
            print("Warrior n°\(index + 1) 👻: '\(warrior.name)' of the \(type(of: warrior)) class, HealthPoints 😷: \(warrior.currentHealthPoints)/\(warrior.maxHealthPoints), ", terminator: "")
            if warrior.attackPoints > 0 {
                print("AttackPoints 🥊: \(warrior.attackPoints) ", terminator: "")
            }
            if warrior.magicPoints > 0 {
                print("MagicPoints 🎩: \(warrior.magicPoints) ", terminator: "")
            }
            print()
        }
    }
    
    // Function which allows to the player to play its turn :
    // 1. It asks to the playing player to pick a warrior from its team
    // 2. Depending on the class of the warrior selected it will ask to pick another warrior as a target
    //      => from opponent team if warrior is attacking (!= magus)
    //      => from its own team if warrior is healing (magus)
    // 3. Finally the warrior performs the action
    func playTurn(opponentPlayer: Player) {
        print("🥊 Choose the warrior's number you want to send to attack (between 1-3) \n")
        var selectedFriendlyWarrior: Warrior?
        repeat {
            selectedFriendlyWarrior = selectWarrior(from: self)
        } while selectedFriendlyWarrior == nil
        print("💪🏼 The attacking warrior is \(selectedFriendlyWarrior!.name) \n")
        
        selectedFriendlyWarrior!.mightFindTreasure()
        
        // If we select a Magus, it will heal a teammate
        if let magus = selectedFriendlyWarrior! as? Magus {
            print("💉 Choose the warrior's number of your team that you want to heal (between 1-3) \n")
            var selectedFriendlyWarriorToHeal: Warrior?
            repeat {
                selectedFriendlyWarriorToHeal = selectWarrior(from: self)
            } while selectedFriendlyWarriorToHeal == nil
            print("🎯 The warrior who will be healed is \(selectedFriendlyWarriorToHeal!.name) \n")
            
            magus.heal(warrior: selectedFriendlyWarriorToHeal!)
            
            print("🎩 The Magus \(selectedFriendlyWarrior!.name) healed \(selectedFriendlyWarriorToHeal!.name)")
            print("🤕 New Healthpoints : \(selectedFriendlyWarriorToHeal!.currentHealthPoints) \n")
            
            // If we select another Warrior than a Magus, the attack will take place
        } else {
            print("🥊 Choose the warrior's number you want to attack in the opponent team (between 1-3)\n")
            var selectedOpponentWarrior: Warrior?
            repeat {
                selectedOpponentWarrior = selectWarrior(from: opponentPlayer)
            } while selectedOpponentWarrior == nil
            print("🎯 The warrior who will perform the attack is \(selectedOpponentWarrior!.name) \n")
            
            selectedFriendlyWarrior!.attack(opponent: selectedOpponentWarrior!)
            
            print("🏹 The warrior \(selectedFriendlyWarrior!.name) attacked \(selectedOpponentWarrior!.name)")
            print("🤕 Remaining Healthpoints : \(selectedOpponentWarrior!.currentHealthPoints) \n")
            if selectedOpponentWarrior!.currentHealthPoints <= 0 {
                print("☠️ \(selectedOpponentWarrior!.name) is dead \n")
            }
        }
    }
    
    //MARK: Private Methods
    
    /// Function which asks to the playing player to input a String in order to define the warrior's name
    /// Error cases handled:
    ///      1. Empty String
    ///      2. Name is already used (case insensitive)
    private func getWarriorName(warriorNumber: Int, opponent: Player) -> String {
        var errorOccured = false
        var warriorName: String?
        
        repeat {
            print("✏️ Please insert the name of your warrior N°\(warriorNumber) :")
            errorOccured = false
            var nameIsAlreadyUsed = false
            if let warriorNameInput = readLine() {
                let warriorNameWithoutSpaces = warriorNameInput.replacingOccurrences(of: " ", with: "")
                
                if !warriorNameWithoutSpaces.isEmpty {
                    // Verify if name is already used by the current player
                    if getWarriorNameIsAlreadyUsedBy(player: self, warriorNameInput: warriorNameInput) {
                        errorOccured = true
                        nameIsAlreadyUsed = true
                    }
                    
                    // Verify if name is already used by the opponent player
                    if getWarriorNameIsAlreadyUsedBy(player: opponent, warriorNameInput: warriorNameInput) {
                        errorOccured = true
                        nameIsAlreadyUsed = true
                    }
                    
                    if nameIsAlreadyUsed {
                        print("⛔️ Error, the name is already used \n")
                    }
                    
                    if !errorOccured {
                        warriorName = warriorNameInput
                    }
                } else {
                    errorOccured = true
                    print("⛔️ Error, name must not be empty")
                }
                
            } else {
                errorOccured = true
                print("⛔️ Error, Terminal error")
            }
            
        } while errorOccured
        return warriorName!
    }
    
    /// Function which check if one of the player's warriors' name is equivalent to the input
    private func getWarriorNameIsAlreadyUsedBy(player: Player, warriorNameInput: String) -> Bool {
        for warrior in player.warriors {
            if warrior.name.lowercased() == warriorNameInput.lowercased() {
                return true
            }
        }
        return false
    }
    
    /// Function which asks to the playing player to input a number between 1 and 4 in order to select a warrior type from list of classes
    /// Error cases handled:
    ///      1. Not Int
    ///      2. Out of bounds
    private func getWarriorType() -> Warrior.WarriorType {
        var errorOccured = false
        var warriorTypeSelected: Warrior.WarriorType?
        
        repeat {
            print("Please choose one of the following classes:")
            print("1. 🏹 Archer")
            print("2. 🎩 Magus")
            print("3. 🗡 Knight")
            print("4. ⛏ Barbarian \n")
            
            errorOccured = false
            
            if let warriorTypeSelectedInput = readLine() {
                switch warriorTypeSelectedInput {
                case "1":
                    warriorTypeSelected = .archer
                case "2":
                    warriorTypeSelected = .magus
                case "3":
                    warriorTypeSelected = .knight
                case "4":
                    warriorTypeSelected = .barbarian
                default:
                    errorOccured = true
                    print("⛔️ Error, input must be a number between 1-4")
                }
            } else {
                errorOccured = true
                print("⛔️ Error, terminal error")
            }
            
        } while errorOccured
        
        guard let warriorType = warriorTypeSelected else { return .archer}
        return warriorType
    }
    

    /// Function which asks to the playing player to input a number between 1 and 3 in order to select a warrior from a specific player team (own or opponent team)
    /// Error cases handled:
    ///      1. Not Int
    ///      2. Out of bounds
    ///      3. Dead warrior
    private func selectWarrior(from player: Player) -> Warrior? {
        player.displayWarriors()
        guard let warriorSelectedNumberString = readLine() else {
            return nil
        }
        guard let warriorSelectedNumber = Int(warriorSelectedNumberString) else {
            print("🚫 Entry is invalid, please enter a number between 1 and \(player.warriors.count) \n")
            return nil
        }
        let warriorSelectedIndex = warriorSelectedNumber - 1
        if warriorSelectedIndex >= player.warriors.count || warriorSelectedIndex < 0 {
            print("🚫 The selected player number is not between 1 and \(player.warriors.count) \n")
            return nil
        }
        let warriorSelected = player.warriors[warriorSelectedIndex]
        guard warriorSelected.isAlive else {
            print("🚫 The selected player is dead, please choose another \n")
            return nil
        }
        return warriorSelected
    }
}

