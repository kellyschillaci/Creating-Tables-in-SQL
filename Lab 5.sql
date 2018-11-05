/*
	Author: Kelly Schillaci
	Course: IST659
	Term: July 2018
*/
-- Creating the User Table

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_UserTagList')
BEGIN
	DROP TABLE vc_UserTagList
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_VidCastTagList')
BEGIN
	DROP TABLE vc_VidCastTagList
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_VidCast')
BEGIN
	DROP TABLE vc_VidCast
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_Status')
BEGIN
	DROP TABLE vc_Status
END
GO






IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_Tag')
BEGIN
	DROP TABLE vc_Tag
END
GO



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_FollowerList')
BEGIN
	DROP TABLE vc_FollowerList
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_UserLogin')
BEGIN
	DROP TABLE vc_UserLogin
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vc_User')
BEGIN
	DROP TABLE vc_User
END
GO







CREATE TABLE vc_User (
	-- Columns for the User Table
	vc_UserID int identity,
	UserName varchar(20) NOT NULL,
	EmailAddress varchar (50) NOT NULL,
	UserDescription varchar (200),
	WebsiteURL varchar(50),
	UserRegisteredDate datetime NOT NULL DEFAULT GetDate (),
	--Constraints on the User Table
	CONSTRAINT pk_vc_User PRIMARY KEY (vc_UserID),
	CONSTRAINT U1_vc_User UNIQUE (UserName),
	CONSTRAINT U2_vc_User UNIQUE (EmailAddress)
)
--End Creating User Table
--Creating the User Login Table
CREATE TABLE vc_UserLogin (
	--Columns for the User Login Table
	vc_UserLoginID int identity,
	vc_UserID int NOT NULL,
	UserLoginTimeStamp datetime NOT NULL DEFAULT GetDate (),
	LoginLocation varchar(50) NOT NULL,
	--Contraints for the User Login Table
	CONSTRAINT pk_vc_UserLogin PRIMARY KEY (vc_UserLoginID),
	CONSTRAINT fk1_vc_UserLogin FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
)
--End Creating User Login Table

--Adding Data to the User Table
INSERT INTO vc_User(UserName, EmailAddress, UserDescription) 
	VALUES
		('RDwight', 'rdwight@nodomain.xyz', 'Piano Teacher'),
		('SaulHudson', 'slash@nodomain.xyz', 'I like Les Paul guitars'),
		('Gordon', 'sumner@nodomain.xyz', 'Former Cop')
SELECT * FROM vc_User
--Creating the Follower List Table
CREATE TABLE vc_FollowerList (
	--Columns for the Follower List Table
	vc_FollowerListID int identity,
	FollowerID int NOT NULL,
	FollowedID int NOT NULL,
	FollowerSince datetime NOT NULL,
	--Constraints on the Follower Table
	CONSTRAINT PK_vc_FollowerList PRIMARY KEY (vc_FollowerListID),
	CONSTRAINT U1_vc_FollowerList UNIQUE (FollowerID, FollowedID),
	CONSTRAINT FK1_vc_FollowerList FOREIGN KEY (FollowerID) REFERENCES vc_User(vc_UserID),
	CONSTRAINT FK2_vc_FollowerList FOREIGN KEY (FollowedID) REFERENCES vc_User(vc_UserID)
)
--End creating the Follower List Table
CREATE TABLE vc_Tag (
	vc_TagID int identity PRIMARY KEY,
	TagText varchar(20) NOT NULL UNIQUE,
	TagDescription varchar(100)
)
CREATE TABLE vc_Status (
	vc_StatusID int identity PRIMARY KEY,
	StatusText varchar(20) UNIQUE
)
CREATE TABLE vc_VidCast (
	vc_VidCastID int identity PRIMARY KEY,
	VidCastTitle varchar(50) NOT NULL,
	StartDateTime datetime,
	EndDateTime datetime, 
	ScheduleDurationMinutes int,
	RecordingURL varchar(50),
	vc_UserID int FOREIGN KEY REFERENCES vc_User(vc_UserID) NOT NULL,
	vc_StatusID int FOREIGN KEY REFERENCES vc_Status(vc_StatusID) NOT Null
)
CREATE TABLE vc_VidCastTagList (
	vc_VidCastTagList int identity PRIMARY KEY,
	vc_TagID int FOREIGN KEY REFERENCES vc_Tag(vc_TagID) UNIQUE NOT NULL,
	vc_VidCastID int FOREIGN KEY REFERENCES vc_VidCast(vc_VidCastID) UNIQUE NOT NULL
)
CREATE TABLE vc_UserTagList (
	vc_UserTagListID int identity PRIMARY KEY,
	vc_TagID int NOT NULL,
	vc_UserID int NOT NULL,
	CONSTRAINT FK1_vc_UserTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID),
	CONSTRAINT FK2_vc_UserTagList FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
)
SELECT * FROM vc_UserTagList
