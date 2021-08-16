//
//  Stargazer.swift
//  Stargazers
//
//  Created by Luigi Audino on 09/08/21.
//

import Foundation

struct Stargazer: Codable {
    private var _login: String
    private var _id: Int
    private var _node_id: String
    private var _avatar_url: String
    private var _gravatar_id: String
    private var _url: String
    private var _html_url: String
    private var _followers_url: String
    private var _following_url: String
    private var _gists_url: String
    private var _starred_url: String
    private var _subscriptions_url: String
    private var _organizations_url: String
    private var _repos_url: String
    private var _events_url: String
    private var _received_events_url: String
    private var _type: String
    private var _site_admin: Bool
    
    enum CodingKeys: String, CodingKey {
        case _login = "login"
        case _id = "id"
        case _node_id = "node_id"
        case _avatar_url = "avatar_url"
        case _gravatar_id = "gravatar_id"
        case _url = "url"
        case _html_url = "html_url"
        case _followers_url = "followers_url"
        case _following_url = "following_url"
        case _gists_url = "gists_url"
        case _starred_url = "starred_url"
        case _subscriptions_url = "subscriptions_url"
        case _organizations_url = "organizations_url"
        case _repos_url = "repos_url"
        case _events_url = "events_url"
        case _received_events_url = "received_events_url"
        case _type = "type"
        case _site_admin = "site_admin"
    }
    
    var login: String {
        get {
            return _login
        }
        set {
            _login = newValue
        }
    }
    
    var id: Int {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var node_id: String {
        get {
            return _node_id
        }
        set {
            _node_id = newValue
        }
    }
    
    
    var avatar_url: String {
        get {
            return _avatar_url
        }
        set {
            _avatar_url = newValue
        }
    }
    
    
    var gravatar_id: String {
        get {
            return _gravatar_id
        }
        set {
            _gravatar_id = newValue
        }
    }
    
    
    var url: String {
        get {
            return _url
        }
        set {
            _url = newValue
        }
    }
    
    
    var html_url: String {
        get {
            return _html_url
        }
        set {
            _html_url = newValue
        }
    }
    
    
    var followers_url: String {
        get {
            return _followers_url
        }
        set {
            _followers_url = newValue
        }
    }
    
    
    var following_url: String {
        get {
            return _following_url
        }
        set {
            _following_url = newValue
        }
    }
    
    
    var gists_url: String {
        get {
            return _gists_url
        }
        set {
            _gists_url = newValue
        }
    }
    
    
    var starred_url: String {
        get {
            return _starred_url
        }
        set {
            _starred_url = newValue
        }
    }
    
    
    var subscriptions_url: String {
        get {
            return _subscriptions_url
        }
        set {
            _subscriptions_url = newValue
        }
    }
    
    
    var organizations_url: String {
        get {
            return _organizations_url
        }
        set {
            _organizations_url = newValue
        }
    }
    
    
    var repos_url: String {
        get {
            return _repos_url
        }
        set {
            _repos_url = newValue
        }
    }
    
    
    var events_url: String {
        get {
            return _events_url
        }
        set {
            _events_url = newValue
        }
    }
    
    var received_events_url: String {
        get {
            return _received_events_url
        }
        set {
            _received_events_url = newValue
        }
    }
    
    
    var type: String {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    
    var site_admin: Bool {
        get {
            return _site_admin
        }
        set {
            _site_admin = newValue
        }
    }
    
}
