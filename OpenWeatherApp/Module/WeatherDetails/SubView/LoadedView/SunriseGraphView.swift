//
//  SunriseGraphView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 11.06.2024.
//

import UIKit

class SunriseGraphView: UIView {
    
    private let titleLabel: UILabel             = UILabel()
    private let remainingDaylightLabel: UILabel = UILabel()
    private let lengthOfDaylightLabel: UILabel  = UILabel()
    private let sunGraphView: SunGraphView      = SunGraphView()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(with weatherDateInfo: WeatherDateInfo) {
        if let hours = weatherDateInfo.daylightLength.hour, let minutes = weatherDateInfo.daylightLength.minute {
            lengthOfDaylightLabel.attributedText = createDaylightAttributedText(title: "Length of day", value: "\(hours)H \(minutes)M")
        }
        
        if let hours = weatherDateInfo.remainingDaylight.hour, let minutes = weatherDateInfo.remainingDaylight.minute {
            remainingDaylightLabel.attributedText = createDaylightAttributedText(title: "Remaining dayllight", value: "\(hours)H \(minutes)M")
        }
        
        sunGraphView.configure(
            sunriseDate: weatherDateInfo.sunriseDate,
            sunsetDate: weatherDateInfo.sunsetDate,
            currentDate: weatherDateInfo.currentDate,
            timezone: weatherDateInfo.timezone
        )
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .secondarySystemBackground
        layer.cornerRadius                          = 11
        
        configureTitleLabel()
        configureRemainingDaylightLabel()
        configureLenghtOfDaylightLabel()
        configureSunGraphView()
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        titleLabel.font                                         = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor                                    = .systemGray2
        titleLabel.text                                         = "SUNRISE & SUNSET"
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        ])
    }
    
    private func configureRemainingDaylightLabel() {
        remainingDaylightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(remainingDaylightLabel)
        
        NSLayoutConstraint.activate([
            remainingDaylightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            remainingDaylightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    
    private func configureLenghtOfDaylightLabel() {
        lengthOfDaylightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lengthOfDaylightLabel)
        
        NSLayoutConstraint.activate([
            lengthOfDaylightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lengthOfDaylightLabel.bottomAnchor.constraint(equalTo: remainingDaylightLabel.topAnchor, constant: -15)
        ])
    }
    
    private func configureSunGraphView() {
        sunGraphView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sunGraphView)
        
        NSLayoutConstraint.activate([
            sunGraphView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            sunGraphView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            sunGraphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            sunGraphView.bottomAnchor.constraint(equalTo: lengthOfDaylightLabel.topAnchor, constant: -10)
        ])
    }
    
    private func createDaylightAttributedText(title: String, value: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(title): ", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.systemGray2
        ])
        
        let attributedValue = NSMutableAttributedString(string: value, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.label
        ])
        
        attributedTitle.append(attributedValue)
        
        return attributedTitle
    }
}

fileprivate class SunGraphView: UIView {
    private let sunPartStartX : CGFloat     = 70
    private let moonPartMaxY : CGFloat      = 30
    private let sunPartMaxY  : CGFloat      = 50
    
    private var timezone: Double?
    private var sunsetDate: Date?
    private var sunriseDate: Date?
    private var currentDate: Date?
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let width   = rect.width
        let height  = rect.height
        
        let dashPattern: [CGFloat]  = [4, 4]
        let horizonY: CGFloat       = 2 * (height / 3)
        
        let beforeSunrisePath = UIBezierPath()
        beforeSunrisePath.move(to: CGPoint(x: 0, y: horizonY + moonPartMaxY))
        beforeSunrisePath.addQuadCurve(to: CGPoint(x: sunPartStartX, y: horizonY), controlPoint: CGPoint(x: sunPartStartX/2, y: horizonY + moonPartMaxY))
        beforeSunrisePath.addLine(to: CGPoint(x: 0, y: horizonY))
        beforeSunrisePath.addLine(to: CGPoint(x: 0, y: moonPartMaxY))
        
        context.setFillColor(UIColor(hex: "001F70").cgColor)
        context.addPath(beforeSunrisePath.cgPath)
        context.fillPath()
        
        let daylightPath = UIBezierPath()
        daylightPath.move(to: CGPoint(x: sunPartStartX, y: horizonY))
        daylightPath.addQuadCurve(to: CGPoint(x: width - sunPartStartX, y: horizonY), controlPoint: CGPoint(x: width / 2, y: -sunPartMaxY))
        
        context.setFillColor(UIColor(hex: "7CC9F2").cgColor)
        context.addPath(daylightPath.cgPath)
        context.fillPath()
        
        let afterSunsetPath = UIBezierPath()
        afterSunsetPath.move(to: CGPoint(x: width, y: horizonY + moonPartMaxY))
        afterSunsetPath.addQuadCurve(to: CGPoint(x: width - sunPartStartX, y: horizonY), controlPoint: CGPoint(x: (width - sunPartStartX/2), y: horizonY + moonPartMaxY))
        afterSunsetPath.addLine(to: CGPoint(x: width, y: horizonY))
        afterSunsetPath.addLine(to: CGPoint(x: width, y: horizonY + moonPartMaxY))
        
        context.setFillColor(UIColor(hex: "001F70").cgColor)
        context.addPath(afterSunsetPath.cgPath)
        context.fillPath()
        
        let horizonLinePath = UIBezierPath()
        horizonLinePath.move(to: CGPoint(x: 0, y: horizonY))
        horizonLinePath.addLine(to: CGPoint(x: width, y: horizonY))
        
        context.setStrokeColor(UIColor.systemGray2.cgColor)
        context.setLineWidth(1)
        context.setLineDash(phase: 0, lengths: dashPattern)
        
        context.addPath(horizonLinePath.cgPath)
        context.strokePath()
        
        let sunriseLinePath = UIBezierPath()
        sunriseLinePath.move(to: CGPoint(x: sunPartStartX, y: horizonY))
        sunriseLinePath.addLine(to: CGPoint(x: sunPartStartX, y: horizonY - sunPartMaxY + 5))
        
        context.addPath(sunriseLinePath.cgPath)
        context.strokePath()
        
        let sunsetLinePath = UIBezierPath()
        sunsetLinePath.move(to: CGPoint(x: width - sunPartStartX, y: horizonY))
        sunsetLinePath.addLine(to: CGPoint(x: width - sunPartStartX, y: horizonY - sunPartMaxY + 5))
        
        context.addPath(sunsetLinePath.cgPath)
        context.strokePath()
        
        guard let sunriseDate = self.sunriseDate, let sunsetDate = self.sunsetDate else { return }
        
        let sunriseFormattedDate    = DateUtils.getHHMMformattedDate(date: sunriseDate)
        let sunsetFormattedDate     = DateUtils.getHHMMformattedDate(date: sunsetDate)
        
        let timeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.systemGray,
        ]
        
        let labelAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.systemGray2
        ]
        
        let sunriseLabelRect = CGRect(x: sunPartStartX/2 + 10, y: horizonY - sunPartMaxY - 25, width: 60, height: 20)
        let sunriseTimeRect = CGRect(x: sunPartStartX/2, y: horizonY - sunPartMaxY - 10, width: 60, height: 20)
        
        NSLocalizedString("sunrise_title", comment: "").draw(in: sunriseLabelRect, withAttributes: labelAttributes)
        sunriseFormattedDate.draw(in: sunriseTimeRect, withAttributes: timeAttributes)
        
        let sunsetLabelRect = CGRect(x: width - sunPartStartX - 10, y: horizonY - sunPartMaxY - 25, width: 60, height: 20)
        let sunsetTimeRect = CGRect(x: width - sunPartStartX - 20, y: horizonY - sunPartMaxY - 10, width: 60, height: 20)
        
        NSLocalizedString("sunset_title", comment: "").draw(in: sunsetLabelRect, withAttributes: labelAttributes)
        sunsetFormattedDate.draw(in: sunsetTimeRect, withAttributes: timeAttributes)
        
        guard let positionedIndicator = calculateIndicatorPosition(width: width, horizonY: horizonY) else { return }
        
        let indicatorRadius: CGFloat = 6.0
        
        switch positionedIndicator.state {
        case .moon:
            context.setFillColor(UIColor.systemGray4.cgColor)
        case .sun:
            context.setFillColor(UIColor.systemYellow.cgColor)
        }
        
        context.fillEllipse(in: CGRect(x: positionedIndicator.x, y: positionedIndicator.y, width: 2 * indicatorRadius, height: 2 * indicatorRadius))
    }
    
    func configure(sunriseDate: Date, sunsetDate: Date, currentDate: Date, timezone: Double) {
        self.sunriseDate    = sunriseDate
        self.sunsetDate     = sunsetDate
        self.currentDate    = currentDate
        self.timezone       = timezone
        
        self.setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func calculateIndicatorPosition(width: CGFloat, horizonY: CGFloat) -> PositionedIndicator? {
        guard let currentDate = self.currentDate, let sunriseDate = self.sunriseDate, let sunsetDate = self.sunsetDate, let timezone = self.timezone else { return nil }
        
        let totalDayTime = sunsetDate.timeIntervalSince(sunriseDate)
        let currentTimeInterval = currentDate.timeIntervalSince(sunriseDate)
        
        if currentDate < sunriseDate {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(secondsFromGMT: Int(timezone))!
            
            let startDay = calendar.startOfDay(for: sunsetDate).addingTimeInterval(timezone)
            let sunPositionRatio = CGFloat((currentDate.timeIntervalSince1970 - startDay.timeIntervalSince1970) / (sunriseDate.timeIntervalSince1970 - startDay.timeIntervalSince1970))
            let sunPositionX = sunPositionRatio * sunPartStartX
            let sunPositionY = horizonY + moonPartMaxY - ((horizonY + moonPartMaxY - horizonY) * sunPositionRatio)
            
            return PositionedIndicator(state: .moon, x: sunPositionX, y: sunPositionY)
        } else if currentDate > sunsetDate {
            let sunPositionRatio = CGFloat((currentDate.timeIntervalSince1970 - sunsetDate.timeIntervalSince1970) / (24 * 60 * 60 - sunsetDate.timeIntervalSince1970))
            let sunPositionX = width - sunPartStartX + sunPositionRatio * sunPartStartX
            let sunPositionY = horizonY + moonPartMaxY - ((horizonY + moonPartMaxY - horizonY) * sunPositionRatio)
            return PositionedIndicator(state: .moon, x: sunPositionX, y: sunPositionY)
        } else {
            let sunPositionRatio = CGFloat(currentTimeInterval / totalDayTime)
            let sunPositionX = sunPartStartX + sunPositionRatio * (width - 2 * sunPartStartX)
            let sunPositionY = horizonY - sunPartMaxY + ((horizonY - (horizonY - sunPartMaxY)) * sunPositionRatio)
            return PositionedIndicator(state: .sun, x: sunPositionX, y: sunPositionY)
        }
    }
}

fileprivate struct PositionedIndicator {
    let state: IndicatorState
    let x: CGFloat
    let y: CGFloat
}

fileprivate enum IndicatorState {
    case moon
    case sun
}
