//
//  moreMoviesViewController.swift
//  reflexionCompanyTask
//
//  Created by Mac on 17/01/35.
//

import UIKit
import CoreData
class moreMoviesViewController: UIViewController {
     var movies1 = [MovieList]()
    @IBOutlet weak var tableView2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataSourceAndDelegate()
        registerNib()
        fetchingAPI()
    }
//MARK - init data source and delegate method
    func initDataSourceAndDelegate(){
        tableView2.dataSource = self
        tableView2.delegate = self
    }
//MARK - register xib
    func registerNib(){
        let nibname = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView2.register(nibname, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
//MARK - fetching api data
    func fetchingAPI(){
        let urlString =  "http://task.auditflo.in/2.json"
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
                
                self.movies1.append(MovieList(Title: title, Year: year, Runtime: runtime, Cast: cast))
                let coreDataInstance = DBHelper()
                coreDataInstance.insertData(title: title, year: Double(year)!, runtime: Double(runtime)!, cast: cast)
                coreDataInstance.retriveMovieeRecords()
            }
            DispatchQueue.main.async {
                self.tableView2.reloadData()
            }
        }
        dataTask.resume()
    }
}
//MARK - conform to table view data source
extension moreMoviesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.tableView2.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        tableViewCell.titleLabel.text = movies1[indexPath.row].Title
        tableViewCell.yearLabel.text = movies1[indexPath.row].Year
        tableViewCell.runTimeLabel.text = movies1[indexPath.row].Runtime
        tableViewCell.castLabel.text = movies1[indexPath.row].Cast
        tableViewCell.layer.borderWidth = 1
        tableViewCell.castLabel.layer.borderWidth = 0.5
        tableViewCell.titleLabel.layer.borderWidth = 0.5
        tableViewCell.yearLabel.layer.borderWidth = 0.5
        tableViewCell.runTimeLabel.layer.borderWidth = 0.5
        return tableViewCell
    }
}
//MARK - conform to the delegate
extension moreMoviesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
