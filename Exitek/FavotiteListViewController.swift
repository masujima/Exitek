//
//  FavotiteListViewController.swift
//  Exitek
//
//  Created by Yernar Masujima on 9/3/22.
//

import UIKit

class FavotiteListViewController: UIViewController {
    
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var movieYearTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var movieList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddButton()
        configureTableView()
    }
    
    private func configureAddButton() {
        addButton.layer.cornerRadius = 5
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard
            let movieTitle = movieTitleTextField.text, !movieTitle.isEmpty,
            let movieYear = movieYearTextField.text, !movieYear.isEmpty
        else {
            print("Text field cannot be empty")
            return
        }
        
        let movie = "\(movieTitle) \(movieYear)"
        
        if movieList.contains(movie) {
            print("The movie is already on the list")
        } else {
            movieList.append(movie)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: movieList.count-1, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
        
        movieTitleTextField.resignFirstResponder()
        movieYearTextField.resignFirstResponder()
    }
}

extension FavotiteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MovieCell")
        cell.textLabel?.text = movieList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

