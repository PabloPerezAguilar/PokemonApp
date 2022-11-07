//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Consultant on 6/17/22.
//

import UIKit

protocol PassDataToList{
    func passSelectedRowData(cell: UITableViewCell)
}

class PokemonTableViewCell: UITableViewCell {
    
    var delegate: PassDataToList?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starButton = UIButton(type: .system)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc private func handleMarkAsFavorite(){
        delegate?.passSelectedRowData(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
