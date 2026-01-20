-- Väljer rätt schema
SET search_path TO yrkesco, public;

-- 1. Adresser
INSERT INTO Adress (adress_id, gatu_namn, gatu_nr, post_nr, ort) VALUES 
(1, 'Götgatan', '12', '11846', 'Stockholm'),
(2, 'Lilla Torget', '4', '41103', 'Göteborg'),
(3, 'Södergatan', '22', '21134', 'Malmö');

-- 2. Program
INSERT INTO Program (program_id, program_namn, start_datum, slut_datum) VALUES 
(1, 'Systemutvecklare Java', '2024-09-01', '2026-06-05'),
(2, 'Frontend Developer', '2024-09-01', '2026-06-05');

-- 3. Kurser
INSERT INTO Kurs (kurs_id, kurs_namn, kurs_kod, poang, kurs_beskrivning) VALUES 
(1, 'Databasteknik', 'DB24', 25, 'SQL, datamodellering och relationsdatabaser'),
(2, 'Java Grundkurs', 'JAVA1', 35, 'Grundläggande programmering och OOP'),
(3, 'React & JavaScript', 'JSFE', 30, 'Moderna ramverk för webbutveckling');

-- 4. Företag (för konsulter)
INSERT INTO Foretag (foretags_id, org_nr, foretags_namn, f_skatt_status, adress_id) VALUES 
(1, '556123-4567', 'IT-Konsulterna AB', TRUE, 2),
(2, '559876-5432', 'Code Masters Stockholm', TRUE, 1);

-- 5. Anläggningar (Skolans lokaler)
INSERT INTO Anlaggning (anlaggnings_id, byggnads_ar, adress_id) VALUES 
(1, 2010, 1),
(2, 2018, 2);

-- 6. Konsulter (Externa lärare)
INSERT INTO Konsult (konsult_id, k_fornamn, k_efternamn, timarvode, foretags_id) VALUES 
(1, 'Anders', 'Ek', 850.0, 1),
(2, 'Beatrice', 'Lind', 920.0, 2);

-- 7. Anställda (UL och Interna lärare)
INSERT INTO Anstallda (anstallnings_id, a_fornamn, a_efternamn, jobb_titel, jobb_mail, avdelning, ar_utbildare, ar_ul, anlaggnings_id) VALUES 
(1, 'Karin', 'Sjöberg', 'Utbildningsledare', 'karin@yrkco.se', 'Administration', FALSE, TRUE, 1),
(2, 'Mikael', 'Nilsson', 'Senior Lärare', 'mikael@yrkco.se', 'IT', TRUE, FALSE, 1),
(3, 'Linda', 'Karlsson', 'Utbildningsledare', 'linda@yrkco.se', 'Administration', FALSE, TRUE, 2);

-- 8. Anställdas Uppgifter
INSERT INTO AnstalldaUppgifter (au_id, a_person_nr, a_email, a_tele_nr, konto_nr, lon, anstallnings_id, adress_id) VALUES 
(1, '19750512-1234', 'karin.privat@gmail.com', '+46 701112233', '8105-2, 994321', 45000.0, 1, 1),
(2, '19820320-5566', 'micke.code@outlook.com', '+46 8123456', '3300-1, 123456', 42000.0, 2, 2);

-- 9. Utbildningsledare (Kopplingstabell)
INSERT INTO UtbildningsLedare (ul_id, anstallnings_id) VALUES 
(1, 1),
(2, 3);

-- 10. Utbildare (XOR-check: Antingen anställd eller konsult)
INSERT INTO Utbildare (utbildare_id, specialisering, arvode, anstallnings_id, konsult_id) VALUES 
(1, 'Java & Backend', NULL, 2, NULL),        -- Anställd lärare
(2, 'SQL Specialist', 850.0, NULL, 1),      -- Konsult
(3, 'Frontend Expert', 920.0, NULL, 2);     -- Konsult

-- 11. Klasser
INSERT INTO Klass (klass_id, klass_namn, start_ar, program_id, ul_id) VALUES 
(1, 'JAVAS24', 2024, 1, 1),
(2, 'FRONT24', 2024, 2, 2);

-- 12. ProgramInnehåll (Vilka kurser hör till vilket program)
INSERT INTO ProgramInnehall (program_id, kurs_id) VALUES 
(1, 1), -- Java-prog har Databas
(1, 2), -- Java-prog har Java-kurs
(2, 3); -- Frontend-prog har React

-- 13. KursGenomförande (När en kurs faktiskt körs)
INSERT INTO KursGenomforande (genomforande_id, start_datum, slut_datum, termin, status, utbildare_id, kurs_id) VALUES 
(1, '2024-10-01', '2024-11-15', 'Höst 2024', 'Pågår', 2, 1), -- Anders lär ut SQL
(2, '2024-09-01', '2024-10-30', 'Höst 2024', 'Avslutad', 1, 2); -- Mikael lär ut Java

-- 14. Studenter
INSERT INTO Student (student_id, s_fornamn, s_efternamn, klass_id) VALUES 
(1, 'Erik', 'Andersson', 1),
(2, 'Sara', 'Lundin', 1),
(3, 'Johan', 'Viktorsson', 2);

-- 15. Studenternas Uppgifter
INSERT INTO StudentUppgifter (su_id, s_person_nr, s_email, s_tele_nr, adress_id, student_id) VALUES 
(1, '20010101-9988', 'erik.a@student.se', '+46 733445566', 1, 1),
(2, '19980505-1122', 'sara.l@student.se', '+46 766554433', 3, 2);

-- 16. Registreringar (Studenter på specifika genomföranden)
INSERT INTO Registrering (registrerings_id, registerings_datum, betyg, betygs_datum, reg_status, genomforande_id, student_id) VALUES 
(1, '2024-09-25', 'VG', '2024-11-20', 'Betygsatt', 1, 1),
(2, '2024-09-25', NULL, NULL, 'Registrerad', 1, 2);