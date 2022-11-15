//
//  ViewController.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/4/22.
//
import FirebaseCore
import GoogleSignIn
import UIKit
import GoogleUtilities
import FirebaseAuth

class FoodInput: UIViewController, UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var searcher = Searcher()
    var apiResults: [ApiResult] = []
    var searchTerm = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    // GET https://api.spoonacular.com/food/search?apiKey=63af9b43d60fbd08b37e7c24aac3e5d87c563d4f&query=apple&number=2
    // function to do stuff when searchbar is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("CLICKED")
        let text = searchBar.text
        if (text?.count ?? 0 <= 0){
            print("EMPTY")
            return
        }
        searchTerm = text ?? ""

        var data:[ApiResult] = []
        data.append(searcher.getFoods(searchTerm: text!)!)
        
        apiResults = data
        self.tableView.reloadData()


        print(apiResults)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(apiResults.count)
        return apiResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell

        cell.bigLabel?.text = searchTerm
        
        cell.smallLabel?.text = "calories: \(apiResults[indexPath.row].calories.value)"
        
        
        return cell
    }
    
    

    
}
