매일메일

매일 해야하는 메이플할일들을 정리해주고 메이플 관련 유용한 기능을 제공하는 어플리케이션

개발기간

24.09.21 ~ 24.10.05

기술스택

SwiftUI, Combine, MVVM, Alamofire, Realm

기술스택 관련 기능

MVVM: Input, Output 패턴 적용
Combine: ViewModel DataBinding 적용
Alamofire: API Response
Realm: DB

기능설명

대표 캐릭터 조회 화면

대표캐릭터를 지정하여 대표캐릭터의 다양한 정보를 조회할 수 있습니다.

캐릭터 검색 화면

다른 캐릭터를 닉네임 기반으로 검색하여 캐릭터 정보를 조회할 수 있습니다.

메할일 화면

게임 내에서 수행해야하는 일간 및 주간 퀘스트들을 추가하거나 사용자가 입력하여 일정에 등록할 수 있습니다.
등록된 일정은 매일 혹은 매주 초기화 됩니다.

이벤트 화면

게임 내에서 제공되는 공지사항, 업데이트, 이벤트 등의 정보를 제공하는 화면입니다.
제목을 클릭하여 상세 페이지를 모바일 버전으로 확인할 수 있습니다.

트러블슈팅

완료된 퀘스트를 매일 자정 및 매주 월요일에 초기화 시켜주는 문제

퀘스트를 등록하는 시점에서 다음날 자정 혹은 다음주 월요일 자정을 구하는 메서드를 구현하여 endDate라는 프로퍼티로 저장하였고,
View의 task를 통해 endDate와 현재시간을 비교, 완료된 퀘스트들 중 endDate가 현재 시간보다 과거일 경우 endDate를 업데이트 하도록 로직을 구현하였다.
extension Date {
  ...
    public func nextDay() -> Date {
        let calender = Calendar.current
        let now = Date()
        guard let tomorrow = calender.date(byAdding: .day, value: 1, to: now) else { return now }
        let components = calender.dateComponents([.year, .month, .day], from: tomorrow)
        guard let nextMidnight = calender.date(from: components) else { return now }
        return nextMidnight
    }
    public func nextMonday() -> Date {
        let calender = Calendar.current
        let now = Date()
        let nextMonday = calender.nextDate(after: now, matching: DateComponents(weekday: 2), matchingPolicy: .nextTime)
        return nextMonday ?? Date()
    }
    ...
}

    
