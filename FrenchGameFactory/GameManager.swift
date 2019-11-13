//
//  GameManager.swift
//  FrenchGameFactory
//
//  Created by SAKA Ridvan on 21/10/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import Foundation

class GameManager {
    
    //MARK: Properties & Constants
    
    /// Property which limit the number of players in the fight
    private let numberOfPlayerInGame = 2
    
    /// Property which count the number of rounds
    /// When all players have played once, the round is over
    private var numberOfRounds = 0
    
    /// Property which represents all the players
    private var players: [Player] = []
    
    /// Computed property which is set to true if all the warriors of a player are dead, or if the playing time is up.
    private var isGameOver: Bool {
        return isOnePlayerDead || isDraw
    }
    
    /// Computed property which ends the game, if there is no winner after 20 rounds
    var isDraw: Bool {
        if numberOfRounds >= 20 {
            print("🙅🏼‍♂️⛔️⛔️⛔️🔚🔚🔚⛔️⛔️⛔️🙅🏼‍♂️")
            print("Elapsed play time, we have not managed to separate you: there is EQUALITY.")
            return true
        }
        return false
    }
    
    /// Computed property which declares the death of a player when all the warriors of his team are dead
    var isOnePlayerDead: Bool {
        for player in players where !player.isAlive {
            return true
        }
        return false
    }
    
    //MARK: Public Methods
    /// Function which resets the game, create the players and warriors, then start the fight
    func playGame() {
        resetGame()
        createPlayers()
        startTeamCreationPhase()
        startFightPhase()
    }
    
    //MARK: Private Methods
    /// Function which empty the players' array and reset to 0 the round counter
    private func resetGame() {
        players.removeAll()
        numberOfRounds = 0
    }
    
    /// Function which create and add the players to the players array
    private func createPlayers() {
        for playerNumber in 1...numberOfPlayerInGame {
            let playerToAdd = Player(number: playerNumber)
            players.append(playerToAdd)
        }
    }
    
    /// Function which get the opponent player
    private func getOpponentPlayer(from currentPlayer: Player) -> Player? {
        for player in players {
            if player.color != currentPlayer.color {
                return player
            }
        }
        return nil
    }
    
    /// Function which creates all the warriors constituting the team and displays all the warriors of each team
    private func startTeamCreationPhase() {
        print("🎯 The selection phase of the warriors will start... \n")
        for player in players {
            print("👉🏼 Player \(player.color), it's your turn...\n")
            guard let opponentPlayer = getOpponentPlayer(from: player) else {
                return
            }
            player.makeTeam(opponent: opponentPlayer)
            player.displayWarriors()
        }
    }
    
    /// Function which begins the fight, each player plays its turn until one of them die
    /// If there is a winner, it displays its name and the statistics of the game
    private func startFightPhase() {
        print("⚔️ The fight will begin... \n")
        while !isGameOver {
            numberOfRounds += 1
            for player in players {
                print("Round n°\(numberOfRounds):")
                print("👉🏼 Player \(player.color), it's your turn... \n")
                guard let opponentPlayer = getOpponentPlayer(from: player) else {
                    return
                }
                player.playTurn(opponentPlayer: opponentPlayer)
                if isOnePlayerDead {
                    break
                }
            }
        }
        handleEndGame()
    }
    
    /// Function which displays the winner's name and the statistics of the game, if there is a winner after the fight
    /// Players are also offered to restart a game
    private func handleEndGame() {
        displayWinnerIfExisting()
        displayStatistics()
        if wantToPlayAgain() {
            playGame()
        } else {
            print("Thank you for playing, see you soon 😉")
        }
    }
    
    /// Function which displays the number of rounds played during the game, as well as each warrior stats of the two teams after the fight
    private func displayStatistics() {
        print("📈 Summary of the game:")
        print("There have been \(numberOfRounds) rounds \n")
        for player in players {
            player.displayWarriors()
        }
    }
    
    /// Function which offers the players to play again
    ///      1. Yes
    ///      2. No
    ///      Default. Ask again
    private func wantToPlayAgain() -> Bool {
        print("Do you want to play again? (👍🏼 1: yes, 👎🏼 2: no)")
        let responseInput = readLine()
        if let response = responseInput {
            switch response {
            case "1":
                return true
            case "2":
                return false
            default:
                print("⛔️ Error please enter number between 1-2")
                return wantToPlayAgain()
            }
        } else {
            print("⛔️ Error: Terminal error")
            return wantToPlayAgain()
        }
    }
    
    /// Function which displays the name of the winner if there is one
    private func displayWinnerIfExisting() {
        for player in players where player.isAlive {
            print("🏆 The player \(player.color) won the game \n")
            return
        }
    }
}






