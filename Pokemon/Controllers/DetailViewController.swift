//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Consultant on 6/18/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var hpProgress: UIProgressView!
    @IBOutlet weak var atkProgress: UIProgressView!
    @IBOutlet weak var defProgress: UIProgressView!
    @IBOutlet weak var satkProgress: UIProgressView!
    @IBOutlet weak var sdefProgress: UIProgressView!
    @IBOutlet weak var spdProgress: UIProgressView!
    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var pokemon = Pokemon(
            name: "",
            imageUrl: "",
            types: [],
            baseExperience: 0,
            hp: 0,
            attack: 0,
            defense: 0,
            specialAttack: 0,
            specialDefense: 0,
            speed: 0,
            height: 0,
            weight: 0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        putTypes(types: pokemon.types)
        secondaryView.layer.cornerRadius = 10
        nameLabel.text = pokemon.name.uppercased()
        pokeImage.getImage(from: URL(string:pokemon.imageUrl)!)
        heightLabel.text = "\(pokemon.height)"
        weightLabel.text = "\(pokemon.weight)"
        baseExperienceLabel.text = "\(pokemon.baseExperience)"
        hpProgress.progress = (Float(pokemon.hp) / 100)
        atkProgress.progress = (Float(pokemon.attack) / 100)
        defProgress.progress = (Float(pokemon.defense) / 100)
        satkProgress.progress = (Float(pokemon.specialAttack) / 100)
        sdefProgress.progress = (Float(pokemon.specialDefense) / 100)
        spdProgress.progress = (Float(pokemon.speed) / 100)
        

    }
    

    func putTypes(types: [String]){
        for i in (0..<types.count){
            let color = getColor(element: types[i].uppercased())
            if(i == 0){
                view.backgroundColor = color
            }
            let label = UILabel()
            label.text = types[i].uppercased()
            label.textColor = .white
            label.backgroundColor = color
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            
            stackView.addArrangedSubview(label)
        }
        
    }
    
    func getColor(element: String) -> UIColor{
        var color = UIColor.systemRed
        switch(element){
            case "BUG":
                color = UIColor.systemGreen
            case "DARK":
                color = UIColor.black
            case "DRAGON":
                color = UIColor.purple
            case "ELECTRIC":
                color = UIColor.yellow
            case "FAIRY":
                color = UIColor.systemPink
            case "FIGHTING":
                color = UIColor.brown
            case "FIRE":
                color = UIColor.systemRed
            case "FLYING":
                color = UIColor.cyan
            case "GHOST":
                color = UIColor.darkGray
            case "GRASS":
                color = UIColor.systemGreen
            case "GROUND":
                color = UIColor.brown
            case "ICE":
                color = UIColor.systemMint
            case "POISON":
                color = UIColor.purple
            case "PSYCHIC":
                color = UIColor.orange
            case "ROCK":
                color = UIColor.darkGray
            case "STEEL":
                color = UIColor.darkGray
            case "WATER":
                color = UIColor.blue
            default:
                color = UIColor.gray
        }
        
        return color
    }
    
   
}
