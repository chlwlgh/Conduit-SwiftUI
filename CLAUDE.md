# Conduit-SwiftUI

## Project Overview
- Medium.com 클론 블로깅 플랫폼 (RealWorld API spec 준수)
- SwiftUI + MVVM 아키텍처
- 54 Swift files, ~3,742 LOC

## Tech Stack
- Swift, SwiftUI, iOS 16+
- Xcode project: MyMedium.xcodeproj
- SPM dependencies:
  - Alamofire 5.6.4 (HTTP networking)
  - SwiftyJSON 5.0.1 (JSON parsing helper)
  - AlertToast 1.3.7 (toast notifications)
  - SwiftUI-Shimmer 1.1.0 (loading shimmer effects)
  - SwiftSoup 2.5.3 (HTML parsing)
  - swift-html-entities 4.0.1 (HTML entity encoding/decoding)

## Directory Structure
```
MyMedium/
├── App/              # 앱 진입점 + 화면(Screens) — 13 files
├── GlobalState/      # ViewModels (ObservableObject) — 7 files
├── Modal/            # Codable data models (주의: "Modal" = "Model"로 읽을 것) — 5 files
├── Networking/       # REST API 클라이언트 + 도메인별 서비스 — 12 files
├── Views/            # 재사용 SwiftUI 컴포넌트 — 11 files
├── Helper/           # 상수, 유틸리티, UI 헬퍼 — 5 files
├── Auth/             # 인증 화면 (회원가입) — 1 file
└── Assets.xcassets/  # 이미지, 컬러, 아이콘
```

## Architecture (MVVM)
- **View**: SwiftUI View, `@EnvironmentObject`로 ViewModel 주입
- **ViewModel**: `ObservableObject`, `@Published` 프로퍼티, Service 호출
- **Service**: 도메인별 API 호출 함수 (closure-based async)
- **RestAPIClient**: Alamofire 기반 제네릭 HTTP 클라이언트

### Data Flow
```
View (@EnvironmentObject VM)
  → ViewModel (@Published, calls Services)
    → Services (domain-specific API calls)
      → RestAPIClient.request<T: Codable>(...)
        → Alamofire.AF.request(...)
          → RealWorld API (https://api.realworld.io/api/)
```

## App Entry Point
- `MyMediumApp.swift` (내부 struct명: `ConduitApp` — 파일명과 struct명 불일치 주의)
- 9개 `@EnvironmentObject` 주입: AppViewModel, AuthViewModel, ArticleViewModel, FeedArticleViewModel, CommentsViewModel, ProfileViewModel + 3 NavigationStack ViewModels
- 인증 상태(`@AppStorage`)에 따라 HomeScreen 또는 WelcomeScreen 분기

## Authentication
- JWT 토큰을 `@AppStorage("JWT_token")`에 저장
- `RestAPIClient`에서 Bearer 헤더 자동 추가
- `isSkipped` 플래그로 로그인 건너뛰기 지원

## @AppStorage 전역 상태 흐름
| Key | @AppStorage 문자열 | 사용 파일 | 용도 |
|-----|-------------------|-----------|------|
| `AppConst.token` | `"JWT_token"` | MyMediumApp.swift, RestAPIClient.swift, CreateAccountScreen.swift | JWT 인증 토큰 |
| `AppConst.isSkipped` | `"SIKPED"` (SKIPPED 타이포) | MyMediumApp.swift, CreateAccountScreen.swift | 로그인 건너뛰기 플래그 |
| `AppConst.isLoggedIn` | `"isLoggedIn"` | MyMediumApp.swift, AuthViewModal.swift | 인증 상태 플래그 |

## Naming Conventions (중요)
- Screen 파일: `{Feature}Screen.swift` (예: HomeScreen.swift)
- ViewModel 파일: `{Feature}ViewModal.swift` (주의: 파일명은 "Modal" 타이포, 내부 class명은 정확히 `{Feature}ViewModel`)
- Model 파일: `{Domain}Modal.swift` (동일한 "Modal" 컨벤션)
- Service 파일: `{Domain}Services.swift` 또는 `{Domain}Servers.swift`
- Endpoint 파일: `{Domain}ApiEndpoint.swift`
- Component 파일: `App{Component}.swift` 또는 `{Feature}View.swift`

## API Configuration
- Base URL: `https://api.realworld.io/api/` (`AppConst.ApiConst.apiEndPoint`)
- 참고: `AppConst.baseurl`은 `https://reqres.in/api/`로 되어있으나 실제 사용되지 않음
- RealWorld API spec 준수

## Build & Run
1. Xcode에서 `MyMedium.xcodeproj` 열기
2. SPM 의존성 자동 resolve 대기
3. iOS Simulator 또는 실제 디바이스에서 빌드/실행
4. 별도의 백엔드 설정 불필요 (공용 RealWorld API 사용)

## CI (GitHub Actions)
- 워크플로우 파일: `.github/workflows/ci.yml`
- 트리거: `main` 브랜치 push 및 PR
- 러너: `macos-14`, Xcode 15.4
- 시뮬레이터: iPhone 15 (iOS 17.5)
- 빌드 플래그: `CODE_SIGNING_ALLOWED=NO`
- 테스트: `-only-testing:MyMediumTests` (24개 ViewModel 단위 테스트)
- SPM 캐시: `actions/cache@v4`로 의존성 캐싱

## Unit Tests
- 테스트 타겟: `MyMediumTests` (non-hosted, 소스 직접 컴파일)
- 테스트 수: 24개 (Auth 4, Article 5, FeedArticle 3, Comments 3, Profile 3, App 2, NavigationStack 4)
- Mock 패턴: `Mock{Service}` → `{Service}Protocol` conform, `Result` 프로퍼티로 반환값 설정
- Fixture: `TestData.swift`에 RealWorld API spec 기반 테스트 데이터
- 로컬 실행:
  ```bash
  xcodebuild test -project MyMedium.xcodeproj -scheme MyMedium \
    -destination 'platform=iOS Simulator,name=iPhone 16e,OS=18.5' \
    -only-testing:MyMediumTests CODE_SIGNING_ALLOWED=NO
  ```

## Auth 모듈 (MyMedium/Auth/)
- `CreateAccont/CreateAccountScreen.swift`: 회원가입 화면 (디렉토리명 "CreateAccont"는 "CreateAccount" 타이포)

## Helper 모듈 (MyMedium/Helper/)
- `AppConst.swift`: API URL, @AppStorage 키, 이메일 정규식, SF Symbols 아이콘명, 키보드 타입 상수
- `Helper.swift`: 유효성 검사(이메일, 패스워드), 날짜 포맷팅, 소유자 확인 유틸리티
- `UIHelper.swift`: UI 관련 헬퍼
- `AppHTMLView.swift`: HTML 컨텐츠 렌더링 (SwiftSoup/HTMLEntities 사용)
- `PulsateCircle.swift`: 펄스 애니메이션 효과 컴포넌트

## Modal 모듈 (MyMedium/Modal/) — 주의: "Modal" = "Model"
- `ArticleModal/Articles.swift`: Article, TrendingArticles, FavArticleRes, RequestParams, ArticleParams 등
- `AuthModal/AuthModal.swift`: LoginSuccess, User, LoginFail, UserAuthParams, UserUpdateParms
- `CommentsModal/CommentModal.swift`: Comment 관련 모델
- `ProfileModal/ProfileModal.swift`: FollowUser, Profile 모델
- `NavModal/NavModal.swift`: 네비게이션 관련 모델/enum
- 패턴: 모두 Codable struct, `toDictionary()` 헬퍼로 요청 파라미터 변환

## Known Quirks & Dangerous Patterns
- **"Modal" = "Model"**: 프로젝트 전체에서 "Model" 대신 "Modal" 사용 (리팩토링 대상 아님, 있는 그대로 이해할 것)
- **파일명 vs class명 불일치**: GlobalState 파일명은 `*ViewModal.swift`이나 실제 class명은 `*ViewModel` — 파일명의 "Modal"은 오타, class명이 정본
- **`"Done" as! T` 강제 캐스팅** (RestAPIClient.swift): 204 No Content 응답 처리 시 런타임 크래시 위험
- **`costumeCompletion`** (RestAPIClient.swift): "customCompletion"의 타이포
- **`"SIKPED"`** (@AppStorage 키): "SKIPPED"의 타이포
- **`CreateAccont/`** 디렉토리: "CreateAccount"의 타이포
- **`FiltterScreen.swift`**: "FilterScreen"의 타이포
- **`TrandingArticle/`** 디렉토리: "TrendingArticle"의 타이포
- **`MyMediumApp.swift` / `ConduitApp`**: 파일명과 내부 struct명 불일치
- RestAPIClient에 debug print 문 포함
- closure-based async 패턴 (pre-async/await)
