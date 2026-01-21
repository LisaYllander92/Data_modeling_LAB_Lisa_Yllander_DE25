-- Väljer rätt schema
SET search_path TO yrkesco, public;

-- 1. Adresser (Lagt till fler adresser för personal och studenter)
INSERT INTO Adress (adress_id, gatu_namn, gatu_nr, post_nr, ort) VALUES 
(1, 'Götgatan', '12', '11846', 'Stockholm'),
(2, 'Lilla Torget', '4', '41103', 'Göteborg'),
(3, 'Södergatan', '22', '21134', 'Malmö'),
(4, 'Vasagatan', '1', '11120', 'Stockholm'),
(5, 'Avenyn', '10', '41136', 'Göteborg'),
(6, 'Hamngatan', '5', '11147', 'Stockholm');

-- 2. Program
INSERT INTO Program (program_id, program_namn, start_datum, slut_datum) VALUES 
(1, 'Systemutvecklare Java', '2024-09-01', '2026-06-05'),
(2, 'Frontend Developer', '2024-09-01', '2026-06-05');

-- 3. Kurser
INSERT INTO Kurs (kurs_id, kurs_namn, kurs_kod, poang, kurs_beskrivning) VALUES 
(1, 'Databasteknik', 'DB24', 25, 'SQL, datamodellering och relationsdatabaser'),
(2, 'Java Grundkurs', 'JAVA1', 35, 'Grundläggande programmering och OOP'),
(3, 'React & JavaScript', 'JSFE', 30, 'Moderna ramverk för webbutveckling'),
(4, 'UX Design', 'UX24', 15, 'Användarupplevelse och gränssnitt');

-- 4. Företag
INSERT INTO Foretag (foretags_id, org_nr, foretags_namn, f_skatt_status, adress_id) VALUES 
(1, '556123-4567', 'IT-Konsulterna AB', TRUE, 2),
(2, '559876-5432', 'Code Masters Stockholm', TRUE, 1),
(3, '554433-2211', 'LIA-Partner Väst', TRUE, 5);

-- 5. Anläggningar
INSERT INTO Anlaggning (anlaggnings_id, byggnads_ar, adress_id) VALUES 
(1, 2010, 1), -- Stockholm
(2, 2018, 2); -- Göteborg

-- 6. Konsulter 
INSERT INTO Konsult (konsult_id, k_fornamn, k_efternamn, timarvode, foretags_id) VALUES 
(1, 'Anders', 'Ek', 850.0, 1),
(2, 'Beatrice', 'Lind', 920.0, 2),
(3, 'Christer', 'Storm', 750.0, 1);

-- 7. Anställda 
INSERT INTO Anstallda (anstallnings_id, a_fornamn, a_efternamn, jobb_titel, jobb_mail, avdelning, ar_utbildare, ar_ul, anlaggnings_id) VALUES 
(1, 'Karin', 'Sjöberg', 'Utbildningsledare', 'karin@yrkco.se', 'Administration', FALSE, TRUE, 1),
(2, 'Mikael', 'Nilsson', 'Senior Lärare', 'micke@yrkco.se', 'IT', TRUE, FALSE, 1), -- STHLM
(3, 'Linda', 'Karlsson', 'Utbildningsledare', 'linda@yrkco.se', 'Administration', FALSE, TRUE, 2),
(4, 'Sven', 'Svensson', 'Lärare', 'sven@yrkco.se', 'IT', TRUE, FALSE, 2), -- GBG
(5, 'Anna', 'Borg', 'Lärare', 'anna@yrkco.se', 'IT', TRUE, FALSE, 1), -- STHLM
(6, 'Erik', 'Lund', 'Lärare', 'erik@yrkco.se', 'IT', TRUE, FALSE, 2); -- GBG

-- 10. Utbildare 
INSERT INTO Utbildare (utbildare_id, specialisering, arvode, anstallnings_id, konsult_id) VALUES 
(1, 'Java & Backend', NULL, 2, NULL),  -- Mikael (Anställd STHLM)
(2, 'SQL Specialist', 850.0, NULL, 1), -- Anders (Konsult)
(3, 'Frontend Expert', 920.0, NULL, 2),-- Beatrice (Konsult)
(4, 'C# & Web', NULL, 4, NULL),        -- Sven (Anställd GBG)
(5, 'UX & Design', NULL, 5, NULL),     -- Anna (Anställd STHLM)
(6, 'JavaScript', NULL, 6, NULL);      -- Erik (Anställd GBG)

-- 11. Klasser 
INSERT INTO Klass (klass_id, klass_namn, start_ar, program_id, ul_id, omgang) VALUES 
(1, 'JAVAS24', 2024, 1, 1, 1),
(2, 'FRONT24', 2024, 2, 2, 2);

-- 13. KursGenomförande (Kopplar lärare till specifika kurser)
INSERT INTO KursGenomforande (genomforande_id, start_datum, slut_datum, termin, status, utbildare_id, kurs_id) VALUES 
(1, '2024-10-01', '2024-11-15', 'Höst 2024', 'Pågår', 2, 1), -- Konsult Anders
(2, '2024-09-01', '2024-10-30', 'Höst 2024', 'Avslutad', 1, 2), -- Anställd Mikael
(3, '2024-11-01', '2024-12-20', 'Höst 2024', 'Pågår', 4, 1); -- Anställd Sven (GBG)

-- 14. Studenter (Fler studenter för att visa LIA-variation)
INSERT INTO Student (student_id, s_fornamn, s_efternamn, klass_id) VALUES 
(1, 'Erik', 'Andersson', 1),
(2, 'Sara', 'Lundin', 1),
(3, 'Johan', 'Viktorsson', 2),
(4, 'Maria', 'Sjö', 2);

-- 16. Registreringar (Kopplar studenter till kursgenomföranden)
INSERT INTO Registrering (registrerings_id, registerings_datum, betyg, betygs_datum, reg_status, genomforande_id, student_id) VALUES 
(1, '2024-09-25', 'VG', '2024-11-20', 'Betygsatt', 1, 1),
(2, '2024-09-25', 'G', '2024-11-20', 'Betygsatt', 1, 2),
(3, '2024-09-25', NULL, NULL, 'Registrerad', 1, 3);

-- 17. LIA_Matchning (Endast 2 av 4 studenter har fått LIA)
INSERT INTO LIA (lia_id, handledare_namn, period, student_id, foretags_id) VALUES 
(1, 'Karl Handledarsson', 'LIA 1', 1, 3), -- Erik har LIA
(2, 'Anna Chefsson', 'LIA 2', 2, 2);    -- Sara har LIA
-- Johan och Maria har ingen post här = Ingen LIA ännu.