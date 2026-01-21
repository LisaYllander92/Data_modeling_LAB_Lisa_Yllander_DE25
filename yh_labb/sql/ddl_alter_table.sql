SET search_path TO yrkesco, public; 

-- Lägger till "omgång" i klass för att tydliggöra att en klass beviljas i tre omgångar.
ALTER TABLE Klass 
ADD COLUMN omgang INTEGER CHECK (omgang BETWEEN 1 AND 3);

-- Lägger till en check constraint för att säkerställa att betygskalan är enhetlig med en yrkeshögskola (IG-VG)
ALTER TABLE Registrering
ADD CONSTRAINT check_betyg CHECK (betyg IN('IG', 'G', 'VG') OR betyg is NULL);

