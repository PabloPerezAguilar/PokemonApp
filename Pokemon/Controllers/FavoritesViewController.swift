//
//  FavoritesViewController.swift
//  Pokemon
//
//  Created by Consultant on 6/24/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let database = DatabaseHandler()
    var favorites: [PokeCore]?{
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = database.fetch(PokeCore.self)
    }
    
    func setUp(){
        title = "Favorites"
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let current = favorites?[indexPath.row]
        cell.textLabel?.text = current?.name
        cell.imageView?.getImage(from: URL(string: (current?.imageUrl)!)!)
        cell.detailTextLabel?.text = current?.types
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("deleting...")
            guard let favorite = favorites?[indexPath.row] else { return }
            tableView.beginUpdates()
            
            favorites?.remove(at: indexPath.row)
            database.delete(favorite)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoritesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let selectedPokemon = favorites?[(self.tableView.indexPathForSelectedRow?.row)!]
            let types = (selectedPokemon?.types!.components(separatedBy: ", "))!
            let detailPokemon = Pokemon(
                name: (selectedPokemon?.name)!,
                imageUrl: (selectedPokemon?.imageUrl)!,
                types: types,
                baseExperience: Int((selectedPokemon?.baseExperience)!),
                hp: Int((selectedPokemon?.hp)!),
                attack: Int((selectedPokemon?.attack)!),
                defense: Int((selectedPokemon?.defense)!),
                specialAttack: Int((selectedPokemon?.specialAttack)!),
                specialDefense: Int((selectedPokemon?.specialDefense)!),
                speed: Int((selectedPokemon?.speed)!),
                height: Int((selectedPokemon?.height)!),
                weight: Int((selectedPokemon?.weight)!)
            )
            destination.pokemon = detailPokemon
        }
    }
    
    
}
