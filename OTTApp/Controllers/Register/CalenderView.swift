//
//  CalenderView.swift
//  Calender
//
//  Created by SaiKiran Panuganti on 17/09/21.
//

import UIKit

protocol CalenderViewDelegate: AnyObject {
    func dateSelected(date: Date?)
}

class CalenderView : UIView {
    private var selectedDate = Date()
    private var totalSquares: [DayModel] = []
    private let daysArray: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    private var todayDate: Int = 0
    
    weak var delegate: CalenderViewDelegate?
    
    var previousImage: UIImage? {
        didSet {
            if let image = previousImage {
                previousImageView.image = image
            }
        }
    }
    
    var nextImage: UIImage? {
        didSet {
            if let image = nextImage {
                nextImageView.image = image
            }
        }
    }
    
    lazy private var previousImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.leftIcon?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy private var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.shared.rightIcon?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy private var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var monthYearStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy private var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy private var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy private var daysStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        return stackView
    }()
    
    lazy private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalenderCollectionViewCell.self, forCellWithReuseIdentifier: "CalenderCollectionViewCell")
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        addSubViews()
        addSubViewConstraints()
        getTodaysData()
        setMonthView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor.black
        addSubViews()
        addSubViewConstraints()
        getTodaysData()
        setMonthView()
    }
    
    private func addSubViews() {
        addSubview(previousImageView)
        addSubview(nextImageView)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(monthYearStack)
        monthYearStack.addArrangedSubview(monthLabel)
        monthYearStack.addArrangedSubview(yearLabel)
        addSubview(daysStack)
        for i in 0..<7 {
            let label = UILabel()
            label.text = daysArray[i]
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
            label.textAlignment = .center
            daysStack.addArrangedSubview(label)
        }
        addSubview(collectionView)
    }
    
    private func addSubViewConstraints() {
        monthYearStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        monthYearStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        monthYearStack.widthAnchor.constraint(equalToConstant: frame.width - 140).isActive = true
        
        previousImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        previousImageView.centerYAnchor.constraint(equalTo: monthYearStack.centerYAnchor).isActive = true
        previousImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        previousImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        previousButton.centerXAnchor.constraint(equalTo: previousImageView.centerXAnchor, constant: 0).isActive = true
        previousButton.centerYAnchor.constraint(equalTo: previousImageView.centerYAnchor, constant: 0).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nextImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        nextImageView.centerYAnchor.constraint(equalTo: monthYearStack.centerYAnchor).isActive = true
        nextImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        nextImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nextButton.centerXAnchor.constraint(equalTo: nextImageView.centerXAnchor, constant: 0).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: nextImageView.centerYAnchor, constant: 0).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        daysStack.topAnchor.constraint(equalTo: monthYearStack.bottomAnchor, constant: 5).isActive = true
        daysStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        daysStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        daysStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: daysStack.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
    }
    
    private func getTodaysData() {
        todayDate = CalendarHelper().dayOfMonth(date: Date())
    }
    
    private func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append(DayModel(day: "", date: nil))
            }else {
                let date = Calendar.current.date(byAdding: .day, value: count - startingSpaces - 1, to: firstDayOfMonth)
                totalSquares.append(DayModel(day: String(count - startingSpaces), date: date))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    @objc private func previousTapped(_ sender: UIButton) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @objc  private func nextTapped(_ sender: UIButton) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
}

extension CalenderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionViewCell", for: indexPath) as? CalenderCollectionViewCell {
            
            if let isToday = totalSquares[indexPath.item].date?.isToday() {
                cell.configureUI(dayModel: totalSquares[indexPath.item], isToday: isToday)
            }else {
                cell.configureUI(dayModel: totalSquares[indexPath.item], isToday: false)
            }
            
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CalenderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        if totalSquares[indexPath.row].date == nil {
            return false
        } else {
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.dateSelected(date: totalSquares[indexPath.row].date)
    }
}

extension CalenderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width) / 7, height: (collectionView.frame.size.height) / 7)
    }
}

fileprivate struct DayModel {
    let day: String
    let date: Date?
}


fileprivate class CalendarHelper {
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    
}


extension Date {
    fileprivate func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY, HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    fileprivate func isToday() ->  Bool {
        return Calendar.current.isDateInToday(self)
    }
}


fileprivate class CalenderCollectionViewCell: UICollectionViewCell {

    lazy private var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        addSubViewConstraints()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(roundedView)
        addSubview(dateLabel)
    }
    
    private func addSubViewConstraints() {
        roundedView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        roundedView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let lowerValue = (frame.height < frame.width) ? frame.height : frame.width
        roundedView.widthAnchor.constraint(equalToConstant: lowerValue-5).isActive = true
        roundedView.heightAnchor.constraint(equalToConstant: lowerValue-5).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: roundedView.widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: roundedView.heightAnchor).isActive = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedView == self {
            self.roundedView.layer.borderColor = UIColor.clear.cgColor
            self.roundedView.layer.borderWidth = 0
        } else if context.nextFocusedView == self {
            self.roundedView.layer.borderColor =  #colorLiteral(red: 1, green: 0.8901960784, blue: 0, alpha: 1)
            self.roundedView.layer.borderWidth = 2
        }
    }
    
    private func setUpUI() {
        let radius = (frame.height < frame.width) ? frame.height : frame.width
        print(radius)
        roundedView.layer.cornerRadius = (radius-5)/2
    }
    
    fileprivate func configureUI(dayModel: DayModel, isToday: Bool) {
        if isToday {
            roundedView.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0, alpha: 1)
            dateLabel.textColor = .black
        }else {
            roundedView.backgroundColor = UIColor.clear
            dateLabel.textColor = .white
        }
        
        dateLabel.text = dayModel.day
    }
}
