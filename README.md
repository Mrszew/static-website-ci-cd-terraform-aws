# Projekt statycznej strony z CI/CD przy użyciu GitHub Actions i Cypress

## Opis projektu

Ten projekt zawiera statyczną stronę hostowaną w bucketcie S3, z procesem CI/CD wdrożonym za pomocą **GitHub Actions**. Każdy commit do gałęzi `main` uruchamia pipeline, który automatycznie synchronizuje pliki strony (HTML, CSS, JS) z bucketem **S3** oraz uruchamia testy E2E za pomocą **Cypress**.

## Struktura projektu

- **.github/workflows/**: Zawiera plik `cypress.yml`, który definiuje pipeline CI/CD.
- **main.tf**: (Opcjonalnie) plik Terraform do definiowania infrastruktury w AWS.
- **index.html**: Główna strona HTML.
- **styles.css**: Plik CSS.
- **script.js**: Skrypt JavaScript obsługujący funkcjonalności strony.
- **cypress/**: Folder z testami E2E realizowanymi przy użyciu Cypress.

## Technologie użyte w projekcie

- **GitHub Actions**: Narzędzie do CI/CD, które automatyzuje proces wdrażania plików do S3 oraz uruchamianie testów jednostkowych.
- **AWS S3**: Przechowywanie i hostowanie plików statycznych strony.
- **Cypress**: Testy end-to-end dla aplikacji webowej.
- **Terraform**: (Opcjonalnie) do zarządzania infrastrukturą w AWS.

## CI/CD z GitHub Actions

Pipeline CI/CD został zdefiniowany w pliku `.github/workflows/` i automatyzuje:

1. **Testy jednostkowe i E2E**:

   - **Cypress** uruchamia testy end-to-end na każdą zmianę w repozytorium.
   - Weryfikacja poprawności kodu i funkcjonalności strony przed wdrożeniem.

2. **Wdrożenie plików do S3**:
   - Po pozytywnym przejściu testów pliki są synchronizowane z bucketem **AWS S3**.
   - Wykorzystanie `aws s3 sync` do przesyłania zaktualizowanych plików.

### Kroki CI/CD:

1. **Checkout repozytorium**: Pobieranie najnowszych zmian z GitHub.
2. **Instalacja Cypress**: Instalacja zależności Node.js oraz Cypress.
3. \*\*Ur
