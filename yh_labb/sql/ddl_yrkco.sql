-- 1. Skapar ett schema (mapp) för att samla allt som rör Yrkesco på ett ställe.
-- Detta ökar säkerheten, underlättar behörighetsstyrning och håller databasen organiserad.
CREATE SCHEMA IF NOT EXISTS yrkesco;

-- Ställer in sökstigen så att alla efterföljande tabeller automatiskt hamnar i yrkesco-schemat.
SET search_path TO yrkesco, public; 

-- 2. Skapa tabeller utan beroenden (Independent tables)
CREATE TABLE IF NOT EXISTS Adress (
    adress_id INTEGER PRIMARY KEY,
    gatu_namn VARCHAR(100) NOT NULL,
    gatu_nr VARCHAR(10) NOT NULL,
    post_nr VARCHAR(10) NOT NULL,
    ort VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Program (
    program_id INTEGER PRIMARY KEY,
    program_namn VARCHAR(50) NOT NULL,
    start_datum DATE NOT NULL,
    slut_datum DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Kurs (
    kurs_id INTEGER PRIMARY KEY,
    kurs_namn VARCHAR(50) NOT NULL,
    kurs_kod VARCHAR(50) NOT NULL,
    poang INTEGER NOT NULL,
    kurs_beskrivning VARCHAR(250) NOT NULL
);

CREATE TABLE IF NOT EXISTS Foretag (
    foretags_id INTEGER PRIMARY KEY,
    org_nr VARCHAR(50) NOT NULL,
    foretags_namn VARCHAR(150) NOT NULL,
    f_skatt_status BOOLEAN NOT NULL,
    adress_id INTEGER REFERENCES Adress(adress_id)
);

CREATE TABLE IF NOT EXISTS Konsult (
    konsult_id INTEGER PRIMARY KEY,
    k_fornamn VARCHAR(50) NOT NULL,
    k_efternamn VARCHAR(100) NOT NULL,
    timarvode FLOAT NOT NULL,
    foretags_id INTEGER NOT NULL REFERENCES Foretag(foretags_id)
);

-- 3. Tabeller som beror på ovanstående
CREATE TABLE IF NOT EXISTS Anlaggning (
    anlaggnings_id INTEGER PRIMARY KEY,
    byggnads_ar INTEGER NOT NULL,
    adress_id INTEGER REFERENCES Adress(adress_id)
);

CREATE TABLE IF NOT EXISTS Anstallda (
    anstallnings_id INTEGER PRIMARY KEY,
    a_fornamn VARCHAR(50) NOT NULL,
    a_efternamn VARCHAR(100) NOT NULL,
    jobb_titel VARCHAR(100) NOT NULL,
    jobb_mail VARCHAR(100) NOT NULL,
    avdelning VARCHAR(100) NOT NULL,
    arbets_beskrivning VARCHAR(500),
    ar_utbildare BOOLEAN,
    ar_ul BOOLEAN,
    anlaggnings_id INTEGER REFERENCES Anlaggning(anlaggnings_id)
);

-- 4. Tabeller för personlig information och roller
CREATE TABLE IF NOT EXISTS AnstalldaUppgifter (
    au_id INTEGER PRIMARY KEY,
    a_person_nr VARCHAR(13) UNIQUE NOT NULL,
    a_email VARCHAR(254) UNIQUE NOT NULL,
    a_tele_nr VARCHAR(20) NOT NULL,
    konto_nr VARCHAR(50) NOT NULL,
    lon FLOAT,
    anstallnings_id INTEGER UNIQUE REFERENCES Anstallda(anstallnings_id),
    adress_id INTEGER REFERENCES Adress(adress_id)
);

CREATE TABLE IF NOT EXISTS UtbildningsLedare (
    ul_id INTEGER PRIMARY KEY,
    anstallnings_id INTEGER REFERENCES Anstallda(anstallnings_id)
);

CREATE TABLE IF NOT EXISTS Utbildare (
    utbildare_id INTEGER PRIMARY KEY,
    specialisering VARCHAR(100),
    arvode FLOAT,
    anstallnings_id INTEGER REFERENCES Anstallda(anstallnings_id),
    konsult_id INTEGER UNIQUE REFERENCES Konsult(konsult_id)
);

-- 5. Utbildningsstruktur
CREATE TABLE IF NOT EXISTS Klass (
    klass_id INTEGER PRIMARY KEY,
    klass_namn VARCHAR(50) NOT NULL,
    start_ar INTEGER NOT NULL,
    program_id INTEGER REFERENCES Program(program_id),
    ul_id INTEGER REFERENCES UtbildningsLedare(ul_id)
);

CREATE TABLE IF NOT EXISTS ProgramInnehall (
    program_id INTEGER REFERENCES Program(program_id),
    kurs_id INTEGER REFERENCES Kurs(kurs_id),
    PRIMARY KEY (program_id, kurs_id)
);

CREATE TABLE IF NOT EXISTS KursGenomforande (
    genomforande_id INTEGER PRIMARY KEY,
    start_datum DATE NOT NULL,
    slut_datum DATE NOT NULL,
    termin VARCHAR(20) NOT NULL,
    status VARCHAR(50) NOT NULL,
    utbildare_id INTEGER REFERENCES Utbildare(utbildare_id),
    kurs_id INTEGER REFERENCES Kurs(kurs_id)
);

-- 6. Studenter och registrering
CREATE TABLE IF NOT EXISTS Student (
    student_id INTEGER PRIMARY KEY,
    s_fornamn VARCHAR(50) NOT NULL,
    s_efternamn VARCHAR(100) NOT NULL,
    klass_id INTEGER REFERENCES Klass(klass_id)
);

CREATE TABLE IF NOT EXISTS StudentUppgifter (
    su_id INTEGER PRIMARY KEY,
    s_person_nr VARCHAR(13) UNIQUE NOT NULL,
    s_email VARCHAR(254) UNIQUE NOT NULL,
    s_tele_nr VARCHAR(20),
    adress_id INTEGER NOT NULL REFERENCES Adress(adress_id),
    student_id INTEGER NOT NULL UNIQUE REFERENCES Student(student_id)
);

CREATE TABLE IF NOT EXISTS Registrering (
    registrerings_id INTEGER PRIMARY KEY,
    registerings_datum DATE NOT NULL,
    betyg VARCHAR(10),
    betygs_datum DATE,
    reg_status VARCHAR(50) NOT NULL,
    genomforande_id INTEGER NOT NULL REFERENCES KursGenomforande(genomforande_id),
    student_id INTEGER NOT NULL REFERENCES Student(student_id)
);