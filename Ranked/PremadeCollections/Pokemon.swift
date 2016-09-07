//
//  Pokemon.swift
//  Project Order
//
//  Created by William Robinson on 26/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createPokémonCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Pokémon", description: "Gotta catch 'em all, but which Pokemon would you choose to be your buddy?", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    collection.id = "Pokemon"

    let item1 = ItemModel(name: "Bulbasaur", image: nil)
    
    let item2 = ItemModel(name: "Ivysaur", image: nil)
    
    let item3 = ItemModel(name: "Venusaur", image: nil)
    
    let item4 = ItemModel(name: "Charmander", image: nil)
    
    let item5 = ItemModel(name: "Charmeleon", image: nil)
    
    let item6 = ItemModel(name: "Charizard", image: nil)
    
    let item7 = ItemModel(name: "Squirtle", image: nil)
    
    let item8 = ItemModel(name: "Wartortle", image: nil)

    let item9 = ItemModel(name: "Blastoise", image: nil)
    
    let item10 = ItemModel(name: "Caterpie", image: nil)
    
    let item11 = ItemModel(name: "Metapod", image: nil)

    let item12 = ItemModel(name: "Butterfree", image: nil)
    
    let item13 = ItemModel(name: "Weedle", image: nil)
    
    let item14 = ItemModel(name: "Kakuna", image: nil)
    
    let item15 = ItemModel(name: "Beedrill", image: nil)
    
    let item16 = ItemModel(name: "Pidgey", image: nil)
    
    let item17 = ItemModel(name: "Pidgeotto", image: nil)
    
    let item18 = ItemModel(name: "Pidgeot", image: nil)
    
    let item19 = ItemModel(name: "Rattata", image: nil)
    
    let item20 = ItemModel(name: "Raticate", image: nil)
    
    let item21 = ItemModel(name: "Spearow", image: nil)
    
    let item22 = ItemModel(name: "Fearow", image: nil)
    
    let item23 = ItemModel(name: "Ekans", image: nil)
    
    let item24 = ItemModel(name: "Arbok", image: nil)
    
    let item25 = ItemModel(name: "Pikachu", image: nil)
    
    let item26 = ItemModel(name: "Raichu", image: nil)
    
    let item27 = ItemModel(name: "Sandshrew", image: nil)
    
    let item28 = ItemModel(name: "Sandslash", image: nil)
    
    let item29 = ItemModel(name: "Nidoran♀", image: nil)
    
    let item30 = ItemModel(name: "Nidorina", image: nil)
    
    let item31 = ItemModel(name: "Nidoqueen", image: nil)
    
    let item32 = ItemModel(name: "Nidoran♂", image: nil)
    
    let item33 = ItemModel(name: "Nidorino", image: nil)
    
    let item34 = ItemModel(name: "Nidoking", image: nil)
    
    let item35 = ItemModel(name: "Clefairy", image: nil)
    
    let item36 = ItemModel(name: "Clefable", image: nil)
    
    let item37 = ItemModel(name: "Vulpix", image: nil)
    
    let item38 = ItemModel(name: "Ninetales", image: nil)
    
    let item39 = ItemModel(name: "Jigglypuff", image: nil)
    
    let item40 = ItemModel(name: "Wigglytuff", image: nil)
    
    let item41 = ItemModel(name: "Zubat", image: nil)
    
    let item42 = ItemModel(name: "Golbat", image: nil)
    
    let item43 = ItemModel(name: "Oddish", image: nil)
    
    let item44 = ItemModel(name: "Gloom", image: nil)
    
    let item45 = ItemModel(name: "Vileplume", image: nil)
    
    let item46 = ItemModel(name: "Paras", image: nil)
    
    let item47 = ItemModel(name: "Parasect", image: nil)
    
    let item48 = ItemModel(name: "Venonat", image: nil)
    
    let item49 = ItemModel(name: "Venomoth", image: nil)
    
    let item50 = ItemModel(name: "Diglett", image: nil)
    
    let item51 = ItemModel(name: "Dugtrio", image: nil)
    
    let item52 = ItemModel(name: "Meowth", image: nil)
    
    let item53 = ItemModel(name: "Persian", image: nil)
    
    let item54 = ItemModel(name: "Psyduck", image: nil)
    
    let item55 = ItemModel(name: "Golduck", image: nil)
    
    let item56 = ItemModel(name: "Mankey", image: nil)
    
    let item57 = ItemModel(name: "Primeape", image: nil)
    
    let item58 = ItemModel(name: "Growlithe", image: nil)
    
    let item59 = ItemModel(name: "Arcanine", image: nil)
    
    let item60 = ItemModel(name: "Poliwag", image: nil)
    
    let item61 = ItemModel(name: "Poliwhirl", image: nil) //
    
    let item62 = ItemModel(name: "Poliwrath", image: nil) //
    
    let item63 = ItemModel(name: "Abra", image: nil) //
    
    let item64 = ItemModel(name: "Kadabra", image: nil) //
    
    let item65 = ItemModel(name: "Alakazam", image: nil) //
    
    let item66 = ItemModel(name: "Machop", image: nil) // Andorra
    
    let item67 = ItemModel(name: "Machoke", image: nil) // United Arab Emirates
    
    let item68 = ItemModel(name: "Machamp", image: nil) // Afghanistan
    
    let item69 = ItemModel(name: "Bellsprout", image: nil) // Antigua & Barbuda
    
    let item70 = ItemModel(name: "Weepinbell", image: nil) // Anguilla
    
    let item71 = ItemModel(name: "Victreebel", image: nil) // Albania
    
    let item72 = ItemModel(name: "Tentacool", image: nil) // Ascension Island
    
    let item73 = ItemModel(name: "Tentacruel", image: nil) // Andorra
    
    let item74 = ItemModel(name: "Geodude", image: nil) // United Arab Emirates
    
    let item75 = ItemModel(name: "Graveler", image: nil) // Afghanistan
    
    let item76 = ItemModel(name: "Golem", image: nil) // Antigua & Barbuda
    
    let item77 = ItemModel(name: "Ponyta", image: nil) // Anguilla
    
    let item78 = ItemModel(name: "Rapidash", image: nil) // Albania
    
    let item79 = ItemModel(name: "Slowpoke", image: nil) // Ascension Island
    
    let item80 = ItemModel(name: "Slowbro", image: nil) // Andorra
    
    let item81 = ItemModel(name: "Magnemite", image: nil) // United Arab Emirates
    
    let item82 = ItemModel(name: "Magneton", image: nil) // Afghanistan
    
    let item83 = ItemModel(name: "Farfetch'd", image: nil) // Antigua & Barbuda
    
    let item84 = ItemModel(name: "Doduo", image: nil) // Anguilla
    
    let item85 = ItemModel(name: "Dodrio", image: nil) // Albania
    
    let item86 = ItemModel(name: "Seel", image: nil) // Ascension Island
    
    let item87 = ItemModel(name: "Dewgong", image: nil) // Andorra
    
    let item88 = ItemModel(name: "Grimer", image: nil) // United Arab Emirates
    
    let item89 = ItemModel(name: "Muk", image: nil) // Afghanistan
    
    let item90 = ItemModel(name: "Shellder", image: nil) // Antigua & Barbuda
    
    let item91 = ItemModel(name: "Cloyster", image: nil) // Anguilla
    
    let item92 = ItemModel(name: "Gastly", image: nil) // Albania
    
    let item93 = ItemModel(name: "Haunter", image: nil) // Ascension Island
    
    let item94 = ItemModel(name: "Gengar", image: nil) // Andorra
    
    let item95 = ItemModel(name: "Onix", image: nil) // United Arab Emirates
    
    let item96 = ItemModel(name: "Drowzee", image: nil) // Afghanistan
    
    let item97 = ItemModel(name: "Hypno", image: nil) // Antigua & Barbuda
    
    let item98 = ItemModel(name: "Krabby", image: nil) // Anguilla
    
    let item99 = ItemModel(name: "Kingler", image: nil) // Albania
    
    let item100 = ItemModel(name: "Voltorb", image: nil) //
    
    let item101 = ItemModel(name: "Electrode", image: nil) // United Arab Emirates
    
    let item102 = ItemModel(name: "Exeggcute", image: nil) // Afghanistan
    
    let item103 = ItemModel(name: "Exeggutor", image: nil) // Antigua & Barbuda
    
    let item104 = ItemModel(name: "Cubone", image: nil) // Anguilla
    
    let item105 = ItemModel(name: "Marowak", image: nil) // Albania
    
    let item106 = ItemModel(name: "Hitmonlee", image: nil) //
    
    let item107 = ItemModel(name: "Hitmonchan", image: nil) //
    
    let item108 = ItemModel(name: "Lickitung", image: nil) //
    
    let item109 = ItemModel(name: "Koffing", image: nil) //
    
    let item110 = ItemModel(name: "Weezing", image: nil) //
    
    let item111 = ItemModel(name: "Rhyhorn", image: nil) //
    
    let item112 = ItemModel(name: "Rhydon", image: nil) //
    
    let item113 = ItemModel(name: "Chansey", image: nil) //
    
    let item114 = ItemModel(name: "Tangela", image: nil) // Andorra
    
    let item115 = ItemModel(name: "Kangaskhan", image: nil) // United Arab Emirates
    
    let item116 = ItemModel(name: "Horsea", image: nil) // Afghanistan
    
    let item117 = ItemModel(name: "Seadra", image: nil) // Antigua & Barbuda
    
    let item118 = ItemModel(name: "Goldeen", image: nil) // Anguilla
    
    let item119 = ItemModel(name: "Seaking", image: nil) // Albania
    
    let item120 = ItemModel(name: "Staryu", image: nil) // Ascension Island
    
    let item121 = ItemModel(name: "Starmie", image: nil) // Andorra
    
    let item122 = ItemModel(name: "Mr. Mime", image: nil) // United Arab Emirates
    
    let item123 = ItemModel(name: "Scyther", image: nil) // Afghanistan
    
    let item124 = ItemModel(name: "Jynx", image: nil) // Antigua & Barbuda
    
    let item125 = ItemModel(name: "Electabuzz", image: nil) // Anguilla
    
    let item126 = ItemModel(name: "Magmar", image: nil) // Albania
    
    let item127 = ItemModel(name: "Pinsir", image: nil) // Ascension Island
    
    let item128 = ItemModel(name: "Tauros", image: nil) // Andorra
    
    let item129 = ItemModel(name: "Magikarp", image: nil)
    
    let item130 = ItemModel(name: "Gyarados", image: nil)
    
    let item131 = ItemModel(name: "Lapras", image: nil)
    
    let item132 = ItemModel(name: "Ditto", image: nil)
    
    let item133 = ItemModel(name: "Eevee", image: nil)
    
    let item134 = ItemModel(name: "Vaporeon", image: nil)
    
    let item135 = ItemModel(name: "Jolteon", image: nil)
    
    let item136 = ItemModel(name: "Flareon", image: nil)
    
    let item137 = ItemModel(name: "Porygon", image: nil)
    
    let item138 = ItemModel(name: "Omanyte", image: nil)
    
    let item139 = ItemModel(name: "Omastar", image: nil)
    
    let item140 = ItemModel(name: "Kabuto", image: nil)
    
    let item141 = ItemModel(name: "Kabutops", image: nil)
    
    let item142 = ItemModel(name: "Aerodactyl", image: nil)
    
    let item143 = ItemModel(name: "Snorlax", image: nil)
    
    let item144 = ItemModel(name: "Articuno", image: nil)
    
    let item145 = ItemModel(name: "Zapdos", image: nil)
    
    let item146 = ItemModel(name: "Moltres", image: nil)
    
    let item147 = ItemModel(name: "Dratini", image: nil)
    
    let item148 = ItemModel(name: "Dragonair", image: nil)
    
    let item149 = ItemModel(name: "Dragonite", image: nil)
    
    let item150 = ItemModel(name: "Mewtwo", image: nil)
    
    let item151 = ItemModel(name: "Mew", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9,
                        item10, item11, item12, item13, item14, item15, item16, item17, item18, item19,
                        item20, item21, item22, item23, item24, item25, item26, item27, item28, item29,
                        item30, item31, item32, item33, item34, item35, item36, item37, item38, item39,
                        item40, item41, item42, item43, item44, item45, item46, item47, item48, item49,
                        item50, item51, item52, item53, item54, item55, item56, item57, item58, item59,
                        item60, item61, item62, item63, item64, item65, item66, item67, item68, item69,
                        item70, item71, item72, item73, item74, item75, item76, item77, item78, item79,
                        item80, item81, item82, item83, item84, item85, item86, item87, item88, item89,
                        item90, item91, item92, item93, item94, item95, item96, item97, item98, item99,
                        item100, item101, item102, item103, item104, item105, item106, item107, item108, item109,
                        item110, item111, item112, item113, item114, item115, item116, item117, item118, item119,
                        item120, item121, item122, item123, item124, item125, item126, item127, item128, item129,
                        item130, item131, item132, item133, item134, item135, item136, item137, item138, item139,
                        item140, item141, item142, item143, item144, item145, item146, item147, item148, item149,
                        item150, item151]
    
    return collection
}
