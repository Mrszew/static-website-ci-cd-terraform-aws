# Projekt statycznej strony z CI/CD przy użyciu GitHub Actions i Cypress dla SlickCloud

## Opis projektu

Ten projekt zawiera statyczną stronę hostowaną w bucketcie **AWS S3**, z procesem **CI/CD** wdrożonym za pomocą **GitHub Actions**. Każdy commit do gałęzi `main` uruchamia pipeline, który automatycznie synchronizuje pliki strony (HTML, CSS, JS) z bucketem **S3** oraz uruchamia testy **E2E** przy użyciu **Cypress**.

## Struktura projektu

- **app/public/**: Zawiera wszystkie pliki strony statycznej.
  - **index.html**: Główna strona HTML.
  - **styles.css**: Plik CSS, odpowiedzialny za stylizację strony.
  - **script.js**: Skrypt JavaScript obsługujący funkcjonalności strony.
  - **error.html**: Strona błędu (np. 404).
- **cypress/e2e/**: Folder z testami end-to-end **Cypress**.

  - **test.cy.js**: Skrypt testów Cypress, który weryfikuje, czy na stronie `<Header>` znajduje się słowo **Marcel**.

- **.github/workflows/cicd.yml**: Definicja procesu CI/CD.
- **main.tf**: Plik **Terraform** do konfiguracji infrastruktury AWS (S3 i CloudFront).

- **.gitignore**: Ignorowane pliki, które nie są śledzone w repozytorium (np. `node_modules`).

## Technologie użyte w projekcie

- **GitHub Actions**: Narzędzie do CI/CD, które automatycznie uruchamia testy i synchronizuje pliki do **AWS S3**.
- **AWS S3**: Usługa do hostowania plików statycznych.
- **AWS CloudFront**: CDN przyspieszający dostarczanie treści.
- **Cypress**: Narzędzie do testów end-to-end, które sprawdza funkcjonalności strony.
- **Terraform**: Używany do automatyzacji tworzenia infrastruktury na AWS.
- **AWS IAM**: Stowrzony user z tagami umozliwiajacymi dostep do okre

## CI/CD z GitHub Actions

Pipeline CI/CD został zdefiniowany w pliku **cicd.yml** i automatyzuje następujące kroki:

1. **Testy jednostkowe i E2E**:

   - **Cypress** uruchamia testy end-to-end, które sprawdzają, czy w elemencie `<Header>` znajduje się słowo **Marcel**.
   - Testy są uruchamiane przy każdym commicie do gałęzi `main`.

2. **Wdrożenie plików do S3**:
   - Po pozytywnym przejściu testów pliki z katalogu **app/public** są synchronizowane z bucketem **AWS S3**.
   - Synchronizacja odbywa się za pomocą komendy `aws s3 sync`, a do autoryzacji używane są poświadczenia przechowywane w **GitHub Secrets**.

## Jak uruchomić projekt

1. **Zainstaluj Terraform**:
   Użyj Terraform, aby skonfigurować bucket S3 i CloudFront w AWS. W pliku **main.tf** znajdziesz konfigurację infrastruktury.
2. **Skonfiguruj AWS CLI**:
   Upewnij się, że masz zainstalowane i poprawnie skonfigurowane **AWS CLI** z poświadczeniami użytkownika IAM, który ma dostęp do S3.

3. **Dodaj poświadczenia do GitHub Secrets**:
   Dodaj swoje **AWS_ACCESS_KEY_ID** oraz **AWS_SECRET_ACCESS_KEY** do sekcji **GitHub Secrets** swojego repozytorium, aby GitHub Actions mógł synchronizować pliki do bucketu S3.

4. **Testowanie i wdrożenie**:
   Każdy commit do gałęzi `main` uruchomi testy **Cypress**. Jeśli testy zakończą się sukcesem, pliki z app/public zostaną zsynchronizowane z bucketem **AWS S3**.
