# Labb - Data Modellering 

## Introduktion
Uppgiften i denna labb var att skapa en databas för den fiktiva yrkeshögskolan YrkesCo utifrån en kravspecifikation som underlag. 
Målet var att ersätta deras nuvarande manuella hantering i Excel med en robust, centraliserad och skalbar SQL-databas. 


För mer information om labben: \
[Labb_beskrivning (PDF)](/bilder/lab_yrkesco.pdf)
## Video-pitch

# Arbetsprocess
## 1. Datamodellering
Först gjorde jag själva datamodelleringen i form av ett ERD (Entity Relationship Diagram). Detta innebar att jag analyserade kravspecifikationen för att identifiera verksamhetens viktigaste byggstenar (entiteter) och hur de hänger ihop (relationer), vilket resulterade i en konceptuell modell.\
Därefter utvecklade jag den logiska modellen. Här definierade jag specifika attribut för varje tabell samt datatyper för att säkerställa att strukturen uppfyller kraven för 3NF (Tredje normalformen). Slutligen översatte jag den logiska designen till en fysisk modell i dbdiagram, vilket lade grunden för den faktiska SQL-implementeringen.

## Konseptuell modell
<img src="./bilder/KonceptuellModell_v12.png" alt="Konceptuell Modell" width="600">

## Logisk modell
<img src="./bilder/LogiskModell_v7.png" alt="Konceptuell Modell" width="600"> 


## 2. Implementering med Docker Compose
Efter modelleringen översatte jag min design till SQL-kod och körde den i en PostgreSQL-container via Docker. För att hantera konfigurationen skapade jag en docker-compose.yml-fil och en .env-fil för säker hantering av miljövariabler.
För att skapa en ny container och köra i Docker:

### Guide: Starta och anslut till databasen

1. Starta containern (skapa image, volym och nätverk):
```bash
docker compose up -d
```

2. Anslut direkt till PostgreSQL i containern:
```bash
docker exec -it yrkco psql -U yrkesco -d yrkco_db
```

## 3. Verifiering & Validering 
För att säkerställa att databasen uppfyller kraven har jag genomfört följande tester:
- Constraints: Verifierat att felaktig data (t.ex. ogiltiga betyg eller felaktiga e-postformat) stoppas vid inmatning.
- Dataintegritet: Testat att kopplingar mellan tabeller (Foreign Keys) förhindrar att exempelvis studenter läggs till i klasser som inte existerar.
- Analys: Skapat JOIN-frågor som hämtar ut meningsfull data, exempelvis procentandelen studenter med LIA-plats per anläggning.

## Hjälp och källor
ERD
- https://github.com/AIgineerAB/data_modeling_course/tree/main/03_erd_conceptual_model
- https://github.com/AIgineerAB/data_modeling_course/tree/main/04_erd_logical_physical_model

Docker setup & Docker-compose
- https://github.com/AIgineerAB/data_platform_course/tree/main/04_setup_docker
- https://github.com/AIgineerAB/data_modeling_course/tree/main/05_setup_postgres

Normalisering
- https://github.com/AIgineerAB/data_modeling_course/tree/main/07_normalization

Jag har även haft stor nytta av anteckningar från lektioner och tidgare arbeten med Regular Expression och SQL-queries. Jag har använt LLM för att generera fejk data (VALUES) och som stöd i olika moment där jag inte själv kunnat hitta svaret/lösa uppgiften.   
