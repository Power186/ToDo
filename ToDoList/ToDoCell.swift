//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Scott on 1/7/21.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    weak var delegate: ToDoCellDelegate?

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) { 
        delegate?.checkmarkTapped(sender: self)
    }
    
    func update(with todo: ToDo) {
        titleLabel.text = todo.title
        isCompleteButton.isSelected = todo.isComplete
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
