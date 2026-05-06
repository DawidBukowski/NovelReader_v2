---

## FINAL SUCCESS (2026-05-06) - działa stabilnie

### Co finalnie było zepsute

Problem NIE był już w `sample_rate` ani `n_speakers` (to zostało wcześniej poprawione).
Finalny blocker był podwójny:

1. **Brak kompletnego `espeak-ng-data`** na urządzeniu (wcześniej brakowało m.in. `phontab`).
2. **Zła struktura katalogu po kopii**:
   - było: `.../espeak-ng-data/espeak-ng-data/...`
   - sherpa szuka: `.../espeak-ng-data/phontab`  
   więc nie znajdował plików i init TTS failował.

Dodatkowo log sherpa wskazał:
- `Error when reading tokens: "audio": { ... }`
co oznaczało, że parser tokenów dostał JSON, a nie właściwy format tokenów (ten temat jest do docelowej poprawki w kodzie; obejście testowe zostało zastosowane i dało sukces).

---

### Jak rozpoznałem właściwy moment przełomu

Krytyczny sygnał w logach:
- zniknęły błędy o braku metadanych ONNX,
- zniknęły błędy o braku `phontab`,
- po poprawieniu struktury katalogu i tokenów TTS zaczął działać (audio ruszyło).

Wcześniej było:
- `Engine init failed: Failed to create offline tts`
- kaskada `TTS engine not initialised`
- 100% progress + wieczne ładowanie / brak audio

Po naprawie:
- inicjalizacja i synteza przechodzą poprawnie,
- można czytać artykuł bez natychmiastowego wyrzucenia.

---

### Finalny działający układ plików na telefonie

Katalog:
`/data/user/0/com.example.open_reader/app_flutter/voices/en_us_amy_medium/`

Wymagane elementy:

- `en_US-amy-medium.onnx`
- `en_US-amy-medium.onnx.json` (lub plik użyty aktualnie przez appkę jako config)
- `espeak-ng-data/` z plikami na **pierwszym poziomie**, m.in.:
  - `phontab`
  - `phondata`
  - `phonindex`
  - `lang/`
  - `voices/`
  - słowniki `*_dict`

**Bardzo ważne:** nie może być zagnieżdżenia `espeak-ng-data/espeak-ng-data`.

---

### Kroki, które doprowadziły do sukcesu (do powtórzenia)

1. Zweryfikowanie paczki lokalnej:
   - ONNX ma metadata: `sample_rate=22050`, `n_speakers=1`.
   - `espeak-ng-data` zawiera `phontab`.

2. Wgranie paczki na telefon:
   - model + json do `app_flutter/voices/en_us_amy_medium/`
   - pełny `espeak-ng-data`.

3. Naprawa struktury katalogu:
   - przeniesienie plików z `.../espeak-ng-data/espeak-ng-data/*` poziom wyżej.
   - usunięcie pustego/nadmiarowego zagnieżdżenia.

4. Potwierdzenie obecności:
   - `phontab`, `phondata`, `phonindex` w `.../espeak-ng-data/`.

5. Retest przez `flutter run` i odtworzenie scenariusza wyboru artykułu.

---

### Dlaczego teraz działa

Sherpa-onnx dla VITS potrzebuje:
- poprawnych metadanych ONNX (`sample_rate`, `n_speakers`),
- kompletnego runtime eSpeak (`phontab`, `phondata`, `phonindex`, itp.),
- poprawnej ścieżki do tych plików.

Dopiero spełnienie **wszystkich trzech** warunków pozwala poprawnie zbudować `OfflineTts`.
Wcześniej każdy brak powodował `Failed to create offline tts`, a potem UI wpadało w stan „100% + nieskończone ładowanie”.

---

### Lessons learned (na przyszłość)

- Sam `.onnx` + `.onnx.json` nie wystarcza dla tego wariantu VITS.
- `espeak-ng-data` musi być kompletne i poprawnie umieszczone.
- Przy debugowaniu:
  1. najpierw metadata ONNX,
  2. potem obecność `phontab/phondata/phonindex`,
  3. na końcu format pliku tokenów i mapowanie w kodzie.
- Objaw „100% i brak audio” często oznacza fail w init TTS, niekoniecznie problem UI.

---

### TODO po sukcesie (osobny commit kodu)

Docelowo poprawić kod w:
`lib/features/tts_player/data/datasources/sherpa_onnx_isolate.dart`

Dla `VoiceArchitecture.vits`:
- nie podawać JSON-a jako `tokens` jeśli model oczekuje `tokens.txt`,
- dodać rozróżnienie/fallback:
  - preferuj `tokens.txt`,
  - fallback do obecnego `configJsonPath` tylko gdy format zgodny.
- dodać bardziej precyzyjne logowanie błędów init, żeby od razu było wiadomo, czy fail dotyczy:
  - metadanych modelu,
  - dataDir eSpeak,
  - parsera tokenów.