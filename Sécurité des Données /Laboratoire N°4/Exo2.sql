-- Create the master key.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'tigrou007';

-- If the master key already exists, open it in the same session that you create the certificate. (See next step.)
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'tigrou007'

-- Create the certificate encrypted by the master key.
CREATE CERTIFICATE MyCertificate
WITH SUBJECT = 'Backup Cert', EXPIRY_DATE = '20261031';