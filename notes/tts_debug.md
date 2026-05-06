# TTS debug summary

## Objawy
- Po wybraniu artykułu z biblioteki TTS się nie uruchamia, Play kręci się w nieskończoność.
- Było 100% progress i brak audio.
- Po zmianach artykuł już nie znika, ale Play dalej nie działał.

## Naprawione / zmienione
- `tts_providers.dart`: zmienione `ref.watch(selectedVoiceProvider.future)` na `ref.read(...)` w `ttsRepository` (żeby repo nie przebudowywało się przy zmianie głosu).
- `voice_manager_screen.dart`: poprawiona kolejność przy wyborze głosu:
  `await uc(voice.id); await reinitialiseEngine(ref);` (wcześniej było odwrotnie).
- `sherpa_onnx_isolate.dart`: dodane `sherpa.initBindings()` w `kBootstrap`.

## Logi / kluczowy błąd
- Po tych zmianach pojawił się błąd:
  `'sample_rate' does not exist in the metadata` (sherpa-onnx).
- To oznacza, że METADANE w pliku `.onnx` są niekompletne (JSON obok jest OK).

## Potwierdzone dane o głosie
- JSON głosu (`en_US-amy-medium.onnx.json`) ma:
  `"sample_rate": 22050` (jest OK).
- Problem dotyczy samego `.onnx`.

## Środowisko / problemy na komputerze
- `adb` działa, `run-as` działa.
- MSYS2 Python blokuje pip (PEP 668 + SSL cert error).
- `py` (Python launcher) działa: `py --version` zwraca Python 3.14.4.
- `py -3 -m pip install onnx` działa (instalacja onnx OK).

## Potrzebny krok (następny)
- Skopiować `.onnx` z telefonu BINARNIE na PC (PowerShell psuje binaria).
- Polecony sposób:
  `cmd /c "adb exec-out run-as com.example.open_reader cat app_flutter/voices/en_us_amy_medium/en_US-amy-medium.onnx > en_US-amy-medium.onnx"`
- Sprawdzić rozmiar na telefonie:
  `adb shell run-as com.example.open_reader stat -c "%s" app_flutter/voices/en_us_amy_medium/en_US-amy-medium.onnx`
  (wynik: 63201294).
- Sprawdzić rozmiar na PC (powinien być taki sam).
- Potem sprawdzić metadane:
  `py -3 -c "import onnx; m=onnx.load('en_US-amy-medium.onnx'); print(m.metadata_props)"`

## Wniosek
- Jeśli w metadanych nie ma `sample_rate`, trzeba:
    - podmienić model na kompatybilny z sherpa-onnx,
    - albo dodać metadane do ONNX (bardziej zaawansowane).

## Nowe obserwacje po dodaniu metadata
- `metadata_props` w ONNX zawiera `sample_rate = 22050`.
- Po uruchomieniu TTS aplikacja crashuje po ~2 s.
- Flutter log kończy się po:
  `[TTS] synthesize send segment=0/1/2`
- Pojawia się błąd połączenia z service protocol (symptom crasha).

## Następny krok
- Zebrać `adb logcat` z `FATAL EXCEPTION` / `signal 11` w momencie crasha.

## Nowe logi (po metadata)
- `sherpa-onnx`: brak `n_speakers` w metadata (`offline-tts-vits-model.cc:Init:173`).
- Plan: dodać `n_speakers = 1` do ONNX i sprawdzić ponownie.


## Aktualny status
- `espeak-ng-data` jest obecne na telefonie, ale zawiera tylko `lang` i `voices`.
- Brakuje `phontab`, przez co `sherpa-onnx` nie może zbudować offline TTS.
- Błąd: `Failed to create offline tts. Please check your config`

## Wniosek
- Problem nie leży już w `sample_rate` ani w crashu aplikacji.
- Trzeba wgrać pełne, kompletne `espeak-ng-data`, a nie tylko częściowy folder.

## Doprecyzowanie o repo `espeak-ng-master`
- `docs/phontab.md` to tylko dokumentacja, nie runtime data.
- W katalogu `espeak-ng-data` w tym repo są na razie tylko `lang` i `voices`.
- Nie ma tam osobnego pliku `phontab`, a właśnie tego szuka `sherpa-onnx`.
- Wniosek: samo to repo w tej formie nie daje jeszcze kompletnego `vits-data-dir` dla modelu Amy.

## Następny krok
- Zdobyć komplet danych eSpeak, który faktycznie zawiera `phontab`, albo
- przełączyć się na model / konfigurację, która nie wymaga `vits-data-dir`.

## Doprecyzowanie po sprawdzeniu repo eSpeak NG
- `docs/phontab.md` to tylko dokumentacja formatu, nie runtime data.
- W checkoutcie `espeak-ng-master` katalog `espeak-ng-data` zawiera obecnie tylko `lang` i `voices`.
- Szukany jest zwykły plik runtime o nazwie `phontab` (bez rozszerzenia), a nie dokument `phontab.md`.
- Wniosek: do testu TTS potrzebny jest pełny, wygenerowany / zainstalowany pakiet danych eSpeak NG, nie sam katalog ze źródłami lub docs.

## Jak rozpoznać poprawny pakiet
- W folderze `espeak-ng-data` powinien być plik `phontab`.
- Jeśli po uruchomieniu dalej pojawia się brak innego pliku, to znaczy że kopia nadal jest niekompletna i trzeba dołożyć brakującą część z tego samego runtime bundle.

