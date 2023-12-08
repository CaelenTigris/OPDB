USE [perpetuumsa]
GO

PRINT N'00_Landmines.sql';

---- Add new aggregate fields for Landmines and detection range

INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
('trigger_mass', 0, 'mass_unit', 1, 0, 0, 0, NULL, NULL, NULL),
('mine_detection_range', 1, 'mine_detection_range_unit', 10, 0, 5, 0, 1, 1, NULL),
('mine_detection_range_modifier', 0, 'mine_detection_range_modifier_unit', 100, -100, 5, 0, 1, 1, NULL),
('effect_mine_detection_range_modifier', 0, 'effect_mine_detection_range_modifier_unit', 100, -100, 6, 0, 1, 1, NULL),
('effect_enhancer_mine_detection_range_modifier', 0, 'effect_enhancer_mine_detection_range_modifier_unit', 100, -100, 6, 0, 1, 1, NULL)

GO

---- Landmines category ----

INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(263314, 'cf_landmines', 'Landmines', 0, 0)

-- Light landmines subcategory --
INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(17040530, 'cf_light_landmines', 'Light landmines', 0, 0)

-- Medium landmines subcategory --

INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(33817746, 'cf_medium_landmines', 'Medium landmines', 0, 0)

-- Heavy landmines subcategory --

INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(50594962, 'cf_heavy_landmines', 'Heavy landmines', 0, 0)

GO

---- Landmines definitions ----

-- Light landmine (deployed) --

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_light_landmine', 1, 1024, 17040530, '#triggerMass=n10000', NULL, 1, 1.5, 1000, 0, 100, 'def_light_landmine_desc', 0, 0, 0)

-- Light landmine (capsule) --
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_light_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_light_landmine_capsule_desc', 1, 0, 0)

-- Medium landmine (deployed) --
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_medium_landmine', 1, 1024, 33817746, '#triggerMass=n20000', NULL, 1, 1.5, 1000, 0, 100, 'def_medium_landmine_desc', 0, 0, 0)

-- Medium landmine (capsule) --
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_medium_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_medium_landmine_capsule_desc', 1, 0, 0)

-- Heavy landmine (deployed) --
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_heavy_landmine', 1, 1024, 50594962, '#triggerMass=n30000', NULL, 1, 1.5, 1000, 0, 100, 'def_heavy_landmine_desc', 0, 0, 0)

-- Heavy landmine (capsule) --

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_heavy_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_heavy_landmine_capsule_desc', 1, 0, 0)

GO

---- Landmines attributes ----

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

-- Light landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_light_landmine' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10000);

-- Medium landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_medium_landmine' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20000);

-- Heavy landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_heavy_landmine' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30000);

GO

---- Stats for landmines in cargo to display in properties ----

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

-- Light Landines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_light_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 28800000);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 150);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10000);

-- Medium Landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_medium_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 28800000);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 450);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20000);

-- Heavy Landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_heavy_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 28800000);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1350);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30000);

GO

---- Link landmine capsules with landmines ----

DECLARE @lightMine INT
DECLARE @lightMineCapsule INT
DECLARE @mediumMine INT
DECLARE @mediumMineCapsule INT
DECLARE @heavyMine INT
DECLARE @heavyMineCapsule INT

SET @lightMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_light_landmine' ORDER BY definition DESC);
SET @lightMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_light_landmine_capsule' ORDER BY definition DESC);
SET @mediumMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_medium_landmine' ORDER BY definition DESC);
SET @mediumMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_medium_landmine_capsule' ORDER BY definition DESC);
SET @heavyMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_heavy_landmine' ORDER BY definition DESC);
SET @heavyMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_heavy_landmine_capsule' ORDER BY definition DESC);

INSERT INTO definitionconfig (definition, targetdefinition) VALUES
(@lightMine, NULL),
(@lightMineCapsule, @lightMine),
(@mediumMine, NULL),
(@mediumMineCapsule, @mediumMine),
(@heavyMine, NULL),
(@heavyMineCapsule, @heavyMine)

GO

---- New stat mine detection for all robots ----
DECLARE @definitionID int;
DECLARE @categoryFlags int;
DECLARE @aggfieldID int;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mine_detection_range' ORDER BY [name] DESC);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_robot_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_runner_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_crawler_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_mech_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_heavymech_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_walker_chassis')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults where categoryflags = @categoryFlags);

-- Hermes has 100m base landmines detection range --
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);

UPDATE [dbo].[aggregatevalues] SET value = 10 WHERE [definition] = @definitionID and [field] = @aggfieldID;

GO

---- Hermes bonus based on High-tech specialist extension ----

DECLARE @definition INT
DECLARE @extension INT
DECLARE @property INT

SET @definition = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis')
SET @extension = (SELECT TOP 1 extensionid from extensions WHERE [extensionname] = 'ext_high_tech_specialist')
SET @property = (SELECT TOP 1 id from aggregatefields WHERE name = 'mine_detection_range')

INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer) VALUES
(@definition, @extension, 0.3, NULL, @property, 0)

GO

---- Landmine detectors category ----

INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(983823, 'cf_landmine_detectors', 'Landmine Detectors', 0, 1)

GO

---- Landmine detectors, prototypes and cts ----

DECLARE @categoryFlags int

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_landmine_detectors')

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_standart_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t1', NULL, 1, 0.5, 1000, 0, 100, 'def_standart_landmine_detector_desc', 1, 1, 1),
('def_named1_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t2', NULL, 1, 1.5, 900, 0, 100, 'def_named_landmine_detector_desc', 1, 1, 2),
('def_named1_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t2_pr', NULL, 1, 1.5, 800, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 2),
('def_named2_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t3', NULL, 1, 1.5, 1000, 0, 1100, 'def_named_landmine_detector_desc', 1, 1, 3),
('def_named2_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t3_pr', NULL, 1, 1.5, 1000, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 3),
('def_named3_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t4', NULL, 1, 1.5, 1200, 0, 100, 'def_named_landmine_detector_desc', 1, 1, 4),
('def_named3_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t4_pr', NULL, 1, 1.5, 1100, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 4)

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_engineering_calibration_programs')

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_standart_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t1', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1),
('def_named1_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t2', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2),
('def_named2_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t3', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3),
('def_named3_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t4', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)

GO

---- Landmine detector modules and prototypes stats ----

DECLARE @core_usage_field int
DECLARE @cpu_usage_field int
DECLARE @cycle_time_field int
DECLARE @powergrid_usage_field int
DECLARE @effect_mine_detection_range_modifier_field int
DECLARE @definition int

SET @core_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')
SET @cpu_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')
SET @cycle_time_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')
SET @powergrid_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')
SET @effect_mine_detection_range_modifier_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_mine_detection_range_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 20),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 18),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 6),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 12),
(@definition, @cpu_usage_field, 17),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 6),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 23),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.4)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 12),
(@definition, @cpu_usage_field, 22),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.4)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 18),
(@definition, @cpu_usage_field, 25),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 8),
(@definition, @effect_mine_detection_range_modifier_field, 1.5)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
INSERT INTO aggregatevalues (definition, field, value) VALUES
(@definition, @core_usage_field, 15),
(@definition, @cpu_usage_field, 24),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 8),
(@definition, @effect_mine_detection_range_modifier_field, 1.5)

GO

---- Production and prorotyping cost in materials, modulesand components ----

DECLARE @definition INT

DECLARE @titanium_definition INT
DECLARE @cryoperine_definition INT
DECLARE @espitium INT
DECLARE @bryochite INT

DECLARE @common_basic_components INT
DECLARE @common_advanced_components INT
DECLARE @common_expert_components INT

DECLARE @t1_mine_detector INT
DECLARE @t2_mine_detector INT
DECLARE @t3_mine_detector INT

SET @titanium_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_titanium')
SET @cryoperine_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_axicol') -- axicoline Y U NO cryoperine
SET @espitium = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_espitium')
SET @bryochite = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_unimetal') -- unimetal Y U NO bryochite

SET @common_basic_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
SET @common_advanced_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
SET @common_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')

SET @t1_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @t2_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
SET @t3_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')

-- Modules --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @t1_mine_detector, 1),
(@definition, @common_basic_components, 30)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 200),
(@definition, @espitium, 200),
(@definition, @t2_mine_detector, 1),
(@definition, @common_basic_components, 20),
(@definition, @common_advanced_components, 20)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @espitium, 400),
(@definition, @bryochite, 400),
(@definition, @t3_mine_detector, 1),
(@definition, @common_basic_components, 15),
(@definition, @common_advanced_components, 30),
(@definition, @common_expert_components, 45)

-- Prototypes --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @t1_mine_detector, 1),
(@definition, @common_basic_components, 30)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 200),
(@definition, @espitium, 200),
(@definition, @t2_mine_detector, 1),
(@definition, @common_basic_components, 20),
(@definition, @common_advanced_components, 20)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @espitium, 400),
(@definition, @bryochite, 400),
(@definition, @t3_mine_detector, 1),
(@definition, @common_basic_components, 15),
(@definition, @common_advanced_components, 30),
(@definition, @common_expert_components, 45)

GO

---- Research levels ----

DECLARE @definition INT
DECLARE @calibration INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector_cprg')
INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_cprg')
INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 7, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_cprg')
INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 8, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_cprg')
INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 9, @calibration, 1)

GO

---- Position in tech tree ----

DECLARE @parent INT
DECLARE @t1 INT
DECLARE @t2 INT
DECLARE @t3 INT
DECLARE @t4 INT
DECLARE @group INT

SET @parent = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_blob_emission_modulator')
SET @t1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @t2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
SET @t3 = (SELECT TOP 1 definition definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
SET @t4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
SET @group = (SELECT TOP 1 id FROM [techtreegroups] WHERE name = 'common2')

INSERT INTO [techtree] (parentdefinition, childdefinition, groupID, x, y, enablerextensionid) VALUES
(@parent, @t1, @group, 5, 19, NULL),
(@t1, @t2, @group, 6, 19, NULL),
(@t2, @t3, @group, 7, 19, NULL),
(@t3, @t4, @group, 8, 19, NULL)

GO

----Research cost ----

DECLARE @definition INT
DECLARE @common INT
DECLARE @hightech INT

SET @common = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'common')
SET @hightech = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'hitech')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 25000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 68600)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 51200)
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @hightech, 25600)

GO

---- Link modules and their prototypes----

DECLARE @module int
DECLARE @prototype int

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_landmine_detector_pr')

INSERT INTO prototypes (definition, prototype) VALUES (@module, @prototype)

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_landmine_detector_pr')

INSERT INTO prototypes (definition, prototype) VALUES (@module, @prototype)

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_landmine_detector_pr')

INSERT INTO prototypes (definition, prototype) VALUES (@module, @prototype)

GO

---- Landmine detection effect category ----

INSERT INTO effectcategories (name, flag, maxlevel, note) VALUES
('effcat_mine_detection', 46, 1, NULL)

---- Landmine detection effect ----

INSERT INTO effects (effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
(70368744177664, 10500, 'effect_mine_detector', 'effect_mine_detector_desc', 'mine detector', 0, 0, 1, 3, 0)

GO

---- Link effect modifier with it's enhancer

DECLARE @category INT
DECLARE @basefield INT
DECLARE @modifier INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_landmine_detectors')
SET @basefield = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_mine_detection_range_modifier')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_enhancer_mine_detection_range_modifier')

INSERT INTO aggregatemodifiers (categoryflag, basefield, modifierfield) VALUES
(@category, @basefield, @modifier)

GO

---- Add landmines to public market ----

DECLARE @public_market_definition INT
SET @public_market_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_public_market')

DECLARE @definition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_light_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT v.marketEID, v.vendorEID, @definition, 0, 1, 500000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 50000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_medium_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 1, 1000000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 100000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_heavy_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 1, 1500000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 150000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)
	
GO

PRINT N'01_Spectator.sql';

---- Create category flags for sentry turrets and remote controllers

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3474, 'cf_sentry_turrets', 'Sentry Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controlled_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(8202, 'cf_remote_controlled_units', 'Remote controlled units', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(1056778, 'cf_sentry_turret_units', 'Sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controllers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(722703, 'cf_remote_controllers', 'Remote controllers', 0, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_guns' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(788239, 'cf_sentry_turret_guns', 'Sentry Turret Guns', 1, 1)
END

---- Add new slot flag

IF NOT EXISTS (SELECT 1 FROM slotFlags WHERE name = 'specialized' )
BEGIN
	INSERT INTO slotFlags (offset, name, note) VALUES (11, 'specialized', 'Special slot for remote comtrollers')
END

GO

---- Add new aggregate fields

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_max', 1,'remote_control_bandwidth_max_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_max_modifier', 1,'remote_control_bandwidth_max_modifier_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_usage', 1,'remote_control_bandwidth_usage_unit', 1, 0, 3, 0, 1, 1, 'Channel usage')
END

GO

---- Create entity defaults for turret launchers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 4)
END

GO

---- Create definitions for Sentry turrets

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_sentry_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_improved_sentry_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_advanced_sentry_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_high_power_sentry_turret_desc', 0, 1, 1)
END

GO

---- Create definitions for Sentry turret guns

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_guns')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_sentry_turret_gun_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_improved_sentry_turret_gun_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_advanced_sentry_turret_gun_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_high_power_sentry_turret_gun_desc', 0, 1, 4)
END

GO

---- Create sentry turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_sentry_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_improved_sentry_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_advanced_sentry_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_high_power_sentry_turret_unit_desc', 1, 1, 1)
END

GO

---- Set up aggregate fields for turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

GO

---- Create turret templates

DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_gun')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_sentry_turret', @description, 'Standart sentry turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'improved_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret_gun')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('improved_sentry_turret', @description, 'Improved sentry turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'advanced_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret_gun')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('advanced_sentry_turret', @description, 'Advanced sentry turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'high_power_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret_gun')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('high_power_sentry_turret', @description, 'High power sentry turret template')
END

GO

---- Link sentry turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'improved_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Improved sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'advanced_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Advanced sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'high_power_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'High power sentry turret')
END

GO

---- Set up aggregate fields for sentry turrets

DECLARE @definition INT
DECLARE @field INT

-- Standart Sentry turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Improved Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 110)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Advanced Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 80)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 120)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 160)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- High power Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 130)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 170)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

GO

---- Set up aggregate fields for turret launchers

DECLARE @definition INT
DECLARE @field INT

---- Max bandwidth

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Accumulator usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 55)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- CPU usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 77)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Cycle time

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Optimal range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Reactor usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END

GO

---- Create categories for command bots

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_command_robots')
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(4097, 'cf_command_robots', 'Command robots', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_combat_command_robots')
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(69633, 'cf_combat_command_robots', 'Combat command robots', 0, 0)
END

GO

---- Create entity defaults for Spectator

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_chassis', 1, 1024, @category, '#slotFlags=4d3,6d0 #height=f2.00 #decay=n500', 1, 100, 78000, 1, 100, 'def_spectator_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_head', 1, 1024, @category, '#slotFlags=4808,8,8,8,8,8  #height=f0.10', 1, 3, 3000, 1, 100, 'def_spectator_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_leg', 1, 1024, @category, '#slotFlags=420,20,20,20,20  #height=f1.10', 1, 20, 18000, 1, 100, 'def_spectator_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_spectator', 1, 4195336, @category, '#capacity=f1080.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_command_robots')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_bot', 1, 0, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_spectator_bot_desc', 1, 1, 3)
END

GO

---- Create robot definitions and it's template and link them

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'spectator_empty')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('spectator_empty', CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X')), 'Spectator')
END

DECLARE @template INT

SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'spectator_empty')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_spectator_bot')
END

GO

---- Set up aggregate fields for Spectator

DECLARE @definition INT
DECLARE @field INT

-- Legs

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.7)
END

-- Head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 495)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 12500)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 80)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 340)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 95)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END


-- Chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2750)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 720)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 825)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 23)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

GO

---- Add new robot control extensions

DECLARE @extensionsCategory INT

SET @extensionsCategory = (SELECt TOP 1 extensioncategoryid FROM extensioncategories WHERE categoryname = 'extcat_vehicle_control')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_command_robotics')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, effectenhancer, hidden, freezelimit) VALUES
	(365, 'ext_command_robotics', @extensionsCategory, 5, 'attributeA', 0.03, 'Enabler for command bots', 125000, 1, 'ext_command_robotics_desc', 0, 0, 7)
END

GO

---- Add enabler extensions for Spectator

DECLARE @definition INT
DECLARE @extension INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

GO

---- Add chassis bonuses and link them with extensions and aggregate fields

DECLARE @definition INT
DECLARE @extension INT
DECLARE @field INT

-- Chassis
    
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_glider_specialist')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, -0.02, @field, 0)
END

-- Head (whyyyy)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.03, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'massiveness')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

-- Leg

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

GO

---- Set aggregate field values to sentry turret guns

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 1.6)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 17)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4000)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12.5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- improved

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_improved_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 1.8)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 14)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3500)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12.5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- advanced

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_advanced_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 11)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3000)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12.5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- high power

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_high_power_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2.2)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 8)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2500)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12.5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

GO

---- Add new extensions category

IF NOT EXISTS (SELECT 1 FROM extensioncategories WHERE categoryname = 'extcat_remote_command')
BEGIN
	INSERT INTO extensioncategories (extensioncategoryid, categoryname, hidden) VALUES
	(10, 'extcat_remote_command', 0)
END

GO

---- Add new extensions

DECLARE @extensionsCategory INT
DECLARE @field INT

SET @extensionsCategory = (SELECT TOP 1 extensioncategoryid FROM extensioncategories WHERE categoryname = 'extcat_remote_command')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_remote_control')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(366, 'ext_remote_control', @extensionsCategory, 5, 'attributeA', 1, '', 125000, 1, 'ext_remote_control_desc', @field, 0, 0, 7)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(367, 'ext_sentry_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level sentry turrets', 125000, 1, 'ext_sentry_turrets_experience_desc', NULL, 0, 0, 4)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(368, 'ext_mining_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level mining turrets', 125000, 1, 'ext_mining_turrets_experience_desc', NULL, 0, 0, 4)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(369, 'ext_harvesting_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level harvesting turrets', 125000, 1, 'ext_harvesting_turrets_experience_desc', NULL, 0, 0, 4)
END

GO

---- Link base value with modifier via category flag

DECLARE @category INT
DECLARE @base INT
DECLARE @modifier INT

-- remote controllers

-- bandwidth

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')
SET @base = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM [modulepropertymodifiers] WHERE categoryflags = @category AND baseField = @base AND modifierField = @modifier)
BEGIN
	INSERT INTO [modulepropertymodifiers] (categoryflags, baseField, modifierField) VALUES
	(@category, @base, @modifier)
END

---- Add enabler extensions for sentry turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- improved

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- advanced

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- high power

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-------------------------

---- Create category flags for mining turrets

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_mining_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3730, 'cf_mining_turrets', 'Mining Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_mining_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(2105354, 'cf_mining_turret_units', 'Mining turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_industrial_turret_drillers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(198159, 'cf_industrial_turret_drillers', 'Industrial Turret Drillers', 1, 1)
END

GO

---- Crete definitions for Mining turrets

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_mining_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_mining_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_improved_mining_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_mining_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_advanced_mining_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_mining_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_high_power_mining_turret_desc', 0, 1, 1)
END

GO

---- Create definitions for Mining turret drillers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_industrial_turret_drillers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_industrial_turret_driller_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_improved_industrial_turret_driller_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_advanced_industrial_turret_driller_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_high_power_industrial_turret_driller_desc', 0, 1, 4)
END

GO

---- Create mining turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_mining_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_improved_mining_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_advanced_mining_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_high_power_mining_turret_unit_desc', 1, 1, 1)
END

GO

---- Set up aggregate fields for mining turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

GO

---- Create mining turret templates

DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)
DECLARE @cargo INT

SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_sequer')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_mining_turret', @description, 'Standart mining turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'improved_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_driller')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('improved_mining_turret', @description, 'Improved mining turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'advanced_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_driller')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]|m2=[|definition=i326|slot=i3]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('advanced_mining_turret', @description, 'Advanced mining turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'high_power_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_driller')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]|m2=[|definition=i326|slot=i3]|m3=[|definition=i326|slot=i4]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('high_power_mining_turret', @description, 'High power mining turret template')
END

GO

---- Link mining turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'improved_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Improved mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'advanced_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Advanced mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'high_power_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'High power mining turret')
END

GO

---- Set up aggregate fields for mining turrets

DECLARE @definition INT
DECLARE @field INT

-- Standart Mining turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Improved mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 110)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Advanced Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 80)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 120)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 160)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- High power mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 130)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 170)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

GO

---- Set aggregate field values to mining turret drillers

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- improved

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_improved_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- advanced

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_advanced_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 8000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- high power

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_high_power_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 6000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

GO

---- Add enabler extensions for sentry turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- improved

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- advanced

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- high power

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-- assign beams to drillers

DECLARE @moduleId INT
DECLARE @beamId INT

SET @beamId = (SELECT TOP 1 id FROM beams WHERE name = 'small_driller')

-- standart

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- improved

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- advanced

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- high power

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

GO

-------------------------

---- Create category flags for harvesting turrets

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_harvesting_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3986, 'cf_harvesting_turrets', 'Harvesting Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_harvesting_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3153930, 'cf_harvesting_turret_units', 'Harvesting turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_industrial_turret_harvesters' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(525839, 'cf_industrial_turret_harvesters', 'Industrial Turret Drillers', 1, 1)
END

GO

---- Crete definitions for harvesting turrets

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_harvesting_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_harvesting_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_improved_harvesting_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_harvesting_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_advanced_harvesting_turret_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_harvesting_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_high_power_harvesting_turret_desc', 0, 1, 1)
END

GO

---- Create definitions for industrial turret harvesters

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_industrial_turret_harvesters')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_industrial_turret_harvester_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_improved_industrial_turret_harvester_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_advanced_industrial_turret_harvester_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_high_power_industrial_turret_harvester_desc', 0, 1, 4)
END

GO

---- Create harvesting turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_harvesting_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_improved_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_improved_harvesting_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_advanced_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_advanced_harvesting_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_high_power_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_high_power_harvesting_turret_unit_desc', 1, 1, 1)
END

GO

---- Set up aggregate fields for harvesting turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

GO

---- Create harvesting turret templates

DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)
DECLARE @cargo INT

SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_sequer')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_harvesting_turret', @description, 'Standart harvesting turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'improved_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_harvester')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]]#headModules=[|m0=[|definition=i326|slot=i1]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('improved_harvesting_turret', @description, 'Improved harvesting turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'advanced_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_harvester')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]|m2=[|definition=i326|slot=i3]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('advanced_harvesting_turret', @description, 'Advanced mining turret template')
END

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'high_power_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_harvester')

	SET @description = CONCAT('#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i', FORMAT(@cargo, 'X'), '#headModules=[|m0=[|definition=i326|slot=i1]|m1=[|definition=i326|slot=i2]|m2=[|definition=i326|slot=i3]|m3=[|definition=i326|slot=i4]]#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('high_power_harvesting_turret', @description, 'High power harvesting turret template')
END

GO

---- Link harvesting turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'improved_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Improved harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'advanced_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Advanced harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'high_power_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'High power harvesting turret')
END

GO

---- Set up aggregate fields for harvesting turrets

DECLARE @definition INT
DECLARE @field INT

-- Standart harvesting turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Improved mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 110)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Advanced Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 80)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 40)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 120)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 160)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- High power mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret')

---- Armor

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

---- Accumulator

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8000)
END

---- Detection

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

---- Masking

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

---- Accumulator recharge

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 130)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 170)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END

---- Remote channel bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

GO

---- Set aggregate field values to industrial turret harvesters

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 12000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- improved

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_improved_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- advanced

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_advanced_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 8000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- high power

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_high_power_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 6000)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

GO

---- Add enabler extensions for harvesting turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- improved

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- advanced

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- high power

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-- assign beams to drillers

DECLARE @moduleId INT
DECLARE @beamId INT

SET @beamId = (SELECT TOP 1 id FROM beams WHERE name = 'small_harvester')

-- standart

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- improved

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_improved_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- advanced

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_advanced_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- high power

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_high_power_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

GO

PRINT N'Completed';