//
//  ViewController.swift
//  AppLoteria
//
//  Created by Tiago & Karina on 30/11/22.
//

import UIKit

enum GameType: String {
    case megaSena = "Mega-Sena"
    case quina = "Quina"
}
//Operador personalizado
infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var gameTypeSC: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoWNumbers(for: .megaSena)
    }
    func shoWNumbers(for type: GameType) {
        gameTypeLabel.text = type.rawValue
        var game: [Int] = []
        switch type {
        case .megaSena:
            game = 6 >-< 60
            balls.last!.isHidden = false
        case .quina:
            game = 5 >-< 80
            balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func generateGameButton() {
        switch gameTypeSC.selectedSegmentIndex {
        case 0:
            shoWNumbers(for: .megaSena)
        default:
            shoWNumbers(for: .quina)
        }
    }
}

