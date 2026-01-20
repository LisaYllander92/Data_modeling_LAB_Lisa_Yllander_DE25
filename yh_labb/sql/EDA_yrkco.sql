SET search_path TO yrkesco, public;

-- Vilken Anläggning (Stockholm eller Göteborg) har flest Studenter?
SELECT 
anl.anlaggnings_id,
adr.ort AS Stad,
COUNT(s.student_id) AS Antal_Studenter
FROM Anlaggning anl
JOIN Adress adr ON anl.adress_id = adr.adress_id
LEFT JOIN Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
LEFT JOIN UtbildningsLedare ul ON ans.anstallnings_id = ul.anstallnings_id
LEFT JOIN Klass k ON ul.ul_id = k.ul_id
LEFT JOIN Student s ON k.klass_id = s.klass_id
GROUP BY anl.anlaggnings_id, adr.ort
ORDER BY Antal_Studenter DESC;

-- Hur många Utbildare på respektive Anläggning är Konsulter?
