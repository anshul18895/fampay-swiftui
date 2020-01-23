//
//  Model.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation

typealias Cards = [CardElement]

// MARK: - CardElement
struct CardElement: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let name: String?
    let designType: DesignType?
    let cardType: Int?
    let cards: [Card]?
    let isScrollable: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case designType = "design_type"
        case cardType = "card_type"
        case cards
        case isScrollable = "is_scrollable"
    }
}

// MARK: - DesignType
public enum DesignType: String, Codable, Hashable {
    /// Small display card.
    case HC1
    /// Big display card.
    case HC3
    /// Center card.
    case HC4
    /// Only image card.
    case HC5
    /// Small card with arrow.
    case HC6
}

// MARK: - Card
struct Card: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let name, title: String?
    let formattedTitle: Formatted?
    let cardDescription: String?
    let formattedDescription: Formatted?
    let url: String?
    let bgImage: BgImage?
    let bgColor: String?
    let cta: [Cta]?
    let icon: BgImage?
    let bgGradient: BgGradient?

    var isFormatedTitle: Bool{
        return formattedTitle != nil
    }
    var isFormatedDesc: Bool{
        return formattedDescription != nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name, title
        case formattedTitle = "formatted_title"
        case cardDescription = "description"
        case formattedDescription = "formatted_description"
        case url
        case bgImage = "bg_image"
        case bgColor = "bg_color"
        case cta, icon
        case bgGradient = "bg_gradient"
    }
}

// MARK: - BgGradient
struct BgGradient: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let angle: Int?
    let colors: [String]?
}

// MARK: - BgImage
struct BgImage: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let imageType: String?
    let imageURL: String?
    let assetType: String?

    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case imageURL = "image_url"
        case assetType = "asset_type"
    }
}

// MARK: - Cta
struct Cta: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let text, bgColor, textColor: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case text
        case bgColor = "bg_color"
        case textColor = "text_color"
        case url
    }
}

// MARK: - Formatted
struct Formatted: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let text: String?
    let entities: [Entity]?
    
    func getSepratedStrings() -> [String]{
        (self.replacingOccurenceWithIndex()?.components(separatedBy: "[seprator]") ?? []).filter({$0 != ""})
    }
    
    private func replacingOccurenceWithIndex() -> String?{
        return text?.replacingOccurrences(of: "{}", with: "[seprator]{}[seprator]")
    }
    
}

// MARK: - Entity
struct Entity: Decodable, Identifiable {
    var id: String? = UUID().uuidString
    let text, type, color: String?
    let url: String?
}


