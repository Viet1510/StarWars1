//
//  Film.swift
//  StarWars1
//
//  Created by Home on 11/14/22.
//

import Foundation

struct Film: Codable {
    let title: String
    let episode_id: Int
    let opening_crawl, director, producer, release_date: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

/*    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }  */
}
