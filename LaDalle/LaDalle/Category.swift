//
//  Category.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/19/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit




struct Category {
    let title: String
    let alias: String

    static func fromDictionary(dictionary: NSDictionary) -> Category? {
        
        //Pull out each individual element from the dictionary
        guard
            let alias = dictionary["alias"] as? String,
            let title = dictionary["title"] as? String
            else {
                return nil
        }
        
        //Take the data parsed and create a Place Object from it
        return Category(title: title, alias: alias)
    }
    
    static func loadDefaults() -> [Category] {
        let categories: [Category] = [
            Category(title: "Bagels", alias:"bagels"),
            Category(title: "Bakeries", alias:"bakeries"),
            Category(title: "Beer, Wine & Spirits", alias:"beer_and_wine"),
            Category(title: "Breweries", alias:"breweries"),
            Category(title: "Bubble Tea", alias:"bubbletea"),
            Category(title: "Butcher", alias:"butcher"),
            Category(title: "CSA", alias:"csa"),
            Category(title: "Cideries", alias:"cideries"),
            Category(title: "Coffee & Tea", alias:"coffee"),
            Category(title: "Coffee Roasteries", alias:"coffeeroasteries"),
            Category(title: "Convenience Stores", alias:"convenience"),
            Category(title: "Cupcakes", alias:"cupcakes"),
            Category(title: "Custom Cakes", alias:"customcakes"),
            Category(title: "Desserts", alias:"desserts"),
            Category(title: "Distilleries", alias:"distilleries"),
            Category(title: "Do-It-Yourself Food", alias:"diyfood"),
            Category(title: "Donuts", alias:"donuts"),
            Category(title: "Empanadas", alias:"empanadas"),
            Category(title: "Ethnic Grocery", alias:"ethnicgrocery"),
            Category(title: "Farmers Market", alias:"farmersmarket"),
            Category(title: "Food Delivery Services", alias:"fooddeliveryservices"),
            Category(title: "Food Trucks", alias:"foodtrucks"),
            Category(title: "Gelato", alias:"gelato"),
            Category(title: "Grocery", alias:"grocery"),
            Category(title: "Honey", alias:"honey"),
            Category(title: "Ice Cream & Frozen Yogurt", alias:"icecream"),
            Category(title: "Internet Cafes", alias:"internetcafe"),
            Category(title: "Juice Bars & Smoothies", alias:"juicebars"),
            Category(title: "Kombucha", alias:"kombucha"),
            Category(title: "Organic Stores", alias:"organic_stores"),
            Category(title: "Patisserie/Cake Shop", alias:"cakeshop"),
            Category(title: "Poke", alias:"poke"),
            Category(title: "Pretzels", alias:"pretzels"),
            Category(title: "Shaved Ice", alias:"shavedice"),
            Category(title: "Specialty Food", alias:"gourmet"),
            Category(title: "Candy Stores", alias:"candy"),
            Category(title: "Cheese Shops", alias:"cheese"),
            Category(title: "Chocolatiers & Shops", alias:"chocolate"),
            Category(title: "Ethnic Food", alias:"ethnicmarkets"),
            Category(title: "Fruits & Veggies", alias:"markets"),
            Category(title: "Health Markets", alias:"healthmarkets"),
            Category(title: "Herbs & Spices", alias:"herbsandspices"),
            Category(title: "Macarons", alias:"macarons"),
            Category(title: "Meat Shops", alias:"meats"),
            Category(title: "Olive Oil", alias:"oliveoil"),
            Category(title: "Pasta Shops", alias:"pastashops"),
            Category(title: "Popcorn Shops", alias:"popcorn"),
            Category(title: "Seafood Markets", alias:"seafoodmarkets"),
            Category(title: "Street Vendors", alias:"streetvendors"),
            Category(title: "Tea Rooms", alias:"tea"),
            Category(title: "Water Stores", alias:"waterstores"),
            Category(title: "Wineries", alias:"wineries"),
            Category(title: "Wine Tasting Room", alias:"winetastingroom"),
            Category(title: "Afghan", alias: "afghani"),
            Category(title: "African", alias: "african"),
            Category(title: "Senegalese", alias: "senegalese"),
            Category(title: "South African", alias: "southafrican"),
            Category(title: "American", alias: "New"),
            Category(title: "American", alias: "Traditional"),
            Category(title: "Arabian", alias: "arabian"),
            Category(title: "Argentine", alias: "argentine"),
            Category(title: "Armenian", alias: "armenian"),
            Category(title: "Asian Fusion", alias: "asianfusion"),
            Category(title: "Australian", alias: "australian"),
            Category(title: "Austrian", alias: "austrian"),
            Category(title: "Bangladeshi", alias: "bangladeshi"),
            Category(title: "Barbeque", alias: "bbq"),
            Category(title: "Basque", alias: "basque"),
            Category(title: "Belgian", alias: "belgian"),
            Category(title: "Brasseries", alias: "brasseries"),
            Category(title: "Brazilian", alias: "brazilian"),
            Category(title: "Breakfast & Brunch", alias: "breakfast_brunch"),
            Category(title: "British", alias: "british"),
            Category(title: "Buffets", alias: "buffets"),
            Category(title: "Burgers", alias: "burgers"),
            Category(title: "Burmese", alias: "burmese"),
            Category(title: "Cafes", alias: "cafes"),
            Category(title: "Themed Cafes", alias: "themedcafes"),
            Category(title: "Cafeteria", alias: "cafeteria"),
            Category(title: "Cajun/Creole", alias: "cajun"),
            Category(title: "Cambodian", alias: "cambodian"),
            Category(title: "Caribbean", alias: "caribbean"),
            Category(title: "Dominican", alias: "dominican"),
            Category(title: "Haitian", alias: "haitian"),
            Category(title: "Puerto Rican", alias: "puertorican"),
            Category(title: "Trinidadian", alias: "trinidadian"),
            Category(title: "Catalan", alias: "catalan"),
            Category(title: "Cheesesteaks", alias: "cheesesteaks"),
            Category(title: "Chicken Shop", alias: "chickenshop"),
            Category(title: "Chicken Wings", alias: "chicken_wings"),
            Category(title: "Chinese", alias: "chinese"),
            Category(title: "Cantonese", alias: "cantonese"),
            Category(title: "Dim Sum", alias: "dimsum"),
            Category(title: "Hainan", alias: "hainan"),
            Category(title: "Shanghainese", alias: "shanghainese"),
            Category(title: "Szechuan", alias: "szechuan"),
            Category(title: "Comfort Food", alias: "comfortfood"),
            Category(title: "Creperies", alias: "creperies"),
            Category(title: "Cuban", alias: "cuban"),
            Category(title: "Czech", alias: "czech"),
            Category(title: "Delis", alias: "delis"),
            Category(title: "Diners", alias: "diners"),
            Category(title: "Dinner Theater", alias: "dinnertheater"),
            Category(title: "Ethiopian", alias: "ethiopian"),
            Category(title: "Fast Food", alias: "hotdogs"),
            Category(title: "Filipino", alias: "filipino"),
            Category(title: "Fish & Chips", alias: "fishnchips"),
            Category(title: "Fondue", alias: "fondue"),
            Category(title: "Food Court", alias: "food_court"),
            Category(title: "Food Stands", alias: "foodstands"),
            Category(title: "French", alias: "french"),
            Category(title: "Gastropubs", alias: "gastropubs"),
            Category(title: "German", alias: "german"),
            Category(title: "Gluten-Free", alias: "gluten_free"),
            Category(title: "Greek", alias: "greek"),
            Category(title: "Halal", alias: "halal"),
            Category(title: "Hawaiian", alias: "hawaiian"),
            Category(title: "Himalayan/Nepalese", alias: "himalayan"),
            Category(title: "Hong Kong Style Cafe", alias: "hkcafe"),
            Category(title: "Hot Dogs", alias: "hotdog"),
            Category(title: "Hot Pot", alias: "hotpot"),
            Category(title: "Hungarian", alias: "hungarian"),
            Category(title: "Iberian", alias: "iberian"),
            Category(title: "Indian", alias: "indpak"),
            Category(title: "Indonesian", alias: "indonesian"),
            Category(title: "Irish", alias: "irish"),
            Category(title: "Italian", alias: "italian"),
            Category(title: "Calabrian", alias: "calabrian"),
            Category(title: "Sardinian", alias: "sardinian"),
            Category(title: "Tuscan", alias: "tuscan"),
            Category(title: "Japanese", alias: "japanese"),
            Category(title: "Izakaya", alias: "izakaya"),
            Category(title: "Ramen", alias: "ramen"),
            Category(title: "Teppanyaki", alias: "teppanyaki"),
            Category(title: "Korean", alias: "korean"),
            Category(title: "Kosher", alias: "kosher"),
            Category(title: "Laotian", alias: "laotian"),
            Category(title: "Latin American", alias: "latin"),
            Category(title: "Colombian", alias: "colombian"),
            Category(title: "Salvadoran", alias: "salvadoran"),
            Category(title: "Venezuelan", alias: "venezuelan"),
            Category(title: "Live/Raw Food", alias: "raw_food"),
            Category(title: "Malaysian", alias: "malaysian"),
            Category(title: "Mediterranean", alias: "mediterranean"),
            Category(title: "Falafel", alias: "falafel"),
            Category(title: "Mexican", alias: "mexican"),
            Category(title: "Middle Eastern", alias: "mideastern"),
            Category(title: "Egyptian", alias: "egyptian"),
            Category(title: "Lebanese", alias: "lebanese"),
            Category(title: "Modern European", alias: "modern_european"),
            Category(title: "Mongolian", alias: "mongolian"),
            Category(title: "Moroccan", alias: "moroccan"),
            Category(title: "New Mexican Cuisine", alias: "newmexican"),
            Category(title: "Nicaraguan", alias: "nicaraguan"),
            Category(title: "Noodles", alias: "noodles"),
            Category(title: "Pakistani", alias: "pakistani"),
            Category(title: "Persian/Iranian", alias: "persian"),
            Category(title: "Peruvian", alias: "peruvian"),
            Category(title: "Pizza", alias: "pizza"),
            Category(title: "Polish", alias: "polish"),
            Category(title: "Pop-Up Restaurants", alias: "popuprestaurants"),
            Category(title: "Portuguese", alias: "portuguese"),
            Category(title: "Poutineries", alias: "poutineries"),
            Category(title: "Russian", alias: "russian"),
            Category(title: "Salad", alias: "salad"),
            Category(title: "Sandwiches", alias: "sandwiches"),
            Category(title: "Scandinavian", alias: "scandinavian"),
            Category(title: "Scottish", alias: "scottish"),
            Category(title: "Seafood", alias: "seafood"),
            Category(title: "Singaporean", alias: "singaporean"),
            Category(title: "Slovakian", alias: "slovakian"),
            Category(title: "Soul Food", alias: "soulfood"),
            Category(title: "Soup", alias: "soup"),
            Category(title: "Southern", alias: "southern"),
            Category(title: "Spanish", alias: "spanish"),
            Category(title: "Sri Lankan", alias: "srilankan"),
            Category(title: "Steakhouses", alias: "steak"),
            Category(title: "Supper Clubs", alias: "supperclubs"),
            Category(title: "Sushi Bars", alias: "sushi"),
            Category(title: "Syrian", alias: "syrian"),
            Category(title: "Taiwanese", alias: "taiwanese"),
            Category(title: "Tapas Bars", alias: "tapas"),
            Category(title: "Tapas/Small Plates", alias: "tapasmallplates"),
            Category(title: "Tex-Mex", alias: "tex-mex"),
            Category(title: "Thai", alias: "thai"),
            Category(title: "Turkish", alias: "turkish"),
            Category(title: "Ukrainian", alias: "ukrainian"),
            Category(title: "Uzbek", alias: "uzbek"),
            Category(title: "Vegan", alias: "vegan"),
            Category(title: "Vegetarian", alias: "vegetarian"),
            Category(title: "Vietnamese", alias: "vietnamese"),
            Category(title: "Waffles", alias: "waffles")
        ]
        
        return categories
    }
    
    static func getCount(for coordinates: Coordinates) -> Int {
        var count = 0
        //for each category
        //        call yelp to get results with location.
        return count
    }
}



