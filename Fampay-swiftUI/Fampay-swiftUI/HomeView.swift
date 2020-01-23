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
        NavigationView{
            List{
                ForEach(viewModel.cards){ (card) in
                    self.containedView(designType: card.designType ?? .HC1, cardElement: card).background(Color.gray).listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
        }
    }
    
    func containedView(designType: DesignType, cardElement: CardElement) -> AnyView {
        switch designType {
        case .HC3: return AnyView(HC3View(cardElement: cardElement))
        case .HC6: return AnyView(HC6View(cardElement: cardElement))
        case .HC5: return AnyView(HC5View(cardElement: cardElement))
        default: return AnyView(Text(cardElement.name ?? ""))
        }
    }
}

final class HomeViewModel: ObservableObject{
    
    private var cancellables: [AnyCancellable] = []
    
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
    
    init() {
        self.bindInputs()
        self.bindOutputs()
    }
    
    
    private func bindInputs() {
        
        let responsePublisher = onAppearSubject
            .flatMap { _ in
                APIManager.shared.callRequest(.getUIComponent([:]), parseTo: [CardElement].self)
                    .catch { [weak self] error -> Empty<Cards, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        cancellables += [
            responseStream
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
