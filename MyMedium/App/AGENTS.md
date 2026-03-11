# App 모듈

> Last verified: 2026-03-11

## 역할
앱 진입점 및 모든 화면(Screen)을 포함하는 최상위 모듈. `@main` 앱 구조체에서 9개의 EnvironmentObject를 주입하고, 인증 상태에 따라 화면을 분기한다.

## 파일 목록 (13 files)

### Entry Point
| 파일 | 역할 |
|------|------|
| `MyMediumApp.swift` | `@main` 앱 진입점. 9개 EnvironmentObject 주입, `@AppStorage` 인증 상태에 따라 HomeScreen/WelcomeScreen 분기. 내부 struct명은 `ConduitApp` |
| `ContentView.swift` | Xcode 기본 생성 파일. 현재 사용되지 않음 |

### Screens/Welcome/
| 파일 | 역할 |
|------|------|
| `WelcomeScreen.swift` | 비로그인 사용자 초기 화면. 로그인/회원가입/건너뛰기 옵션 제공 |

### Screens/App/HomeScreen/
| 파일 | 역할 |
|------|------|
| `HomeScreen.swift` | 메인 TabView 컨테이너. 4개 탭: ForYou(Feed), Trending, AddPost, Profile |

### Screens/App/Feeds/
| 파일 | 역할 |
|------|------|
| `FeedScreen.swift` | 사용자 피드 아티클 목록 화면 |

### Screens/App/TrandingArticle/ (Trending 타이포)
| 파일 | 역할 |
|------|------|
| `TrandingArticleScreen.swift` | 트렌딩 아티클 목록 화면 |

### Screens/App/ArticleDetailView/
| 파일 | 역할 |
|------|------|
| `ArticleDetailViewScreen.swift` | 아티클 상세 화면. 본문, 댓글, 좋아요, 작성자 정보 표시 |

### Screens/App/CreateArticle/
| 파일 | 역할 |
|------|------|
| `CreateArticleScreen.swift` | 아티클 작성/수정 화면 |

### Screens/App/Profile/
| 파일 | 역할 |
|------|------|
| `ProfileScreen.swift` | 현재 사용자 프로필 화면. 작성한 아티클 목록 포함 |
| `EditProfileScreen.swift` | 프로필 수정 화면 |

### Screens/App/SelectedUserScreen/
| 파일 | 역할 |
|------|------|
| `SelectedUserScreen.swift` | 다른 사용자 프로필 조회 화면. 팔로우/언팔로우 기능 |

### Screens/App/ (기타)
| 파일 | 역할 |
|------|------|
| `FiltterScreen.swift` | 태그 기반 아티클 필터 화면 (Filter 타이포) |

### Screens/ (루트)
| 파일 | 역할 |
|------|------|
| `DemoScreen.swift` | 데모/테스트 화면 |

## Navigation
- `NavigationStack` + `NavigationPath` 기반
- 3개의 독립 NavigationStack ViewModel 사용: FeedNavigationStackViewModal, TradingNavigationStackViewModal, ProfileNavigationStackViewModal (GlobalState/ 참조)
