//
//  HomeView.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI
import Combine



struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View{
        VStack{
            
            ZStack{
                FPImage.titleLogo.image().resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 25, alignment: .center)
            }
            .frame(width: Screen.width, height: 44, alignment: .center)
            .background(Color.white)
            
            List{
                ForEach(viewModel.cards){ (card) in
                    self.containedView(designType: card.designType ?? .HC1, cardElement: card)
                        .background(Color(hex: "#F7F6F3"))
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                               Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                           })
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
        }
    }
    
    func containedView(designType: DesignType, cardElement: CardElement) -> AnyView {
        switch designType {
        case .HC3: return AnyView(HC3View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC6: return AnyView(HC6View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC5: return AnyView(HC5View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC4: return AnyView(HC4View(cardElement: cardElement,openURL: self.viewModel.openURL))
        case .HC1: return AnyView(HC1View(cardElement: cardElement,openURL: self.viewModel.openURL))
        }
    }
}

final class HomeViewModel: ObservableObject{
    
    typealias Dependencies = HasAPI
    private var dependecies: Dependencies
    
    private var cancellables: [AnyCancellable] = []

    //Init
    init(dependecies: Dependencies){
        self.dependecies = dependecies
        self.bindInputs()
        self.bindOutputs()
    }
    

    // MARK: Input
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    let openURL = PassthroughSubject<String, Never>()
    
    // MARK: Output
    @Published private(set) var cards: Cards = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published private(set) var shouldShowIcon = false
    
    private let responseSubject = PassthroughSubject<[CardElement], Never>()
    private let errorSubject = PassthroughSubject<APIError, Never>()
    
    //    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    //    private let apiService: APIServiceType
    //    private let trackerService: TrackerType
    //    private let experimentService: ExperimentServiceType
    
    private func bindInputs() {
        
        let responsePublisher = onAppearSubject
            .flatMap {  _ in
                self.dependecies.api.callRequest(.getUIComponent([:]), parseTo: [CardElement].self)
                    .catch { [weak self] error -> Empty<Cards, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        let openURLStream: AnyCancellable = self.openURL.sink { (url) in
            print(url)
        }
        
        cancellables += [
            responseStream,
            openURLStream
        ]
    }
    
    private func bindOutputs() {
        let cardStream = responseSubject
            .map { $0 }
            .assign(to: \.cards, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .error(let message): return message
                case .offline(let message): return message
                case .notParable(let message): return message
                }
        }
        .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
        
        cancellables += [
            cardStream,
            errorStream,
            errorMessageStream,
        ]
    }
}
