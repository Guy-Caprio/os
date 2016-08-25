-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.2
-- PostgreSQL version: 9.5
-- Project Site: pgmodeler.com.br
-- Model Author: bouren_n

SET check_function_bodies = false;
-- ddl-end --

-- object: root | type: ROLE --
-- DROP ROLE IF EXISTS root;
CREATE ROLE root WITH 
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD 'cloudhook'
	IN ROLE postgres;
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: cloudhook | type: DATABASE --
-- -- DROP DATABASE IF EXISTS cloudhook;
-- CREATE DATABASE cloudhook
-- 	ENCODING = 'UTF8'
-- 	OWNER = root
-- ;
-- -- ddl-end --
-- 

-- object: public.aws_storage_class_type | type: TYPE --
-- DROP TYPE IF EXISTS public.aws_storage_class_type CASCADE;
CREATE TYPE public.aws_storage_class_type AS
 ENUM ('STANDARD','STANDARD_IA','REDUCED_REDUNDANCY');
-- ddl-end --
ALTER TYPE public.aws_storage_class_type OWNER TO root;
-- ddl-end --

-- object: public.aws_storage_objects | type: TABLE --
-- DROP TABLE IF EXISTS public.aws_storage_objects CASCADE;
CREATE TABLE public.aws_storage_objects(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	storage_class public.aws_storage_class_type NOT NULL,
	type text NOT NULL,
	size bigint NOT NULL,
	language text,
	md5hash text NOT NULL,
	metadata json,
	amz_website_redirect_location text,
	container_id integer NOT NULL,
	object_level integer NOT NULL,
	object_lb integer NOT NULL,
	object_ub integer NOT NULL,
	CONSTRAINT aws_storage_object_id PRIMARY KEY (id),
	CONSTRAINT unique_aws_storage_object_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.aws_storage_objects OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.aws_storage_objects (name,description,storage_class,type,size,language,md5hash,metadata,amz_website_redirect_location,container_id,object_level,object_lb,object_ub) VALUES ('Folder1','Folder Parent','STANDARD','folder','0','fr_FR','5sd6f1f654dfsg4f65sd15sdf1g5sfd41','{"some": "bullshit"}','','1','0','0','5');
INSERT INTO public.aws_storage_objects (name,description,storage_class,type,size,language,md5hash,metadata,amz_website_redirect_location,container_id,object_level,object_lb,object_ub) VALUES ('Folder2','Folder Fils','STANDARD','folder','0','fr_FR','5sd6f1f654dfsg4f65sd15sdf1g5sfd41','{"some": "bullshit"}','','1','1','1','4');
INSERT INTO public.aws_storage_objects (name,description,storage_class,type,size,language,md5hash,metadata,amz_website_redirect_location,container_id,object_level,object_lb,object_ub) VALUES ('Fichier1','Mon premier fichier','STANDARD','jpg','0','fr_FR','5sd6f1f654dfsg4f65sd15sdf1g5sfd41','{"some": "bullshit"}','','1','2','2','3');
-- ddl-end --

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users(
	id serial NOT NULL,
	login text NOT NULL,
	password text NOT NULL,
	description text,
	email text,
	fname text,
	lname text,
	aws_account_id integer,
	azr_account_id integer,
	CONSTRAINT user_id PRIMARY KEY (id),
	CONSTRAINT unique_user_login UNIQUE (login)

)WITH ( OIDS = TRUE );
-- ddl-end --
ALTER TABLE public.users OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.users (login,password,description,fname,lname,email,aws_account_id,azr_account_id) VALUES ('admin','admin','System Admin User','','','','1','1');
INSERT INTO public.users (login,password,description,fname,lname,email,aws_account_id,azr_account_id) VALUES ('toto','toto','toto','to','to','toto@toto','1','1');
INSERT INTO public.users (login,password,description,fname,lname,email,aws_account_id,azr_account_id) VALUES ('tata','tata','tata','ta','ta','tata@tata','1','1');
INSERT INTO public.users (login,password,description,fname,lname,email,aws_account_id,azr_account_id) VALUES ('titi','titi','titi','ti','ti','titi@titi','1','1');
INSERT INTO public.users (login,password,description,fname,lname,email,aws_account_id,azr_account_id) VALUES ('tutu','tutu','tutu','tu','tu','tutu@tutu','1','1');
-- ddl-end --

-- object: public.cloud_vendor_type | type: TYPE --
-- DROP TYPE IF EXISTS public.cloud_vendor_type CASCADE;
CREATE TYPE public.cloud_vendor_type AS
 ENUM ('azr','aws');
-- ddl-end --
ALTER TYPE public.cloud_vendor_type OWNER TO root;
-- ddl-end --

-- object: public.azr_storage_containers | type: TABLE --
-- DROP TABLE IF EXISTS public.azr_storage_containers CASCADE;
CREATE TABLE public.azr_storage_containers(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	cache_control text,
	cache_disposition text,
	cache_encoding text,
	expect boolean NOT NULL,
	metadata text,
	storage_id integer NOT NULL,
	CONSTRAINT azr_container_id PRIMARY KEY (id),
	CONSTRAINT unique_azr_storage_container_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.azr_storage_containers OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.azr_storage_containers (name,description,cache_control,cache_disposition,cache_encoding,expect,metadata,storage_id) VALUES ('lel','lel','lel','lel','lel','0','lel','1');
-- ddl-end --

-- object: public.azr_storage_objects | type: TABLE --
-- DROP TABLE IF EXISTS public.azr_storage_objects CASCADE;
CREATE TABLE public.azr_storage_objects(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	azr_blob_type text NOT NULL,
	type text NOT NULL,
	size bigint NOT NULL,
	language text,
	md5hash text NOT NULL,
	metadata json,
	content_disposition text NOT NULL,
	lease_id text,
	lease_duration integer,
	container_id integer NOT NULL,
	object_level integer NOT NULL,
	object_lb integer NOT NULL,
	object_ub integer NOT NULL,
	CONSTRAINT azr_blob_id PRIMARY KEY (id),
	CONSTRAINT unique_azr_storage_object_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.azr_storage_objects OWNER TO root;
-- ddl-end --

-- object: public.azr_storage_account_type | type: TYPE --
-- DROP TYPE IF EXISTS public.azr_storage_account_type CASCADE;
CREATE TYPE public.azr_storage_account_type AS
 ENUM ('Standard_LRS','Standard_ZRS','Standard_GRS','Standard_RAGRS','Premium_LRS');
-- ddl-end --
ALTER TYPE public.azr_storage_account_type OWNER TO root;
-- ddl-end --

-- object: public.azr_storage_accounts | type: TABLE --
-- DROP TABLE IF EXISTS public.azr_storage_accounts CASCADE;
CREATE TABLE public.azr_storage_accounts(
	id serial NOT NULL,
	signature text NOT NULL,
	name text NOT NULL,
	description text NOT NULL,
	label text NOT NULL,
	location text NOT NULL,
	georeplication boolean NOT NULL,
	names text NOT NULL,
	values text NOT NULL,
	secondaryread boolean NOT NULL,
	type public.azr_storage_account_type NOT NULL,
	CONSTRAINT storage_account_id PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.azr_storage_accounts OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.azr_storage_accounts (signature,name,description,label,location,georeplication,names,values,secondaryread,type) VALUES ('cldstr1','cldstr1','cldstr1','cldstr1','Europe','1','cldstr1','cldstr1','1','Standard_LRS');
INSERT INTO public.azr_storage_accounts (signature,name,description,label,location,georeplication,names,values,secondaryread,type) VALUES ('cldstr2','cldstr2','cldstr2','cldstr2','Europe','0','cldstr2','cldstr2','0','Standard_ZRS');
-- ddl-end --

-- object: public.azr_accounts | type: TABLE --
-- DROP TABLE IF EXISTS public.azr_accounts CASCADE;
CREATE TABLE public.azr_accounts(
	id serial NOT NULL,
	login text NOT NULL,
	password text NOT NULL,
	azr_subscription_id text NOT NULL,
	azr_storage_account_id integer,
	CONSTRAINT azr_account_id PRIMARY KEY (id),
	CONSTRAINT unique_azr_account_login UNIQUE (login)

);
-- ddl-end --
ALTER TABLE public.azr_accounts OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.azr_accounts (login,password,azr_subscription_id,azr_storage_account_id) VALUES ('bouren_n@etna-alternance.net','secret42','680fe13a-97f0-4f03-858c-e61f151f100d','1');
-- ddl-end --

-- object: public.aws_storage_acl_type | type: TYPE --
-- DROP TYPE IF EXISTS public.aws_storage_acl_type CASCADE;
CREATE TYPE public.aws_storage_acl_type AS
 ENUM ('private','public-read','public-read-write','authenticated-read','aws-exec-read','bucket-owner-read','bucket-owner-full-control');
-- ddl-end --
ALTER TYPE public.aws_storage_acl_type OWNER TO root;
-- ddl-end --

-- object: public.aws_accounts | type: TABLE --
-- DROP TABLE IF EXISTS public.aws_accounts CASCADE;
CREATE TABLE public.aws_accounts(
	id serial NOT NULL,
	login text NOT NULL,
	password text NOT NULL,
	type text NOT NULL,
	aws_access_key_id text NOT NULL,
	aws_secret_access_key_id text NOT NULL,
	aws_account_id text NOT NULL,
	aws_canonical_user_id text NOT NULL,
	CONSTRAINT aws_account_id PRIMARY KEY (id),
	CONSTRAINT unique_aws_account_login UNIQUE (login)

);
-- ddl-end --
ALTER TABLE public.aws_accounts OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.aws_accounts (login,password,type,aws_access_key_id,aws_secret_access_key_id,aws_account_id,aws_canonical_user_id) VALUES ('bouren_n@etna-alternance.net','etna42','root','AKIAIZL4Y6D4JDUPSM5A','RkNkRDBXZ8Midrc6ZnH3N5Iwz+6LIDKx7WEfE9XY','A5472-4984-3702','fa47085858ab564334ea42d468c62785f177627106af3bcfbc13cc2dfbe2e497');
-- ddl-end --

-- object: public.storage_objects | type: VIEW --
-- DROP VIEW IF EXISTS public.storage_objects CASCADE;
CREATE VIEW public.storage_objects
AS 

SELECT obj.id, obj.name, obj.description, obj.storage_class, NULL AS azr_blob_type, obj.type, obj.size, obj.language, obj.md5hash, obj.metadata, obj.amz_website_redirect_location, NULL AS content_disposition, NULL AS lease_id, NULL AS lease_duration, obj.container_id, obj.object_level, obj.object_lb, obj.object_ub, 'aws' AS cloud_vendor
FROM public.aws_storage_objects AS obj
UNION ALL
SELECT obj.id, obj.name, obj.description, NULL AS storage_class, obj.azr_blob_type, obj.type, obj.size, obj.language, obj.md5hash, obj.metadata, NULL AS amz_website_redirect_location, obj.content_disposition, obj.lease_id, obj.lease_duration, obj.container_id, obj.object_level, obj.object_lb, obj.object_ub, 'azr' AS cloud_vendor
FROM public.azr_storage_objects AS obj;
-- ddl-end --
ALTER VIEW public.storage_objects OWNER TO root;
-- ddl-end --

-- object: public.groups | type: TABLE --
-- DROP TABLE IF EXISTS public.groups CASCADE;
CREATE TABLE public.groups(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	type text NOT NULL,
	CONSTRAINT group_id PRIMARY KEY (id),
	CONSTRAINT unique_group_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.groups OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.groups (name,description,type) VALUES ('sys-admin','Super Administrators Group','Storage');
INSERT INTO public.groups (name,description,type) VALUES ('str-admin','Storage Administration Group','Storage');
INSERT INTO public.groups (name,description,type) VALUES ('net-admin','Network Administration Group','Storage');
-- ddl-end --

-- object: public.link_groups_users | type: TABLE --
-- DROP TABLE IF EXISTS public.link_groups_users CASCADE;
CREATE TABLE public.link_groups_users(
	user_id integer NOT NULL,
	group_id integer NOT NULL,
	CONSTRAINT link_groups_users_pk PRIMARY KEY (user_id,group_id)

);
-- ddl-end --
ALTER TABLE public.link_groups_users OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.link_groups_users (group_id,user_id) VALUES ('1','1');
-- ddl-end --

-- object: public.permissions | type: TABLE --
-- DROP TABLE IF EXISTS public.permissions CASCADE;
CREATE TABLE public.permissions(
	id serial NOT NULL,
	read boolean NOT NULL DEFAULT false,
	write boolean NOT NULL DEFAULT false,
	delete boolean NOT NULL DEFAULT false,
	read_permission boolean NOT NULL DEFAULT false,
	write_permission boolean NOT NULL DEFAULT false,
	delete_permission boolean NOT NULL DEFAULT false,
	CONSTRAINT permission_id PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.permissions OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.permissions (read,write,delete,read_permission,write_permission,delete_permission) VALUES ('1','1','1','0','0','0');
INSERT INTO public.permissions (read,write,delete,read_permission,write_permission,delete_permission) VALUES ('1','0','1','0','1','0');
INSERT INTO public.permissions (read,write,delete,read_permission,write_permission,delete_permission) VALUES ('1','1','1','1','1','1');
-- ddl-end --

-- object: public.accounts | type: VIEW --
-- DROP VIEW IF EXISTS public.accounts CASCADE;
CREATE VIEW public.accounts
AS 

SELECT
aws.id, aws.login, aws.password, aws.type, aws.aws_access_key_id, aws.aws_secret_access_key_id, aws.aws_account_id AS account_id, aws.aws_canonical_user_id, NULL AS azr_subscription_id,  NULL AS azr_storage_account_id, u.id AS user_id,'aws' AS cloud_vendor
FROM public.aws_accounts AS aws
LEFT JOIN users AS u ON aws.id = u.aws_account_id
UNION ALL
SELECT
azr.id, azr.login, azr.password, NULL AS type, NULL AS aws_access_key_id, NULL AS aws_secret_access_key_id, NULL AS account_id, NULL AS aws_canonical_user_id, azr.azr_subscription_id, azr.azr_storage_account_id, u.id AS user_id, 'azr' AS cloud_vendor
FROM public.azr_accounts AS azr
LEFT JOIN users AS u ON azr.id = u.azr_account_id;
-- ddl-end --
ALTER VIEW public.accounts OWNER TO root;
-- ddl-end --

-- object: public.aws_storages | type: TABLE --
-- DROP TABLE IF EXISTS public.aws_storages CASCADE;
CREATE TABLE public.aws_storages(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	aws_account_id integer NOT NULL,
	CONSTRAINT aws_storage_id PRIMARY KEY (id),
	CONSTRAINT unique_aws_storage_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.aws_storages OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.aws_storages (name,description,aws_account_id) VALUES ('storageOne','Depuis mon compte AWS','1');
INSERT INTO public.aws_storages (id,name,description,aws_account_id) VALUES ('12','storageTwelve','Depuis mon compte AWS','1');
INSERT INTO public.aws_storages (id,name,description,aws_account_id) VALUES ('13','storageThirteen','Depuis mon compte AWS','1');
-- ddl-end --

-- object: public.azr_storages | type: TABLE --
-- DROP TABLE IF EXISTS public.azr_storages CASCADE;
CREATE TABLE public.azr_storages(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	azr_storage_account_id integer NOT NULL,
	CONSTRAINT azr_storage_id PRIMARY KEY (id),
	CONSTRAINT unique_azr_storage_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.azr_storages OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.azr_storages (name,description,azr_storage_account_id) VALUES ('storageTwo','Mon Second Stockage -> Azure','1');
-- ddl-end --

-- object: public.storages | type: VIEW --
-- DROP VIEW IF EXISTS public.storages CASCADE;
CREATE VIEW public.storages
AS 

SELECT str.id, str.name, str.description, str.aws_account_id AS owner_account_id, 'aws' AS cloud_vendor
FROM public.aws_storages AS str
UNION ALL
SELECT str.id, str.name, str.description, str.azr_storage_account_id AS owner_account_id, 'azr' AS cloud_vendor
FROM public.azr_storages AS str;
-- ddl-end --
ALTER VIEW public.storages OWNER TO root;
-- ddl-end --

-- object: public.storage_folders | type: VIEW --
-- DROP VIEW IF EXISTS public.storage_folders CASCADE;
CREATE VIEW public.storage_folders
AS 

SELECT obj.id, obj.name, obj.description, obj.storage_class, NULL AS azr_blob_type, obj.type, obj.size, obj.language, obj.md5hash, obj.metadata, obj.amz_website_redirect_location, NULL AS content_disposition, NULL AS lease_id, NULL AS lease_duration, obj.container_id, obj.object_level, obj.object_lb, obj.object_ub, 'aws' AS cloud_vendor
FROM public.aws_storage_objects AS obj
WHERE type = 'folder'
UNION ALL
SELECT obj.id, obj.name, obj.description, NULL AS storage_class, obj.azr_blob_type, obj.type, obj.size, obj.language, obj.md5hash, obj.metadata, NULL AS amz_website_redirect_location, obj.content_disposition, obj.lease_id, obj.lease_duration, obj.container_id, obj.object_level, obj.object_lb, obj.object_ub, 'azr' AS cloud_vendor
FROM public.azr_storage_objects AS obj
WHERE type = 'folder';
-- ddl-end --
ALTER VIEW public.storage_folders OWNER TO root;
-- ddl-end --

-- object: public.aws_storage_containers | type: TABLE --
-- DROP TABLE IF EXISTS public.aws_storage_containers CASCADE;
CREATE TABLE public.aws_storage_containers(
	id serial NOT NULL,
	name text NOT NULL,
	description text,
	creation_date timestamptz NOT NULL,
	acl public.aws_storage_acl_type NOT NULL,
	storage_class public.aws_storage_class_type NOT NULL,
	region text NOT NULL,
	size bigint NOT NULL,
	cache_control text,
	cache_disposition text,
	cache_encoding text,
	expect boolean NOT NULL,
	request_payment boolean NOT NULL,
	versionning boolean NOT NULL,
	lifecycle_configuration json,
	policy_configuration json,
	notification_configuration json,
	logging_configuration json,
	xregion_replication json,
	tags json,
	storage_id integer NOT NULL,
	CONSTRAINT container_id PRIMARY KEY (id),
	CONSTRAINT unique_aws_storage_container_name UNIQUE (name)

);
-- ddl-end --
ALTER TABLE public.aws_storage_containers OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.aws_storage_containers (name,description,creation_date,acl,storage_class,region,size,cache_control,cache_disposition,cache_encoding,expect,request_payment,versionning,lifecycle_configuration,policy_configuration,notification_configuration,logging_configuration,xregion_replication,tags,storage_id) 
VALUES ('monBucket','Mon tout premier',CURRENT_TIMESTAMP,'private','STANDARD','EU','65131561331','Osef','Osef','Osef','1','0','1','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','1');
INSERT INTO public.aws_storage_containers (name,description,creation_date,acl,storage_class,region,size,cache_control,cache_disposition,cache_encoding,expect,request_payment,versionning,lifecycle_configuration,policy_configuration,notification_configuration,logging_configuration,xregion_replication,tags,storage_id) 
VALUES ('mon2Bucket','Mon tout premier',CURRENT_TIMESTAMP,'private','STANDARD','EU','65131561331','Osef','Osef','Osef','1','0','1','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','1');
INSERT INTO public.aws_storage_containers (name,description,creation_date,acl,storage_class,region,size,cache_control,cache_disposition,cache_encoding,expect,request_payment,versionning,lifecycle_configuration,policy_configuration,notification_configuration,logging_configuration,xregion_replication,tags,storage_id) 
VALUES ('mon3Bucket','Mon tout premier',CURRENT_TIMESTAMP,'private','STANDARD','EU','65131561331','Osef','Osef','Osef','1','0','1','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','{"nothing": "oui"}','1');
-- ddl-end --

-- object: public.storage_containers | type: VIEW --
-- DROP VIEW IF EXISTS public.storage_containers CASCADE;
CREATE VIEW public.storage_containers
AS 

SELECT con.id, con.name, con.description, con.creation_date, con.acl, con.storage_class, con.region, con.size, con.cache_control, con.cache_disposition, con.cache_encoding, con.expect, con.request_payment, con.versionning, con.lifecycle_configuration, con.policy_configuration, con.notification_configuration, con.logging_configuration, con.xregion_replication, con.tags, NULL AS metadata, con.storage_id, 'aws' AS cloud_vendor
FROM public.aws_storage_containers AS con
UNION ALL
SELECT con.id, con.name, con.description, NULL AS creation_date, NULL AS acl, NULL AS storage_class, NULL AS region, NULL AS size, con.cache_control, con.cache_disposition, con.cache_encoding, con.expect, NULL AS request_payment, NULL AS versionning, NULL AS lifecycle_configuration, NULL AS policy_configuration, NULL AS notification_configuration, NULL AS logging_configuration, NULL AS xregion_replication, NULL AS tags, con.metadata, con.storage_id, 'azr' AS cloud_vendor
FROM public.azr_storage_containers AS con;
-- ddl-end --
ALTER VIEW public.storage_containers OWNER TO root;
-- ddl-end --

-- object: public.cors_configuration | type: TABLE --
-- DROP TABLE IF EXISTS public.cors_configuration CASCADE;
CREATE TABLE public.cors_configuration(
	id serial NOT NULL,
	allowed_headers text,
	allowed_methods text NOT NULL,
	allowed_origins text NOT NULL,
	expose_headers text,
	max_age_seconds integer,
	item_id integer,
	CONSTRAINT cors_condiguration_id PRIMARY KEY (id),
	CONSTRAINT unique_item_id UNIQUE (item_id)

);
-- ddl-end --
ALTER TABLE public.cors_configuration OWNER TO root;
-- ddl-end --

-- object: public.aws_permission_configuration | type: TABLE --
-- DROP TABLE IF EXISTS public.aws_permission_configuration CASCADE;
CREATE TABLE public.aws_permission_configuration(
	id serial NOT NULL,
	grantee text NOT NULL,
	grant_full_control boolean,
	grant_read boolean,
	grant_read_acp boolean,
	grant_write_acp boolean,
	item_id integer,
	CONSTRAINT aws_permission_configuration_id PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.aws_permission_configuration OWNER TO root;
-- ddl-end --

-- object: public.aws_storage_objects_insert | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.aws_storage_objects_insert() CASCADE;
CREATE FUNCTION public.aws_storage_objects_insert ()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE LEAKPROOF
	STRICT
	SECURITY INVOKER
	COST 1
	AS $$
BEGIN
UPDATE aws_storage_objects
SET object_position = int4range(lower(object_position), upper(object_position) + 2, '[)')
WHERE upper(object_position) > lower(NEW.object_position);
RETURN NEW;
END;
$$;
-- ddl-end --
ALTER FUNCTION public.aws_storage_objects_insert() OWNER TO root;
-- ddl-end --

-- object: public.aws_storage_objects_delete | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.aws_storage_objects_delete() CASCADE;
CREATE FUNCTION public.aws_storage_objects_delete ()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE LEAKPROOF
	STRICT
	SECURITY INVOKER
	COST 1
	AS $$
BEGIN
UPDATE aws_storage_objects
SET object_position = int4range(lower(object_position), upper(object_position) + 2, '[)')
WHERE upper(object_position) > lower(NEW.object_position);
RETURN NEW;
END;
$$;
-- ddl-end --
ALTER FUNCTION public.aws_storage_objects_delete() OWNER TO root;
-- ddl-end --

-- object: shift_object_position_on_insert | type: TRIGGER --
-- DROP TRIGGER IF EXISTS shift_object_position_on_insert ON public.aws_storage_objects CASCADE;
CREATE TRIGGER shift_object_position_on_insert
	BEFORE INSERT 
	ON public.aws_storage_objects
	FOR EACH ROW
	EXECUTE PROCEDURE public.aws_storage_objects_insert();
-- ddl-end --

-- object: shift_object_position_on_delete | type: TRIGGER --
-- DROP TRIGGER IF EXISTS shift_object_position_on_delete ON public.aws_storage_objects CASCADE;
CREATE TRIGGER shift_object_position_on_delete
	AFTER DELETE 
	ON public.aws_storage_objects
	FOR EACH ROW
	EXECUTE PROCEDURE public.aws_storage_objects_delete();
-- ddl-end --

-- object: public.register | type: TABLE --
-- DROP TABLE IF EXISTS public.register CASCADE;
CREATE TABLE public.register(
	key text NOT NULL,
	value text NOT NULL DEFAULT 0,
	CONSTRAINT register_id_key PRIMARY KEY (key)

);
-- ddl-end --
ALTER TABLE public.register OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.register (key,value) VALUES ('configuration_check_list','0');
INSERT INTO public.register (key,value) VALUES ('aws_iam_api_version','2010-05-08');
INSERT INTO public.register (key,value) VALUES ('aws_s3_api_version','2006-03-01');
-- ddl-end --

-- object: public.link_permissions_azr_storage_objects | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_azr_storage_objects CASCADE;
CREATE TABLE public.link_permissions_azr_storage_objects(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_azr_storage_objects_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_azr_storage_objects OWNER TO root;
-- ddl-end --

-- object: public.link_permissions_aws_storages | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_aws_storages CASCADE;
CREATE TABLE public.link_permissions_aws_storages(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_aws_storages_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_aws_storages OWNER TO root;
-- ddl-end --

-- Appended SQL commands --
INSERT INTO public.link_permissions_aws_storages (group_id, resource_id, permission_id) VALUES ('1','12','1');
INSERT INTO public.link_permissions_aws_storages (group_id, resource_id, permission_id) VALUES ('2','1','1');
INSERT INTO public.link_permissions_aws_storages (group_id, resource_id, permission_id) VALUES ('3','13','3');
-- ddl-end --

-- object: public.link_permissions_aws_storage_containers | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_aws_storage_containers CASCADE;
CREATE TABLE public.link_permissions_aws_storage_containers(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_aws_storage_containers_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_aws_storage_containers OWNER TO root;
-- ddl-end --

-- object: public.link_permissions_aws_storage_objects | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_aws_storage_objects CASCADE;
CREATE TABLE public.link_permissions_aws_storage_objects(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_aws_storage_objects_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_aws_storage_objects OWNER TO root;
-- ddl-end --

-- object: public.link_permissions_azr_storages | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_azr_storages CASCADE;
CREATE TABLE public.link_permissions_azr_storages(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_azr_storages_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_azr_storages OWNER TO root;
-- ddl-end --

-- object: public.link_permissions_azr_storage_containers | type: TABLE --
-- DROP TABLE IF EXISTS public.link_permissions_azr_storage_containers CASCADE;
CREATE TABLE public.link_permissions_azr_storage_containers(
	group_id integer NOT NULL,
	resource_id integer NOT NULL,
	permission_id integer,
	CONSTRAINT link_permissions_azr_storage_containers_pk PRIMARY KEY (group_id,resource_id)

);
-- ddl-end --
ALTER TABLE public.link_permissions_azr_storage_containers OWNER TO root;
-- ddl-end --

-- object: public.resources | type: VIEW --
-- DROP VIEW IF EXISTS public.resources CASCADE;
CREATE VIEW public.resources
AS 

SELECT 'aws_storages' AS resource_table, 'storage' AS resource_type, str.id, str.name, str.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM aws_storages AS str
LEFT JOIN link_permissions_aws_storages AS l ON str.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
UNION ALL
SELECT 'azr_storages' AS resource_table, 'storage' AS resource_type, str.id, str.name, str.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM azr_storages AS str
LEFT JOIN link_permissions_azr_storages AS l ON str.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
UNION ALL
SELECT 'aws_storage_containers' AS resource_table, 'container' AS resource_type, con.id, con.name, con.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM aws_storage_containers AS con
LEFT JOIN link_permissions_aws_storage_containers AS l ON con.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
UNION ALL
SELECT 'azr_storage_containers' AS resource_table, 'container' AS resource_type, con.id, con.name, con.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM azr_storage_containers AS con
LEFT JOIN link_permissions_azr_storage_containers AS l ON con.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
UNION ALL
SELECT 'aws_storage_objects' AS resource_table, 'folder' AS resource_type,  obj.id, obj.name, obj.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM aws_storage_objects AS obj
LEFT JOIN link_permissions_aws_storage_objects AS l ON obj.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
WHERE obj.type = 'folder'
UNION ALL
SELECT'azr_storage_objects' AS resource_table, 'folder' AS resource_type,  obj.id, obj.name, obj.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM azr_storage_objects AS obj
LEFT JOIN link_permissions_azr_storage_objects AS l ON obj.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
WHERE obj.type = 'folder'
UNION ALL
SELECT 'aws_storage_objects' AS resource_table, 'file' AS resource_type, obj.id, obj.name, obj.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM aws_storage_objects AS obj
LEFT JOIN link_permissions_aws_storage_objects AS l ON obj.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
WHERE  obj.type != 'folder'
UNION ALL
SELECT 'azr_storage_objects' AS resource_table, 'file' AS resource_type,  obj.id, obj.name, obj.description, p.id AS permission_id, p.read, p.write, p.delete, p.read_permission, p.write_permission, p.delete_permission, groups.id AS group_id
FROM azr_storage_objects AS obj
LEFT JOIN link_permissions_azr_storage_objects AS l ON obj.id = l.resource_id
LEFT JOIN permissions AS p ON p.id = l.permission_id
LEFT JOIN groups ON l.group_id = groups.id
WHERE obj.type != 'folder';
-- ddl-end --
ALTER VIEW public.resources OWNER TO root;
-- ddl-end --

-- object: aws_storage_container_id | type: CONSTRAINT --
-- ALTER TABLE public.aws_storage_objects DROP CONSTRAINT IF EXISTS aws_storage_container_id CASCADE;
ALTER TABLE public.aws_storage_objects ADD CONSTRAINT aws_storage_container_id FOREIGN KEY (container_id)
REFERENCES public.aws_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_account_id | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS aws_account_id CASCADE;
ALTER TABLE public.users ADD CONSTRAINT aws_account_id FOREIGN KEY (aws_account_id)
REFERENCES public.aws_accounts (id) MATCH FULL
ON DELETE SET NULL ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_account_id | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS azr_account_id CASCADE;
ALTER TABLE public.users ADD CONSTRAINT azr_account_id FOREIGN KEY (azr_account_id)
REFERENCES public.azr_accounts (id) MATCH FULL
ON DELETE SET NULL ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_storage_id | type: CONSTRAINT --
-- ALTER TABLE public.azr_storage_containers DROP CONSTRAINT IF EXISTS azr_storage_id CASCADE;
ALTER TABLE public.azr_storage_containers ADD CONSTRAINT azr_storage_id FOREIGN KEY (storage_id)
REFERENCES public.azr_storages (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_container_id | type: CONSTRAINT --
-- ALTER TABLE public.azr_storage_objects DROP CONSTRAINT IF EXISTS azr_container_id CASCADE;
ALTER TABLE public.azr_storage_objects ADD CONSTRAINT azr_container_id FOREIGN KEY (container_id)
REFERENCES public.azr_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_storage_account_id | type: CONSTRAINT --
-- ALTER TABLE public.azr_accounts DROP CONSTRAINT IF EXISTS azr_storage_account_id CASCADE;
ALTER TABLE public.azr_accounts ADD CONSTRAINT azr_storage_account_id FOREIGN KEY (azr_storage_account_id)
REFERENCES public.azr_storage_accounts (id) MATCH FULL
ON DELETE SET NULL ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_groups_users DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_groups_users ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: user_id | type: CONSTRAINT --
-- ALTER TABLE public.link_groups_users DROP CONSTRAINT IF EXISTS user_id CASCADE;
ALTER TABLE public.link_groups_users ADD CONSTRAINT user_id FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_storage_id | type: CONSTRAINT --
-- ALTER TABLE public.aws_storage_containers DROP CONSTRAINT IF EXISTS aws_storage_id CASCADE;
ALTER TABLE public.aws_storage_containers ADD CONSTRAINT aws_storage_id FOREIGN KEY (storage_id)
REFERENCES public.aws_storages (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: cors_configuration_aws_container_id | type: CONSTRAINT --
-- ALTER TABLE public.cors_configuration DROP CONSTRAINT IF EXISTS cors_configuration_aws_container_id CASCADE;
ALTER TABLE public.cors_configuration ADD CONSTRAINT cors_configuration_aws_container_id FOREIGN KEY (item_id)
REFERENCES public.aws_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: cors_configuration_azr_container_id | type: CONSTRAINT --
-- ALTER TABLE public.cors_configuration DROP CONSTRAINT IF EXISTS cors_configuration_azr_container_id CASCADE;
ALTER TABLE public.cors_configuration ADD CONSTRAINT cors_configuration_azr_container_id FOREIGN KEY (item_id)
REFERENCES public.azr_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_permission_configuration_container_id | type: CONSTRAINT --
-- ALTER TABLE public.aws_permission_configuration DROP CONSTRAINT IF EXISTS aws_permission_configuration_container_id CASCADE;
ALTER TABLE public.aws_permission_configuration ADD CONSTRAINT aws_permission_configuration_container_id FOREIGN KEY (item_id)
REFERENCES public.aws_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_permission_configuration_object_id | type: CONSTRAINT --
-- ALTER TABLE public.aws_permission_configuration DROP CONSTRAINT IF EXISTS aws_permission_configuration_object_id CASCADE;
ALTER TABLE public.aws_permission_configuration ADD CONSTRAINT aws_permission_configuration_object_id FOREIGN KEY (item_id)
REFERENCES public.aws_storage_objects (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_objects DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_objects ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_storage_objects_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_objects DROP CONSTRAINT IF EXISTS azr_storage_objects_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_objects ADD CONSTRAINT azr_storage_objects_id FOREIGN KEY (resource_id)
REFERENCES public.azr_storage_objects (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_objects DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_objects ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storages DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_aws_storages ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_storage_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storages DROP CONSTRAINT IF EXISTS aws_storage_id CASCADE;
ALTER TABLE public.link_permissions_aws_storages ADD CONSTRAINT aws_storage_id FOREIGN KEY (resource_id)
REFERENCES public.aws_storages (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storages DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_aws_storages ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_containers DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_containers ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_storage_container_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_containers DROP CONSTRAINT IF EXISTS aws_storage_container_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_containers ADD CONSTRAINT aws_storage_container_id FOREIGN KEY (resource_id)
REFERENCES public.aws_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_containers DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_containers ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_objects DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_objects ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: aws_storage_objects_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_objects DROP CONSTRAINT IF EXISTS aws_storage_objects_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_objects ADD CONSTRAINT aws_storage_objects_id FOREIGN KEY (resource_id)
REFERENCES public.aws_storage_objects (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_aws_storage_objects DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_aws_storage_objects ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storages DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_azr_storages ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_storage_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storages DROP CONSTRAINT IF EXISTS azr_storage_id CASCADE;
ALTER TABLE public.link_permissions_azr_storages ADD CONSTRAINT azr_storage_id FOREIGN KEY (resource_id)
REFERENCES public.azr_storages (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storages DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_azr_storages ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: permission_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_containers DROP CONSTRAINT IF EXISTS permission_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_containers ADD CONSTRAINT permission_id FOREIGN KEY (permission_id)
REFERENCES public.permissions (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: azr_storage_containers_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_containers DROP CONSTRAINT IF EXISTS azr_storage_containers_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_containers ADD CONSTRAINT azr_storage_containers_id FOREIGN KEY (resource_id)
REFERENCES public.azr_storage_containers (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: group_id | type: CONSTRAINT --
-- ALTER TABLE public.link_permissions_azr_storage_containers DROP CONSTRAINT IF EXISTS group_id CASCADE;
ALTER TABLE public.link_permissions_azr_storage_containers ADD CONSTRAINT group_id FOREIGN KEY (group_id)
REFERENCES public.groups (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --


