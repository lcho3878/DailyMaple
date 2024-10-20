# 매일메일(DailyMaple)
매일 해야하는 메이플할일들을 정리해주고 메이플 관련 유용한 기능을 제공하는 어플리케이션
<br><br>
<a href="https://apps.apple.com/kr/app/%EB%A7%A4%EC%9D%BC%EB%A9%94%EC%9D%BC/id6720724199"><img src="https://github.com/user-attachments/assets/fec00c75-3918-4be6-80f8-d7ae92f32c77" width="200" height="200"/></a>
<br><br>

## 🗓️ 개발기간

24.09.21 ~ 24.10.05

## 📷 스크린샷

|대표캐릭터 조회 및 검색 화면|하이퍼 스텟/어빌리티 조회 화면|착용 장비 화면|장비 상세 화면|
|:-:|:-:|:-:|:-:|
|<img src="https://github.com/user-attachments/assets/2a45c026-ea9c-4e76-9d1a-505396dd3e40" width="150"/>|<img src="https://github.com/user-attachments/assets/3d7f40bf-fac8-4df1-9b50-e4a25383b870" width="150"/>|<img src="https://github.com/user-attachments/assets/d0ec9edc-6a98-47f1-97dc-051d526e6059" width="150"/>|<img src="https://github.com/user-attachments/assets/4ad5770e-4a6a-42b4-8ca0-f8c916273488" width="150"/>|
|메할일 화면|퀘스트 목록 화면|공지사항 화면|공지사항 상세 화면|
|<img src="https://github.com/user-attachments/assets/43debc13-6363-48a3-8d2b-3fe27c504082" width="150"/>|<img src="https://github.com/user-attachments/assets/b2be5cdc-dc3b-495e-b1c3-ca7b812378a2" width="150"/>|<img src="https://github.com/user-attachments/assets/fa83dfe3-4f22-47ee-9cb4-b48b1d96ee88" width="150"/>|<img src="https://github.com/user-attachments/assets/74c06a20-2b2e-4ed1-bdfe-44767fbbcf5d" width="150"/>|

## 🛠️ 기술스택

* SwiftUI
* MVVM
* Combine
* Realm
* Alamofire
* NEXON OPEN API

## 📌 기술스택 관련 기능

* MVVM   
  * Input, Output 패턴을 사용하여 Combine의 퍼블리셔를 통해 View와 바인딩

* Combine
  * ViewModel의 Input 구조체의 사용자 이벤트 관리
  * ViewModel의 Output 구조체의 응답 결과를 View에 반영

* Realm
  * 사용자가 설정한 일일, 주간 퀘스트를 저장하는 데이터베이스 구현
 
  * Repository 패턴을 적용하여 Realm 데이터 소스에 대한 접근 추상화
 
* Alamofire
  * async/await 패턴을 통한 Rest API 요청 및 응답 비동기 처리
    
  * Router 및 TargetType 패턴 적용을 통한 네트워크 통신 로직 추상화

## 📱 화면별 기능

* 대표 캐릭터 조회 화면
  
  - 대표캐릭터를 지정하여 대표캐릭터의 다양한 정보를 조회할 수 있습니다.
 
  - 조회 가능한 정보
 
      - 캐릭터 기본정보
 
      - 전투력 및 각종 스텟
   
      - 하이퍼스텟 및 어빌리티(프리셋 지원)
   
      - 착용 중인 장비 및 상세 정보(프리셋 지원)
   
      - 착용 중인 심볼 및 정보
 
  - 우측 상단의 설정 버튼을 클릭하여 대표캐릭터를 변경할 수 있습니다.

* 캐릭터 검색 화면
  
  - 다른 캐릭터를 닉네임 기반으로 검색하여 캐릭터 정보를 조회할 수 있습니다.

* 메할일(퀘스트) 화면
  
  - 직접 입력하기 좌측의 버튼을 클릭하여 게임 내의 일간 및 주간 퀘스트들을 추가할 수 있습니다.

  - 사용자가 직접 입력하여 할일을 등록할 수 있습니다.
  
  - 등록된 일정은 매일 혹은 매주 초기화 됩니다.

* 이벤트 화면
  
  - 게임 내에서 제공되는 공지사항, 업데이트, 이벤트 등의 정보를 제공하는 화면입니다.
    
  - 공지사항의 제목을 클릭하여 상세 페이지를 모바일 버전으로 확인할 수 있습니다.

## 💥 트러블슈팅

* 완료된 퀘스트들의 완료 여부를 지정된 시간(매일, 매주 월요일 자정)에 초기화 해야하는 문제

  - 데이터베이스(Realm)에 저장된 퀘스트들의 완료 여부를 지정된 시간에 초기화를 하지 않으면 사용자가 직접 초기화를 해주어야 하는 번거로움이 존재

  - 퀘스트를 등록 및 완료 하는 시점에서 다음날 자정, 다음주 월요일 자정을 구하는 메서드를 구현하여 endDate라는 프로퍼티로 저장
    
  - View의 task를 통해 endDate와 현재시간을 비교, 완료된 퀘스트들 중 endDate가 현재 시간보다 과거일 경우 endDate를 업데이트 하도록 로직을 구현

  - 코드
    ```swift
    extension Date {
        static let formatter = DateFormatter()
    
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
    }
    ```
    
    ```swift
    final class RealmManager {
        private let realm = try! Realm()
    
    //...
        func updateDailyQuest(_ quest: DailyQuest) {
            do {
                try realm.write {
                    quest.thaw()?.endDate = Date().nextDay()
                    quest.thaw()?.isComplete = false
                }
            } catch {
                print(#function, "Error: \(error)")
            }
        }
    //...
    }
    ```

* TabView Item이동 시 View 재생성으로 인한 API 과호출 문제

  - TabItem을 이동할 때 마다 View를 새로 렌더링 하며 View와 연결된 프로퍼티들(ViewModel)을 새로 생성하여 문제가 발생

  - 상위 View에서 먼저 각 View의 ViewModel 객체를 생성한 뒤, 생성되는 View에 각 ViewModel을 주입하는 방식으로 구조를 변경
 
  - ViewModel을 View가 관리하지 않고 외부에서 관리하게 만들어줌으로써 문제를 해결
    
  - 코드
    
    ```swift
    struct CharacterInfoView: View {
    
        @StateObject private var statViewModel = CharacterStatViewModel()
        @StateObject private var equipViewModel = EquipmentViewModel()
        @StateObject private var symbolViewModel = SymbolViewModel()
        @StateObject private var hyperStatViewModel = HyperStatViewModel()
    
    //...
    
    var body: some View {
            NavigationView {
                VStack(spacing: 0) {
                    VStack {
                        //...
                    }
                    CharacterInfoTapView(
                        picker: viewModel.output.picker,
                        statViewModel: statViewModel,
                        equipViewModel: equipViewModel,
                        symbolViewModel: symbolViewModel,
                        hyperStatViewModel: hyperStatViewModel
                    )
                }
            }
    
    //...
    
        struct CharacterInfoTapView: View {
    
            let picker: CharacterInfoViewModel.TapMenu
            let statViewModel: CharacterStatViewModel
            let equipViewModel: EquipmentViewModel
            let symbolViewModel: SymbolViewModel
            let hyperStatViewModel: HyperStatViewModel
    
            var body: some View {
                switch picker {
                case .character:
                    CharacterStatView(viewModel: statViewModel)
                case .equipment:
                    EquipmentView(viewModel: equipViewModel)
                case .symbol:
                    SymbolView(viewModel: symbolViewModel)
                case .hyperStat:
                    HyperStatView(viewModel: hyperStatViewModel)
                }
            }
        }
    }
    ```
