//
//  WeatherDetailsPresenter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

class WeatherDetailsPresenter {
    private weak var view: WeatherDetailsViewProtocol?
    private var router: WeatherDetailsRouterProtocol?
    private var interactor: WeatherDetailsInteractorProtocol?
    private var coordinates: Coordinates?
    
    private var timer: Timer?
    private var currentTimeOffset: TimeInterval?
    
    func configure(
        interactor: WeatherDetailsInteractorProtocol,
        view: WeatherDetailsViewProtocol,
        router: WeatherDetailsRouterProtocol,
        coordinates: Coordinates
    ) {
        self.coordinates    = coordinates
        self.interactor     = interactor
        self.view           = view
        self.router         = router
        
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        let currentDate     = Date()
        let nextMinuteDate  = Calendar.current.nextDate(after: currentDate, matching: DateComponents(second: 0), matchingPolicy: .nextTime)!
        let initialDelay    = nextMinuteDate.timeIntervalSince(currentDate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) { [weak self] in
            guard let self = self else { return }
            guard let coordinates = self.coordinates else { return }
            
            self.loadWeatherDetails(by: coordinates)
            self.timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.handleTimerTick), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func handleTimerTick() {
        guard let coordinates = self.coordinates else { return }
        
        loadWeatherDetails(by: coordinates)
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension WeatherDetailsPresenter: WeatherDetailsPresenterProtocol {
    func navigateToFullView() {
        guard let coordinates = self.coordinates else { return }
        
        router?.navigateToFullView(with: coordinates)
    }
    
    func viewDidLoad() {
        guard let coordinates = self.coordinates else { return }
        
        loadWeatherDetails(by: coordinates)
    }
    
    func loadWeatherDetails(by coordinates: Coordinates) {
        view?.showLoadingState()
        
        interactor?.fetchWeather(by: coordinates)
        interactor?.fetchTodayForecast(by: coordinates)
    }
}

extension WeatherDetailsPresenter: WeatherDetailsInteractorOutputProtocol {
    func handleFetchedForecast(with result: ForecastResponse) {
        guard let timeOffset = self.currentTimeOffset else { return }
        
        let currentDate = Date()

        var calendar        = Calendar.current
        calendar.timeZone   = TimeZone(abbreviation: "UTC")!
        
        let endOfDay        = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: currentDate)!

        let from    = currentDate.timeIntervalSince1970
        let to      = endOfDay.timeIntervalSince1970 - timeOffset
        
        view?.handleExpectedBadWeather(with: findNextBadWeather(from: Int(from), to: Int(to), timeOffset: timeOffset, forecasts: result.list))
    }
    
    private func findNextBadWeather(from: Int, to: Int, timeOffset: TimeInterval, forecasts: [ForecastResponse.Forecast]) -> ExpectedBadWeatherViewModel {
        for forecast in forecasts {
            if forecast.dt >= from && forecast.dt <= to {
                if let weather = forecast.weather.first(where: { $0.main.lowercased().contains("rain") || $0.main.lowercased().contains("snow") }) {
                    if (weather.main.lowercased().contains("snow")) {
                        return ExpectedBadWeatherViewModel.snow(iconPath: "heavy-snow", Date(timeIntervalSince1970: TimeInterval(forecast.dt)).addingTimeInterval(timeOffset))
                    }
                    
                    return ExpectedBadWeatherViewModel.rain(iconPath: "heavy-showers", Date(timeIntervalSince1970: TimeInterval(forecast.dt)).addingTimeInterval(timeOffset))
                }
            }
        }
        return ExpectedBadWeatherViewModel.none
    }
    
    func handleFetchedWeather(with result: CurrentWeatherResponse) {
        guard let weatherModel = result.weather.first else { return }
        
        self.currentTimeOffset = result.timezone
                
        let currentWeatherDetails = CurrentWeatherDetails(
            main: weatherModel.main,
            description: weatherModel.description,
            imagePath: mapWeatherIconToImagePath(icon: weatherModel.icon),
            temp: Int(result.main.temp.fromKelvinToCelsius()),
            tempFeelsLike: Int(result.main.feelsLike.fromKelvinToCelsius()),
            humidity: result.main.humidity,
            windSpeed: result.wind.speed,
            name: result.name ?? "Unknown location"
        )
        
        let sunriseTime = Date(timeIntervalSince1970: Double(result.sys.sunrise)).addingTimeInterval(result.timezone)
        let sunsetTime  = Date(timeIntervalSince1970: Double(result.sys.sunset)).addingTimeInterval(result.timezone)
        let currentDate = Date().addingTimeInterval(result.timezone)
  
        let calendar            = Calendar.current
        let daylightLength      = calendar.dateComponents([.hour, .minute], from: sunriseTime, to: sunsetTime)
        let remainingDaylight   = calendar.dateComponents([.hour, .minute], from: Date(), to: sunsetTime)
        
        let weatherDateInfo = WeatherDateInfo(
            sunriseDate: sunriseTime,
            sunsetDate: sunsetTime,
            currentDate: currentDate,
            daylightLength: daylightLength,
            remainingDaylight: remainingDaylight,
            timezone: result.timezone
        )
        
        view?.showLoadedState(currentWeatherDetails: currentWeatherDetails, weatherDateInfo: weatherDateInfo)
    }
    
    func handleFailedToFetchWeather() {
        view?.showFailedToLoadState()
    }
    
    private func mapWeatherIconToImagePath(icon: String) -> String {
        switch icon {
        case "01d":
            return "clear-day"
        case "01n":
            return "clear-night"
        case "02d":
            return "partly-cloudy-day"
        case "02n":
            return "partly-cloudy-night"
        case "03d", "03n":
            return "cloudy"
        case "04d", "04n":
            return "cloudy"
        case "09d", "09n":
            return "showers"
        case "10d", "10n":
            return "heavy-showers"
        case "11d", "11n":
            return "thunderstorm-showers"
        case "13d", "13n":
            return "heavy-show"
        case "50d", "50n":
            return "fog"
        default:
            return "clear-day"
        }
    }
}

