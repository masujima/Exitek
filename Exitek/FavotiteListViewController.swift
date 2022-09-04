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
        configureMovieTitleTextField()
        configureMovieYearTextField()
        configureAddButton()
        configureTableView()
    }
    
    private func configureMovieTitleTextField() {
        movieTitleTextField.delegate = self
    }
    
    private func configureMovieYearTextField() {
        movieYearTextField.delegate = self
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
            let alert = UIAlertController(title: "Text field cannot be empty", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let movie = "\(movieTitle) \(movieYear)"
        
        if movieList.contains(movie) {
            let alert = UIAlertController(title: "The movie is already on the list", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
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

extension FavotiteListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == movieYearTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case movieTitleTextField:
            movieYearTextField.becomeFirstResponder()
        case movieYearTextField:
            movieYearTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

