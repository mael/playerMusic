//
//  Song.swift
//  playerMusic
//
//  Created by Mael on 2/5/16.
//  Copyright © 2016 Mael T. All rights reserved.
//

import UIKit
import Foundation


extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<self.count-1
        {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}

class ListSongs {
    
    var music: Array<Song> = Array<Song>()
    
    init(){
        self.music.append(Song(
            title: "Los bigotes de la muerte",
            author: "Kojon prieto y los Huajalotes",
            disc: "Agarrense que llegan los reyes del Napar-Mex",
            cover: UIImage(named: "huajalotes")!,
            fileSong: "LosBigotesDeLaMuerte"))
        self.music.append(Song(
            title: "Mad world",
            author: "Gary Jules",
            disc: "Tears for fears covers",
            cover: UIImage(named: "madWorld")!,
            fileSong: "MadWorld"))
        self.music.append(Song(
            title: "Papaoutai",
            author: "Stromae",
            disc: "Racine carrée",
            cover: UIImage(named: "stromae")!,
            fileSong: "Papaoutai"))
        self.music.append(Song(
            title: "Piranha",
            author: "The Prodigy",
            disc: "Invaders must die",
            cover: UIImage(named: "prodigy")!,
            fileSong: "Piranha"))
        self.music.append(Song(
            title: "Run",
            author: "Milk Inc",
            disc: "Supersized",
            cover: UIImage(named: "milkInc")!,
            fileSong: "Run"))
        
        self.music.shuffle()
        
    }
}

class Song: NSObject {
    var title: String
    var author: String
    var disc: String
    var cover: UIImage
    var fileSong: String
    
    init(title: String, author: String, disc: String, cover: UIImage, fileSong:  String){
        
        self.title = title
        self.author = author
        self.disc = disc
        self.cover = cover
        self.fileSong = fileSong
        
    }
}


