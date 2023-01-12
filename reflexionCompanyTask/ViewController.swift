//
//  ViewController.swift
//  reflexionCompanyTask
//
//  Created by Mac on 11/01/23.
//

import UIKit
import CoreData
class ViewController: UIViewController {
  
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var btnForMoreMovies: UIButton!
     var movies = [MovieList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializationOfDataSourceAndDelegate()
        registerNib()
        fetchingAPI()
    }
//MARK - init data source and delegate method
    func initializationOfDataSourceAndDelegate(){
        tableView1.dataSource = self
        tableView1.delegate = self
    }
// MARK - register xib file
    func registerNib(){
        let uiNib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView1.register(uiNib, forCellReuseIdentifier: "MovieTableViewCell")
    }
//MARK - fetching api data
    func fetchingAPI(){
        let urlString =  "http://task.auditflo.in/1.json"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let  dataTask = session.dataTask(with: request){ data,response,error in
            print("Data\(data)")
            print("response\(response)")
            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
            
            let dictionary = getJSONObject as! [String:Any]
            let movieList = dictionary["Movie List"] as! [[String:Any]]
            for eachDict in movieList{
                let eachDictionary = eachDict as! [String:Any]
                let title = eachDictionary["Title"] as! String
                let year = eachDictionary["Year"] as! String
                let runtime = eachDictionary["Runtime"] as! String
                let cast = eachDictionary["Cast"] as! String
                
                self.movies.append(MovieList(Title: title, Year: year, Runtime: runtime, Cast: cast))
                let coreDataInstance = DBHelper()
                coreDataInstance.insertData(title: title, year: Double(year)!, runtime: Double(runtime)!, cast: cast)
                coreDataInstance.retriveMovieeRecords()
            }
            DispatchQueue.main.async {
                self.tableView1.reloadData()
            }
        }
        dataTask.resume()
    }
    
// MARK - IBAction on button
    @IBAction func clickBtnToMoreMovies(_ sender: Any) {
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "moreMoviesViewController")
        navigationController?.pushViewController(secondViewController!, animated: true)
    }
}

//MARK - conform the table view
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.tableView1.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        tableViewCell.titleLabel.text = movies[indexPath.row].Title
        tableViewCell.yearLabel.text = movies[indexPath.row].Year
        tableViewCell.runTimeLabel.text = movies[indexPath.row].Runtime
        tableViewCell.castLabel.text = movies[indexPath.row].Cast
        tableViewCell.layer.borderWidth = 1
        tableViewCell.castLabel.layer.borderWidth = 0.5
        tableViewCell.titleLabel.layer.borderWidth = 0.5
        tableViewCell.yearLabel.layer.borderWidth = 0.5
        tableViewCell.runTimeLabel.layer.borderWidth = 0.5
        return tableViewCell
    }
}
//MARK - conform the delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

