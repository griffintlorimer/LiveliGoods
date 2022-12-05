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
        let results = searcher.getFoods(searchTerm: text!)!
        if (results.calories < 0.1){
            let alert = UIAlertController(title: "Invalid search", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "exit", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        data.append(results)
        

        
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
        
        if let fat = apiResults[indexPath.row].totalNutrients.CHOCDF, let carbs = apiResults[indexPath.row].totalNutrients.CHOCDF, let protein = apiResults[indexPath.row].totalNutrients.PROCNT {
            cell.foodLabel?.text = searchTerm
            cell.calorieLabel?.text = "calories: \( Int(apiResults[indexPath.row].calories))"
            cell.carbsLabel?.text = "carbs: \(Int(carbs.quantity))g"
            cell.fatLabel?.text = "fat: \(Int(fat.quantity))g"
            cell.proteinLabel?.text = "protein: \(Int(protein.quantity))g"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("called!")
        if let fat = apiResults[indexPath.row].totalNutrients.CHOCDF, let carbs = apiResults[indexPath.row].totalNutrients.CHOCDF, let protein = apiResults[indexPath.row].totalNutrients.PROCNT {
            let dfv = DetailedFoodView()
            dfv.foodName = searchTerm
            dfv.calories = Int(apiResults[indexPath.row].calories)
            dfv.fat = Int(fat.quantity)
            dfv.protein = Int(protein.quantity)
            dfv.carbs = Int(carbs.quantity)
            navigationController?.pushViewController(dfv, animated: true)

        }
        
    }

    
}



