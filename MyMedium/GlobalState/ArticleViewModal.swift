//
//  ArticleViewModal.swift
//  Conduit
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
import SwiftUI

class ArticleViewModel: ObservableObject {
    @Published var tagList: ArticleTag? = nil
    @Published var articleData: TrendingArticles? = TrendingArticles(articles: [], articlesCount: 0)
    @Published var showFlitterScreen: Bool = false
    @Published var isLoading = true
    @Published var flitterParameters: ArticleListParams = ArticleListParams(limit: "10", offset: "0")

    @Published var selectedArticle: Article = DummyData().data
    @Published var comments: CommentListResponse?

    private let articleServices: ArticleServicesProtocol
    private let commentsServices: CommentsServicesProtocol
    private let favoritesServices: FavoritesServicesProtocol

    init(articleServices: ArticleServicesProtocol = ArticleServices(),
         commentsServices: CommentsServicesProtocol = CommentsServices(),
         favoritesServices: FavoritesServicesProtocol = FavoritesServices()) {
        self.articleServices = articleServices
        self.commentsServices = commentsServices
        self.favoritesServices = favoritesServices
        getArticles()
        getTags()
    }
    
    
    func getComments () {
        commentsServices.getComments(parameters: nil,
                                       endpoint:
                selectedArticle.slug! + "/comments", completion: {
            res in
            switch res {
            case .success(let data):
                self.comments = data
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        })
    }
    
    func createFlitter () {
        flitterParameters = ArticleListParams(limit: "10", offset: "0")
        getArticles()
    }
    
    func getTags() {
        articleServices.getTags(parameters: nil){
            result in
            switch result {
            case .success(let data):
                self.tagList = data
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func canLoadMoreArticle () -> Bool {
        if(self.articleData != nil && self.articleData?.articlesCount ?? 0 > self.articleData?.articles?.count ?? 0){
            return true
        }
        return false
    }
    
    func getArticles() {
        print(flitterParameters.toDictionary())
        isLoading = true
        articleServices.getTrendingArticle(parameters: flitterParameters.toDictionary()){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                self.articleData?.articlesCount = data.articlesCount
                self.articleData?.articles?.append(contentsOf: data.articles!)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func resetArticleList () {
        articleData = TrendingArticles(articles: [],articlesCount: 0)
    }
    
    func reloadArticles () {
        resetArticleList()
        flitterParameters = ArticleListParams(limit: "10", offset: "0")
        getArticles()
    }
    
    
    func bookMarkArticle (onComplete: @escaping (Article?,String?) -> Void) {
        favoritesServices.bookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                onComplete(data.article!,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                    onComplete(nil,errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func updateSelectedArticle (article: Article)  {
         self.selectedArticle = article
        if let row = articleData?.articles!.firstIndex(where: {$0.slug == self.selectedArticle.slug}) {
            articleData?.articles?[row] = article
        }
    }
    
    
    func removeBookMarkArticle (onComplete: @escaping (Article?,String?) -> Void) {
        favoritesServices.removeBookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                onComplete(data.article!,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                    onComplete(nil,errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func getSignalArticle()  {
        articleServices.getSignalArticle(parameters: nil, endpoint: selectedArticle.slug!, completion: { res in
            switch res {
            case .success(let data):
                self.selectedArticle = data.article!
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        })
    }
    
}
