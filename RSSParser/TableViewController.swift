//
//  ViewController.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit


struct Post {
    var title: String!
    var link: String!
    var date: String!
}

class TableViewController: UITableViewController, XMLParserDelegate {

    var posts: [Post] = []
    
    var parser = XMLParser()
    
    var tempPost: Post? = nil
    var tempElement: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = XMLParser(contentsOf:(URL(string:"https://www.vesti.ru/vesti.rss")!))!
        parser.delegate = self
        parser.parse()
    }
    
    //MARK: - XMLParser Delegate
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        tempElement = elementName
        if elementName == "item" {
            tempPost = Post(title: "", link: "", date: "")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let post = tempPost {
                posts.append(post)
            }
            tempPost = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let post = tempPost {
            let str = string
            if tempElement == "title" {
                tempPost?.title = post.title+str
            } else if tempElement == "link" {
                tempPost?.link = post.link+str
            } else if tempElement == "pubDate" {
                tempPost?.date = post.date+str
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(posts[indexPath.row].link)
        print(posts)
    }

}

