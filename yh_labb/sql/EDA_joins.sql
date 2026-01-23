SET
    search_path TO yrkesco,
    public;

-- Vilken Anläggning (Stockholm eller Göteborg) har flest Studenter?
SELECT
    anl.anlaggnings_id,
    adr.ort AS Stad,
    COUNT(s.student_id) AS Antal_Studenter
FROM
    Anlaggning anl
    JOIN Adress adr ON anl.adress_id = adr.adress_id
    LEFT JOIN Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
    LEFT JOIN UtbildningsLedare ul ON ans.anstallnings_id = ul.anstallnings_id
    LEFT JOIN Klass k ON ul.ul_id = k.ul_id
    LEFT JOIN Student s ON k.klass_id = s.klass_id
GROUP BY
    anl.anlaggnings_id,
    adr.ort
ORDER BY
    Antal_Studenter DESC;

-- Hur många Utbildare på respektive Anläggning är Konsulter?
SELECT 
    adr.ort AS Stad,
    COUNT(DISTINCT u.konsult_id) AS Antal_Konsulter
FROM Anlaggning anl
JOIN Adress adr ON anl.adress_id = adr.adress_id
LEFT JOIN Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
LEFT JOIN Utbildare u ON (ans.anstallnings_id = u.anstallnings_id OR u.konsult_id IS NOT NULL)
WHERE u.konsult_id IS NOT NULL
GROUP BY adr.ort;

-- Hur många Studenter har fått LIA? procent Hela Yrkco

SELECT 
    COUNT(DISTINCT s.student_id) AS totalt_antal_studenter,
    COUNT(DISTINCT l.student_id) AS antal_med_lia,
    ROUND((COUNT(DISTINCT l.student_id)::numeric / COUNT(DISTINCT s.student_id)) * 100, 1) || '%' AS total_matchningsgrad
FROM yrkesco.Student s
LEFT JOIN yrkesco.LIA l ON s.student_id = l.student_id;

-- Procent per Anläggning

SELECT 
    adr.ort AS Stad,
    COUNT(DISTINCT s.student_id) AS antal_studenter,
    COUNT(DISTINCT l.student_id) AS antal_med_lia,
    ROUND((COUNT(DISTINCT l.student_id)::numeric / NULLIF(COUNT(DISTINCT s.student_id), 0)) * 100, 1) || '%' AS matchningsgrad_lia
FROM yrkesco.Anlaggning anl
JOIN yrkesco.Adress adr ON anl.adress_id = adr.adress_id
LEFT JOIN yrkesco.Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
LEFT JOIN yrkesco.UtbildningsLedare ul ON ans.anstallnings_id = ul.anstallnings_id
LEFT JOIN yrkesco.Klass k ON ul.ul_id = k.ul_id
LEFT JOIN yrkesco.Student s ON k.klass_id = s.klass_id
LEFT JOIN yrkesco.LIA l ON s.student_id = l.student_id
GROUP BY adr.ort;