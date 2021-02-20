//
//  CountryWidget.swift
//  CountryWidget
//
//  Created by Mubarak Sadoon on 2021-02-20.
//

import WidgetKit
import SwiftUI

struct Country {
    let name: String
    let capital: String
}

struct CountryProvider: TimelineProvider {
    static let sampleData = Country(name: "United Kingdom", capital: "London")
    
    func placeholder(in context: Context) -> CountryEntry {
        CountryEntry(date: Date(), country: CountryProvider.sampleData)
    }

    func getSnapshot(in context: Context, completion: @escaping (CountryEntry) -> ()) {
        let country: Country
        
        if context.isPreview {
            country = CountryProvider.sampleData
        } else {
            country = loadCountries().first ?? CountryProvider.sampleData
        }
        
        let entry = CountryEntry(date: Date(), country: country)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountryEntry>) -> ()) {
        var entries: [CountryEntry] = []

        let countries = loadCountries()
        let currentDate = Date()
        var dayOffset = 0
        
        for country in countries {
            let entryDate = Calendar.current.date(byAdding: .second, value: dayOffset, to: currentDate)!
            let entry = CountryEntry(date: entryDate, country: country)
            entries.append(entry)
            dayOffset += 1
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func loadCountries() -> [Country] {
        let uk = Country(name: "United Kingdom", capital: "London")
        let canada = Country(name: "Canada", capital: "Toronto")
        let usa = Country(name: "USA", capital: "Washington")
        let mexico = Country(name: "Mexico", capital: "Mexico City")
        let brazil = Country(name: "Brazil", capital: "Sao Paulo")
        
        return [uk, canada, usa, mexico, brazil]
    }
}

struct CountryEntry: TimelineEntry {
    var date: Date
    var country: Country
}

struct CountryWidgetEntryView : View {
    var entry: CountryEntry

    var body: some View {
        CountryView(country: entry.country)
    }
}

struct CountryView: View {
    let country: Country
    
    var body: some View {
        Label(country.name, image: "")
        Label(country.capital, image: "")
    }
}

@main
struct CountryWidget: Widget {
    let kind: String = "CountryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountryProvider()) { entry in
            CountryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Country of the day")
        .description("Show a new country every day")
        .supportedFamilies([.systemLarge])
        .onBackgroundURLSessionEvents { (identifier, completion) in
            // handle event
        }
    }
}

struct CountryWidget_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: CountryProvider.sampleData)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
