-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Creating File Format 
CREATE OR REPLACE FILE FORMAT insurance_csv_format
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  EMPTY_FIELD_AS_NULL = TRUE;

-- Creating Storage Integration for Snowflake to S3 connection.
CREATE OR REPLACE STORAGE INTEGRATION my_integration
STORAGE_PROVIDER = 'S3'
TYPE = EXTERNAL_STAGE
ENABLED = TRUE 
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::724268665020:role/INSURANCE_DATA_INSIGHTS_ROLE'
STORAGE_ALLOWED_LOCATIONS = ('s3://insurancedatainsigths/insurance_csv_files/');
DESCRIBE INTEGRATION my_integration;

-- Crearting an external stage for importing data.
CREATE OR REPLACE STAGE insurance_external_stage
FILE_FORMAT = insurance_csv_format
STORAGE_INTEGRATION  = my_integration
URL = 's3://insurancedatainsigths/insurance_csv_files/';

LIST @insurance_external_stage;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
