-- ------------------------------------
-- ------------------------------------
-- Delete all the pantheon beliefs (they'll be replaced)
-- ------------------------------------
-- ------------------------------------
DELETE FROM Types WHERE Type IN (
    SELECT Type FROM Types INNER JOIN Beliefs ON Beliefs.BeliefType = Types.Type AND Beliefs.BeliefClassType = 'BELIEF_CLASS_PANTHEON'
) ;
DELETE FROM Beliefs WHERE BeliefClassType = 'BELIEF_CLASS_PANTHEON' ;




-- The order they're inserted determines the order they are listed in the Choose Pantheon screen
-- After 19 you need to use a second file otherwise it screws up the order (see OP2.sql)

-- ------------------------------------
--  Alpheus
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_ALPHEUS', 'KIND_BELIEF') ;
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_ALPHEUS', 'LOC_OP_ALPHEUS', 'LOC_OP_ALPHEUS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    GOLD yield
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
			                ('OP_ALPHEUS', 'OP_ALPHEUS_CITY_APPLIES_MODIFIER_GOLD') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ALPHEUS_CITY_APPLIES_MODIFIER_GOLD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ALPHEUS_CITY_APPLIES_MODIFIER_GOLD', 'ModifierId', 'OP_ALPHEUS_INCREASES_ON_RIVER_GOLD') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ALPHEUS_INCREASES_ON_RIVER_GOLD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_ADJACENT_TO_RIVER_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ALPHEUS_INCREASES_ON_RIVER_GOLD', 'YieldType', 'YIELD_GOLD'),
							  ('OP_ALPHEUS_INCREASES_ON_RIVER_GOLD', 'Amount', 1) ;
--    Holy Site Faith for River Adjacency
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ALPHEUS', 'OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY', 'DB_DM_CITIES_RIVER_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							  ('OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_RIVER_FAITH'),
							  ('OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                              ('OP_ALPHEUS_RIVER_HOLY_SITE_ADJACENCY', 'Amount', 5) ;


-- ------------------------------------
--   Aphrodite
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_APHRODITE', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_APHRODITE', 'LOC_OP_APHRODITE', 'LOC_OP_APHRODITE_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;

-- Breathtaking plots
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_APHRODITE', 'OP_APHRODITE_FAITH_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APHRODITE_FAITH_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_APHRODITE_FAITH_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_APHRODITE_FAITH_INCREASES_ON_BREATHTAKING') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APHRODITE_FAITH_INCREASES_ON_BREATHTAKING', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_BREATHTAKING_APPEAL') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_APHRODITE_FAITH_INCREASES_ON_BREATHTAKING', 'YieldType', 'YIELD_FAITH'),
							  ('OP_APHRODITE_FAITH_INCREASES_ON_BREATHTAKING', 'Amount', 2) ;

-- Breathtaking Districts
INSERT INTO BeliefModifiers (BeliefType, ModifierID) 
  SELECT 'OP_APHRODITE', 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10)  FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) 
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'DB_DM_CITIES_ADJUST_DISTRICTS_YIELD_BASED_ON_APPEAL', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'  FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'Description', 'LOC_OP_DISTRICT_APPEAL_FAITH'  FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'DistrictType', DistrictType  FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'RequiredAppeal', 4  FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'YieldType', 'YIELD_FAITH' FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
  SELECT 'OP_APHRODITE_BREATHTAKING_' || SUBSTR(DistrictType, 10), 'YieldChange', 2 FROM Districts WHERE TraitType IS NULL AND DistrictType NOT LIKE '%wonder%' AND DistrictType NOT LIKE '%city_center%' ;


-- ------------------------------------
--  Apollo
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_APOLLO', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_APOLLO', 'LOC_OP_APOLLO', 'LOC_OP_APOLLO_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    PRODUCTION on PASTURE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_APOLLO', 'OP_APOLLO_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_APOLLO_PRODUCTION_INCREASES_ON_PASTURE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_PRODUCTION_INCREASES_ON_PASTURE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_PASTURE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_APOLLO_PRODUCTION_INCREASES_ON_PASTURE', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_APOLLO_PRODUCTION_INCREASES_ON_PASTURE', 'Amount', 1) ;
--    CULTURE on PASTURE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_APOLLO', 'OP_APOLLO_CULTURE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_CULTURE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_CULTURE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_APOLLO_CULTURE_INCREASES_ON_PASTURE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_CULTURE_INCREASES_ON_PASTURE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_PASTURE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_APOLLO_CULTURE_INCREASES_ON_PASTURE', 'YieldType', 'YIELD_CULTURE'),
							  ('OP_APOLLO_CULTURE_INCREASES_ON_PASTURE', 'Amount', 2) ;
--    Reverse Holy Site Adjacency  //  FAITH on PASTURE adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_APOLLO', 'OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_PASTURE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_PASTURE_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_PASTURE_ADJACENCY_REVERSE', 'ModifierId', 'OP_APOLLO_FAITH_PASTURE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_FAITH_PASTURE_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_PASTURE_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_FAITH_PASTURE_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_APOLLO_FAITH_PASTURE_ADJACENCY_REVERSE', 'Amount', 5) ;
-- 5 FAITH on Oracle
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_APOLLO', 'OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_ON_ORACLE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_ON_ORACLE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_CITY_APPLIES_MODIFIER_FAITH_ON_ORACLE', 'ModifierId', 'OP_APOLLO_FAITH_INCREASES_ON_ORACLE') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_APOLLO_FAITH_INCREASES_ON_ORACLE', 'MODIFIER_BUILDING_YIELD_CHANGE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_APOLLO_FAITH_INCREASES_ON_ORACLE', 'BuildingType', 'BUILDING_ORACLE'),
                              ('OP_APOLLO_FAITH_INCREASES_ON_ORACLE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_APOLLO_FAITH_INCREASES_ON_ORACLE', 'Amount', 5) ;

-- ------------------------------------
--  Ares
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_ARES', 'KIND_BELIEF') ;
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_ARES', 'LOC_OP_ARES', 'LOC_OP_ARES_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;

INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_ARES', 'OP_ARES_FAITH_DISPERSAL') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARES_FAITH_DISPERSAL', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_FAITH_DISPERSAL', 'ModifierId', 'OP_ARES_FAITH_DISPERSAL_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_ARES_FAITH_DISPERSAL_MODIFIER', 'MODIFIER_PLAYER_ADJUST_FAITH_FROM_DISPERSAL') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_FAITH_DISPERSAL_MODIFIER', 'Amount', 500) ;


INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_ARES', 'OP_ARES_ON_CITY_CAPTURE') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_ARES_ON_CITY_CAPTURE', 'MODIFIER_PLAYER_CAPTURED_CITY_ATTACH_MODIFIER') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_ON_CITY_CAPTURE', 'ModifierId', 'OP_ARES_FAITH_FROM_CAPTURE') ;

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES 
                      ('OP_ARES_FAITH_FROM_CAPTURE', 'MODIFIER_PLAYER_GRANT_YIELD', 1, 1) ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_FAITH_FROM_CAPTURE', 'Amount', 500),
							  ('OP_ARES_FAITH_FROM_CAPTURE', 'Scale', 0),
							  ('OP_ARES_FAITH_FROM_CAPTURE', 'YieldType', 'YIELD_FAITH') ;

INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_ARES', 'OP_ARES_HOLY_SITE_FAITH_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARES_HOLY_SITE_FAITH_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_HOLY_SITE_FAITH_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ARES_HOLY_SITE_ADJACENT_TO_ENCAMPMENT') ;

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARES_HOLY_SITE_ADJACENT_TO_ENCAMPMENT', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DB_REQSET_IS_HOLY_SITE_NEXT_TO_ENCAMPMENT') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_ARES_HOLY_SITE_ADJACENT_TO_ENCAMPMENT', 'Amount', 10),
							  ('OP_ARES_HOLY_SITE_ADJACENT_TO_ENCAMPMENT', 'YieldType', 'YIELD_FAITH') ;
					  

-- ------------------------------------
--  Artemis
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_ARTEMIS', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_ARTEMIS', 'LOC_OP_ARTEMIS', 'LOC_OP_ARTEMIS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    FOOD on CAMP
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ARTEMIS', 'OP_ARTEMIS_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ARTEMIS_FOOD_INCREASES_ON_CAMP') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_FOOD_INCREASES_ON_CAMP', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_CAMP') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ARTEMIS_FOOD_INCREASES_ON_CAMP', 'YieldType', 'YIELD_FOOD'),
							  ('OP_ARTEMIS_FOOD_INCREASES_ON_CAMP', 'Amount', 2) ;
--    PRODUCTION on CAMP
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ARTEMIS', 'OP_ARTEMIS_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ARTEMIS_PRODUCTION_INCREASES_ON_CAMP') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_PRODUCTION_INCREASES_ON_CAMP', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_CAMP') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ARTEMIS_PRODUCTION_INCREASES_ON_CAMP', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_ARTEMIS_PRODUCTION_INCREASES_ON_CAMP', 'Amount', 1) ;
--    GOLD on CAMP
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ARTEMIS', 'OP_ARTEMIS_GOLD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_GOLD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_GOLD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ARTEMIS_GOLD_INCREASES_ON_CAMP') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_GOLD_INCREASES_ON_CAMP', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_CAMP') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ARTEMIS_GOLD_INCREASES_ON_CAMP', 'YieldType', 'YIELD_GOLD'),
							  ('OP_ARTEMIS_GOLD_INCREASES_ON_CAMP', 'Amount', 1) ;
--    Reverse Holy Site Adjacency  //  FAITH on CAMP adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ARTEMIS', 'OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_CAMP_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_CAMP_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_CAMP_ADJACENCY_REVERSE', 'ModifierId', 'OP_ARTEMIS_FAITH_CAMP_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_FAITH_CAMP_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_CAMP_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_FAITH_CAMP_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_ARTEMIS_FAITH_CAMP_ADJACENCY_REVERSE', 'Amount', 5) ;

-- 5 FAITH on TEMPLE_ARTEMIS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ARTEMIS', 'OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_ON_TEMPLE_ARTEMIS') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_ON_TEMPLE_ARTEMIS', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_CITY_APPLIES_MODIFIER_FAITH_ON_TEMPLE_ARTEMIS', 'ModifierId', 'OP_ARTEMIS_FAITH_INCREASES_ON_TEMPLE_ARTEMIS') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_ARTEMIS_FAITH_INCREASES_ON_TEMPLE_ARTEMIS', 'MODIFIER_BUILDING_YIELD_CHANGE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ARTEMIS_FAITH_INCREASES_ON_TEMPLE_ARTEMIS', 'BuildingType', 'BUILDING_TEMPLE_ARTEMIS'),
                              ('OP_ARTEMIS_FAITH_INCREASES_ON_TEMPLE_ARTEMIS', 'YieldType', 'YIELD_FAITH'),
							  ('OP_ARTEMIS_FAITH_INCREASES_ON_TEMPLE_ARTEMIS', 'Amount', 5) ;



-- ------------------------------------
--  Athena
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_ATHENA', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_ATHENA', 'LOC_OP_ATHENA', 'LOC_OP_ATHENA_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
-- move olives, dates, tomato to this pantheon
UPDATE TypeTags SET Tag = 'CLASS_ORAL_TRADITION' WHERE Tag = 'CLASS_GODDESS_OF_FESTIVALS' AND (Type = 'RESOURCE_OLIVES' OR Type = 'RESOURCE_DATES' OR Type = 'RESOURCE_TOMATO') ;

--    1 PRODUCTION on PLANTATION_TAG2
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATHENA', 'OP_ATHENA_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATHENA_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ATHENA_PRODUCTION_INCREASES_ON_PLANTATION_TAG2') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_PRODUCTION_INCREASES_ON_PLANTATION_TAG2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_PLANTATION_TAG2_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ATHENA_PRODUCTION_INCREASES_ON_PLANTATION_TAG2', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_ATHENA_PRODUCTION_INCREASES_ON_PLANTATION_TAG2', 'Amount', 1) ;
--    2 SCIENCE on PLANTATION_TAG2
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATHENA', 'OP_ATHENA_SCIENCE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_SCIENCE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATHENA_SCIENCE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ATHENA_SCIENCE_INCREASES_ON_PLANTATION_TAG2') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_SCIENCE_INCREASES_ON_PLANTATION_TAG2', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_PLANTATION_TAG2_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ATHENA_SCIENCE_INCREASES_ON_PLANTATION_TAG2', 'YieldType', 'YIELD_SCIENCE'),
							  ('OP_ATHENA_SCIENCE_INCREASES_ON_PLANTATION_TAG2', 'Amount', 2) ;
--    Reverse Holy Site Adjacency  //  2 FAITH on PLANTATION_TAG2 adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATHENA', 'OP_ATHENA_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATHENA_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE', 'ModifierId', 'OP_ATHENA_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATHENA_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_PLANTATION_TAG2_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATHENA_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_ATHENA_FAITH_PLANTATION_TAG2_ADJACENCY_REVERSE', 'Amount', 5) ;


-- ------------------------------------
--  ATLAS
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_ATLAS', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_ATLAS', 'LOC_OP_ATLAS', 'LOC_OP_ATLAS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    PRODUCTION on QUARRY
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATLAS', 'OP_ATLAS_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATLAS_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ATLAS_PRODUCTION_INCREASES_ON_QUARRY') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_PRODUCTION_INCREASES_ON_QUARRY', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_QUARRY_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ATLAS_PRODUCTION_INCREASES_ON_QUARRY', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_ATLAS_PRODUCTION_INCREASES_ON_QUARRY', 'Amount', 2) ;
--    FAITH on QUARRY
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATLAS', 'OP_ATLAS_FAITH_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_FAITH_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATLAS_FAITH_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_ATLAS_FAITH_INCREASES_ON_QUARRY') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_FAITH_INCREASES_ON_QUARRY', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_QUARRY_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_ATLAS_FAITH_INCREASES_ON_QUARRY', 'YieldType', 'YIELD_FAITH'),
							  ('OP_ATLAS_FAITH_INCREASES_ON_QUARRY', 'Amount', 1) ;
--    Reverse Holy Site Adjacency  //  FAITH on QUARRY adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_ATLAS', 'OP_ATLAS_CITY_APPLIES_MODIFIER_FAITH_QUARRY_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_CITY_APPLIES_MODIFIER_FAITH_QUARRY_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATLAS_CITY_APPLIES_MODIFIER_FAITH_QUARRY_ADJACENCY_REVERSE', 'ModifierId', 'OP_ATLAS_FAITH_QUARRY_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_ATLAS_FAITH_QUARRY_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_QUARRY_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_ATLAS_FAITH_QUARRY_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_ATLAS_FAITH_QUARRY_ADJACENCY_REVERSE', 'Amount', 4) ;


-- ------------------------------------
--  Demeter
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_DEMETER', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_DEMETER', 'LOC_OP_DEMETER', 'LOC_OP_DEMETER_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 FOOD on FARM
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DEMETER', 'OP_DEMETER_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_DEMETER_FOOD_INCREASES_ON_FARM') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FOOD_INCREASES_ON_FARM', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_FARM_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_DEMETER_FOOD_INCREASES_ON_FARM', 'YieldType', 'YIELD_FOOD'),
							  ('OP_DEMETER_FOOD_INCREASES_ON_FARM', 'Amount', 2) ;
--    1 FOOD on TERRACE_FARM
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DEMETER', 'OP_DEMETER_FOOD_TERRACE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FOOD_TERRACE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_FOOD_TERRACE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_DEMETER_FOOD_INCREASES_ON_TERRACE_FARM') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FOOD_INCREASES_ON_TERRACE_FARM', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_TERRACE_FARM') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_DEMETER_FOOD_INCREASES_ON_TERRACE_FARM', 'YieldType', 'YIELD_FOOD'),
							  ('OP_DEMETER_FOOD_INCREASES_ON_TERRACE_FARM', 'Amount', 2) ;
--    Reverse Holy Site Adjacency  //  FAITH on FARM adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DEMETER', 'OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_FARM_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_FARM_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_FARM_ADJACENCY_REVERSE', 'ModifierId', 'OP_DEMETER_FAITH_FARM_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FAITH_FARM_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_FARM_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_FAITH_FARM_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_DEMETER_FAITH_FARM_ADJACENCY_REVERSE', 'Amount', 3) ;
--    Reverse Holy Site Adjacency  //  FAITH on TERRACE_FARM adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DEMETER', 'OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_CITY_APPLIES_MODIFIER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE', 'ModifierId', 'OP_DEMETER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DEMETER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_TERRACE_FARM_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DEMETER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_DEMETER_FAITH_TERRACE_FARM_ADJACENCY_REVERSE', 'Amount', 3) ;



-- ------------------------------------
--  Dionysus
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_DIONYSUS', 'KIND_BELIEF') ;
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_DIONYSUS', 'LOC_OP_DIONYSUS', 'LOC_OP_DIONYSUS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
-- move spices, aloe, saffron to this pantheon
UPDATE TypeTags SET Tag = 'CLASS_GODDESS_OF_FESTIVALS' WHERE Tag = 'CLASS_ORAL_TRADITION' AND (Type = 'RESOURCE_SPICES' OR Type = 'RESOURCE_ALOE' OR Type = 'RESOURCE_SAFFRON') ;

--    Reverse Holy Site Adjacency  //  FAITH on PLANTATION_TAG adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DIONYSUS', 'OP_DIONYSUS_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DIONYSUS_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DIONYSUS_CITY_APPLIES_MODIFIER_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE', 'ModifierId', 'OP_DIONYSUS_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DIONYSUS_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_PLANTATION_TAG_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DIONYSUS_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_DIONYSUS_FAITH_PLANTATION_TAG_ADJACENCY_REVERSE', 'Amount', 5) ;

--    Many AMENITIES on PLANTATION_TAG
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES ('OP_DIONYSUS', 'OP_DIONYSUS_CITY_ADDS_AMEN_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('OP_DIONYSUS_CITY_ADDS_AMEN_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('OP_DIONYSUS_CITY_ADDS_AMEN_MODIFIER', 'ModifierId', 'OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG', 'DB_DM_PLOT_ADJUST_RELIGION_AMENITY', 'PLOT_HAS_PLANTATION_TAG_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG', 'Amount', 5) ;


/*
--   Plan B: Player with Dionysus pantheon gets +1 amenity from each luxury resource they own
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES ('OP_DIONYSUS', 'OP_DIONYSUS_PLAYER_ADDS_AMEN_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('OP_DIONYSUS_PLAYER_ADDS_AMEN_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('OP_DIONYSUS_PLAYER_ADDS_AMEN_MODIFIER', 'ModifierId', 'OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES ('OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG', 'DB_DM_ADJUST_OWNED_LUXURY_AMENITY') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('OP_DIONYSUS_AMENITY_ON_PLANTATION_TAG', 'Amount', 1) ;

--    1 FOOD on PLANTATION_TAG
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_DIONYSUS', 'OP_DIONYSUS_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DIONYSUS_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_DIONYSUS_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_DIONYSUS_FOOD_INCREASES_ON_PLANTATION_TAG') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_DIONYSUS_FOOD_INCREASES_ON_PLANTATION_TAG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_PLANTATION_TAG_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_DIONYSUS_FOOD_INCREASES_ON_PLANTATION_TAG', 'YieldType', 'YIELD_FOOD'),
							  ('OP_DIONYSUS_FOOD_INCREASES_ON_PLANTATION_TAG', 'Amount', 1) ;
*/




-- ------------------------------------
--  Gaia
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_GAIA', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_GAIA', 'LOC_OP_GAIA', 'LOC_OP_GAIA_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 FOOD on JUNGLE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_GAIA', 'OP_GAIA_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_GAIA_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_GAIA_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_GAIA_FOOD_INCREASES_ON_JUNGLE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_GAIA_FOOD_INCREASES_ON_JUNGLE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_JUNGLE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_GAIA_FOOD_INCREASES_ON_JUNGLE', 'YieldType', 'YIELD_FOOD'),
							  ('OP_GAIA_FOOD_INCREASES_ON_JUNGLE', 'Amount', 1) ;
--    Holy Site Adjacency
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_GAIA', 'OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_JUNGLE_FAITH'),
							 ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'FeatureType', 'FEATURE_JUNGLE'),
							 ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_GAIA_JUNGLE_HOLY_SITE_ADJACENCY', 'Amount', 2) ;


-- ------------------------------------
--  Hades
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HADES', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HADES', 'LOC_OP_HADES', 'LOC_OP_HADES_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 PRODUCTION on BONUS_OR_LUXURY_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HADES', 'OP_HADES_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HADES_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HADES_PRODUCTION_INCREASES_ON_BONUS_OR_LUXURY_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_PRODUCTION_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_BONUS_OR_LUXURY_MINE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HADES_PRODUCTION_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_HADES_PRODUCTION_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'Amount', 1) ;
--    5 GOLD on BONUS_OR_LUXURY_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HADES', 'OP_HADES_GOLD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_GOLD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HADES_GOLD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HADES_GOLD_INCREASES_ON_BONUS_OR_LUXURY_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_GOLD_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_BONUS_OR_LUXURY_MINE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HADES_GOLD_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'YieldType', 'YIELD_GOLD'),
							  ('OP_HADES_GOLD_INCREASES_ON_BONUS_OR_LUXURY_MINE', 'Amount', 5) ;
--    Reverse Holy Site Adjacency  //  FAITH on BONUS_OR_LUXURY_MINE adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HADES', 'OP_HADES_CITY_APPLIES_MODIFIER_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_CITY_APPLIES_MODIFIER_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HADES_CITY_APPLIES_MODIFIER_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE', 'ModifierId', 'OP_HADES_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HADES_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HADES_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HADES_FAITH_BONUS_OR_LUXURY_MINE_ADJACENCY_REVERSE', 'Amount', 5) ;


-- ------------------------------------
--   HELIOS
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HELIOS', 'KIND_BELIEF') ;
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HELIOS', 'LOC_OP_HELIOS', 'LOC_OP_HELIOS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 FOOD on DESERT
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HELIOS_FOOD_INCREASES_ON_DESERT') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_FOOD_INCREASES_ON_DESERT', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_NORMAL_DESERT') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HELIOS_FOOD_INCREASES_ON_DESERT', 'YieldType', 'YIELD_FOOD'),
							  ('OP_HELIOS_FOOD_INCREASES_ON_DESERT', 'Amount', 1) ;
--    1 PRODUCTION on DESERT
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HELIOS_PRODUCTION_INCREASES_ON_DESERT') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_PRODUCTION_INCREASES_ON_DESERT', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_NORMAL_DESERT') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HELIOS_PRODUCTION_INCREASES_ON_DESERT', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_HELIOS_PRODUCTION_INCREASES_ON_DESERT', 'Amount', 1) ;
--    1 FAITH on DESERT
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_FAITH_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_FAITH_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_FAITH_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HELIOS_FAITH_INCREASES_ON_DESERT') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_FAITH_INCREASES_ON_DESERT', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_NORMAL_DESERT') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HELIOS_FAITH_INCREASES_ON_DESERT', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HELIOS_FAITH_INCREASES_ON_DESERT', 'Amount', 1) ;
--    1 GOLD on DESERT
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_GOLD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_GOLD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_GOLD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HELIOS_GOLD_INCREASES_ON_DESERT') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_GOLD_INCREASES_ON_DESERT', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_NORMAL_DESERT') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HELIOS_GOLD_INCREASES_ON_DESERT', 'YieldType', 'YIELD_GOLD'),
							  ('OP_HELIOS_GOLD_INCREASES_ON_DESERT', 'Amount', 1) ;



--    Holy Site Adjacency
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_DESERT_FAITH'),
							 ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_DESERT'),
							 ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_HELIOS_DESERT_HOLY_SITE_ADJACENCY', 'Amount', 1) ;

INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_DESERT_FAITH'),
							 ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_DESERT_HILLS'),
							 ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_HELIOS_DESERT_HILLS_HOLY_SITE_ADJACENCY', 'Amount', 1) ;

-- 5 FAITH on COLOSSUS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HELIOS', 'OP_HELIOS_CITY_APPLIES_MODIFIER_FAITH_ON_COLOSSUS') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HELIOS_CITY_APPLIES_MODIFIER_FAITH_ON_COLOSSUS', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_CITY_APPLIES_MODIFIER_FAITH_ON_COLOSSUS', 'ModifierId', 'OP_HELIOS_FAITH_INCREASES_ON_COLOSSUS') ;
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_HELIOS_FAITH_INCREASES_ON_COLOSSUS', 'MODIFIER_BUILDING_YIELD_CHANGE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HELIOS_FAITH_INCREASES_ON_COLOSSUS', 'BuildingType', 'BUILDING_COLOSSUS'),
                              ('OP_HELIOS_FAITH_INCREASES_ON_COLOSSUS', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HELIOS_FAITH_INCREASES_ON_COLOSSUS', 'Amount', 5) ;



-- ------------------------------------
--  Hephaestus
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HEPHAESTUS', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HEPHAESTUS', 'LOC_OP_HEPHAESTUS', 'LOC_OP_HEPHAESTUS_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 PRODUCTION on STRATEGIC_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_PRODUCTION_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_PRODUCTION_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_PRODUCTION_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HEPHAESTUS_PRODUCTION_INCREASES_ON_STRATEGIC_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_PRODUCTION_INCREASES_ON_STRATEGIC_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HEPHAESTUS_PRODUCTION_INCREASES_ON_STRATEGIC_MINE', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_HEPHAESTUS_PRODUCTION_INCREASES_ON_STRATEGIC_MINE', 'Amount', 1) ;
--    1 SCIENCE on STRATEGIC_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_SCIENCE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_SCIENCE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_SCIENCE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HEPHAESTUS_SCIENCE_INCREASES_ON_STRATEGIC_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_SCIENCE_INCREASES_ON_STRATEGIC_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HEPHAESTUS_SCIENCE_INCREASES_ON_STRATEGIC_MINE', 'YieldType', 'YIELD_SCIENCE'),
							  ('OP_HEPHAESTUS_SCIENCE_INCREASES_ON_STRATEGIC_MINE', 'Amount', 1) ;
--    1 CULTURE on STRATEGIC_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_CULTURE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_CULTURE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_CULTURE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HEPHAESTUS_CULTURE_INCREASES_ON_STRATEGIC_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_CULTURE_INCREASES_ON_STRATEGIC_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HEPHAESTUS_CULTURE_INCREASES_ON_STRATEGIC_MINE', 'YieldType', 'YIELD_CULTURE'),
							  ('OP_HEPHAESTUS_CULTURE_INCREASES_ON_STRATEGIC_MINE', 'Amount', 1) ;
--    1 FAITH on STRATEGIC_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_FAITH_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_FAITH_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_FAITH_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HEPHAESTUS_FAITH_INCREASES_ON_STRATEGIC_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_FAITH_INCREASES_ON_STRATEGIC_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HEPHAESTUS_FAITH_INCREASES_ON_STRATEGIC_MINE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HEPHAESTUS_FAITH_INCREASES_ON_STRATEGIC_MINE', 'Amount', 1) ;
--    1 GOLD on STRATEGIC_MINE
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_GOLD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_GOLD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_GOLD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HEPHAESTUS_GOLD_INCREASES_ON_STRATEGIC_MINE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_GOLD_INCREASES_ON_STRATEGIC_MINE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HEPHAESTUS_GOLD_INCREASES_ON_STRATEGIC_MINE', 'YieldType', 'YIELD_GOLD'),
							  ('OP_HEPHAESTUS_GOLD_INCREASES_ON_STRATEGIC_MINE', 'Amount', 1) ;
--    Reverse Holy Site Adjacency  //  FAITH on STRATEGIC_MINE adjacent to Holy Site
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HEPHAESTUS', 'OP_HEPHAESTUS_CITY_APPLIES_MODIFIER_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_CITY_APPLIES_MODIFIER_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_CITY_APPLIES_MODIFIER_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE', 'ModifierId', 'OP_HEPHAESTUS_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HEPHAESTUS_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_STRATEGIC_MINE_NEXT_TO_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HEPHAESTUS_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HEPHAESTUS_FAITH_STRATEGIC_MINE_ADJACENCY_REVERSE', 'Amount', 4) ;


-- ------------------------------------
--  Hera
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HERA', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HERA', 'LOC_OP_HERA', 'LOC_OP_HERA_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_HERA', 'OP_HERA_ALWAYS_LOYAL') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERA_ALWAYS_LOYAL', 'DB_DM_CITIES_ALWAYS_LOYAL', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HERA_ALWAYS_LOYAL', 'AlwaysLoyal', 1) ;

INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_HERA', 'OP_HERA_CITY_GOVERNOR1'),
                            ('OP_HERA', 'OP_HERA_CITY_GOVERNOR2'),
                            ('OP_HERA', 'OP_HERA_CITY_GOVERNOR3'),
                            ('OP_HERA', 'OP_HERA_CITY_GOVERNOR4'),
                            ('OP_HERA', 'OP_HERA_CITY_GOVERNOR5'),
							('OP_HERA', 'OP_HERA_CITY_GOVERNOR6') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERA_CITY_GOVERNOR1', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_1_GOV_TITLE_ESTABLISHED'),
                      ('OP_HERA_CITY_GOVERNOR2', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_2_GOV_TITLE_ESTABLISHED'),
                      ('OP_HERA_CITY_GOVERNOR3', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_3_GOV_TITLE_ESTABLISHED'),
                      ('OP_HERA_CITY_GOVERNOR4', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_4_GOV_TITLE_ESTABLISHED'),
                      ('OP_HERA_CITY_GOVERNOR5', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_5_GOV_TITLE_ESTABLISHED'),
                      ('OP_HERA_CITY_GOVERNOR6', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'DB_REQSET_CITY_HAS_PANTHEON_AND_6_GOV_TITLE_ESTABLISHED') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_HERA_CITY_GOVERNOR1', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR1'),
							  ('OP_HERA_CITY_GOVERNOR2', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR2'),
							  ('OP_HERA_CITY_GOVERNOR3', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR3'),
							  ('OP_HERA_CITY_GOVERNOR4', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR4'),
							  ('OP_HERA_CITY_GOVERNOR5', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR5'),
							  ('OP_HERA_CITY_GOVERNOR6', 'ModifierId', 'OP_HERA_HOLY_SITE_GOVERNOR6') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERA_HOLY_SITE_GOVERNOR1', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE'),
                      ('OP_HERA_HOLY_SITE_GOVERNOR2', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE'),
                      ('OP_HERA_HOLY_SITE_GOVERNOR3', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE'),
                      ('OP_HERA_HOLY_SITE_GOVERNOR4', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE'),
                      ('OP_HERA_HOLY_SITE_GOVERNOR5', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE'),
                      ('OP_HERA_HOLY_SITE_GOVERNOR6', 'DB_DM_ADJUST_DISTRICT_YIELD', 'DISTRICT_IS_HOLY_SITE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_HERA_HOLY_SITE_GOVERNOR1', 'Amount', 1),
							  ('OP_HERA_HOLY_SITE_GOVERNOR1', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERA_HOLY_SITE_GOVERNOR2', 'Amount', 2),
							  ('OP_HERA_HOLY_SITE_GOVERNOR2', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERA_HOLY_SITE_GOVERNOR3', 'Amount', 3),
							  ('OP_HERA_HOLY_SITE_GOVERNOR3', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERA_HOLY_SITE_GOVERNOR4', 'Amount', 4),
							  ('OP_HERA_HOLY_SITE_GOVERNOR4', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERA_HOLY_SITE_GOVERNOR5', 'Amount', 5),
							  ('OP_HERA_HOLY_SITE_GOVERNOR5', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERA_HOLY_SITE_GOVERNOR6', 'Amount', 6),
							  ('OP_HERA_HOLY_SITE_GOVERNOR6', 'YieldType', 'YIELD_FAITH') ;

-- ------------------------------------
--  Hermes
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HERMES', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HERMES', 'LOC_OP_HERMES', 'LOC_OP_HERMES_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
                            ('OP_HERMES', 'OP_HERMES_ROADS_TO_CAPITAL'),
							('OP_HERMES', 'OP_HERMES_IMPROVED_ROAD_LEVEL'),
							('OP_HERMES', 'OP_HERMES_HARVEST_FAITH'),
							('OP_HERMES', 'OP_HERMES_REMOVE_FEATURE_FAITH') ;

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERMES_ROADS_TO_CAPITAL', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS'),
					  ('OP_HERMES_IMPROVED_ROAD_LEVEL', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS'),
                      ('OP_HERMES_HARVEST_FAITH', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS'),
                      ('OP_HERMES_REMOVE_FEATURE_FAITH', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_HERMES_ROADS_TO_CAPITAL', 'ModifierId', 'OP_HERMES_ROADS_TO_CAPITAL_MODIFIER'),
							  ('OP_HERMES_IMPROVED_ROAD_LEVEL', 'ModifierId', 'OP_HERMES_IMPROVED_ROAD_LEVEL_MODIFIER'),
							  ('OP_HERMES_HARVEST_FAITH', 'ModifierId', 'OP_HERMES_HARVEST_FAITH_MODIFIER'),
							  ('OP_HERMES_REMOVE_FEATURE_FAITH', 'ModifierId', 'OP_HERMES_REMOVE_FEATURE_MODIFIER') ;

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES 
                      ('OP_HERMES_ROADS_TO_CAPITAL_MODIFIER', 'MODIFIER_PLAYER_CITIES_GRANT_ROAD_TO_CAPITAL'),
					  ('OP_HERMES_IMPROVED_ROAD_LEVEL_MODIFIER', 'MODIFIER_PLAYER_ADJUST_IMPROVED_ROUTE_LEVEL'),
                      ('OP_HERMES_HARVEST_FAITH_MODIFIER', 'MODIFIER_PLAYER_GRANT_FAITH_FROM_HARVEST'),
                      ('OP_HERMES_REMOVE_FEATURE_MODIFIER', 'MODIFIER_PLAYER_GRANT_FAITH_FROM_REMOVE_FEATURE') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
							  ('OP_HERMES_IMPROVED_ROAD_LEVEL_MODIFIER', 'ImprovedRouteLevel', 1),
							  ('OP_HERMES_HARVEST_FAITH_MODIFIER', 'Amount', 100),
							  ('OP_HERMES_REMOVE_FEATURE_MODIFIER', 'Amount', 100) ;

/*
--    1 FAITH on MERCURY
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HERMES', 'OP_HERMES_FAITH_ON_MERCURY_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERMES_FAITH_ON_MERCURY_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HERMES_FAITH_ON_MERCURY_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HERMES_FAITH_INCREASES_ON_MERCURY') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HERMES_FAITH_INCREASES_ON_MERCURY', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_MERCURY') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HERMES_FAITH_INCREASES_ON_MERCURY', 'YieldType', 'YIELD_FAITH'),
							  ('OP_HERMES_FAITH_INCREASES_ON_MERCURY', 'Amount', 1) ;
*/



-- ------------------------------------
--  Hestia
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_HESTIA', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_HESTIA', 'LOC_OP_HESTIA', 'LOC_OP_HESTIA_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    1 GOLD on FOREST
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HESTIA', 'OP_HESTIA_GOLD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HESTIA_GOLD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_HESTIA_GOLD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_HESTIA_GOLD_INCREASES_ON_FOREST') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_HESTIA_GOLD_INCREASES_ON_FOREST', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_FOREST') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_HESTIA_GOLD_INCREASES_ON_FOREST', 'YieldType', 'YIELD_GOLD'),
							  ('OP_HESTIA_GOLD_INCREASES_ON_FOREST', 'Amount', 1) ;
--    Holy Site Adjacency
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_HESTIA', 'OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_FOREST_FAITH'),
							 ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'FeatureType', 'FEATURE_FOREST'),
							 ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_HESTIA_FOREST_HOLY_SITE_ADJACENCY', 'Amount', 1) ;
							 


-- ------------------------------------
-- PAN
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_PAN', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_PAN', 'LOC_OP_PAN', 'LOC_OP_PAN_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    2 FOOD on REEDS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PAN', 'OP_PAN_FOOD_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PAN_FOOD_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_PAN_FOOD_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_PAN_FOOD_INCREASES_ON_REEDS') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PAN_FOOD_INCREASES_ON_REEDS', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_REEDS_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_PAN_FOOD_INCREASES_ON_REEDS', 'YieldType', 'YIELD_FOOD'),
							  ('OP_PAN_FOOD_INCREASES_ON_REEDS', 'Amount', 2) ;
--    2 CULTURE on REEDS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PAN', 'OP_PAN_CULTURE_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PAN_CULTURE_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_PAN_CULTURE_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_PAN_CULTURE_INCREASES_ON_REEDS') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PAN_CULTURE_INCREASES_ON_REEDS', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_REEDS_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_PAN_CULTURE_INCREASES_ON_REEDS', 'YieldType', 'YIELD_CULTURE'),
							  ('OP_PAN_CULTURE_INCREASES_ON_REEDS', 'Amount', 2) ;
--    Holy Site Adjacency  //  FAITH for adjacent MARSH
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PAN', 'OP_PAN_MARSH_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_REEDS_FAITH'),
							 ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'FeatureType', 'FEATURE_MARSH'),
							 ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PAN_MARSH_HOLY_SITE_ADJACENCY', 'Amount', 3) ;
--    Holy Site Adjacency  //  FAITH for adjacent OASIS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PAN', 'OP_PAN_OASIS_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_REEDS_FAITH'),
							 ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'FeatureType', 'FEATURE_OASIS'),
							 ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PAN_OASIS_HOLY_SITE_ADJACENCY', 'Amount', 3) ;
--    Holy Site Adjacency  //  FAITH for adjacent FLOODPLAINS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PAN', 'OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_REEDS_FAITH'),
							 ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'FeatureType', 'FEATURE_FLOODPLAINS'),
							 ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PAN_FLOODPLAINS_HOLY_SITE_ADJACENCY', 'Amount', 3) ;


-- ------------------------------------
--   PERSEPHONE
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_PERSEPHONE', 'KIND_BELIEF') ; 
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_PERSEPHONE', 'LOC_OP_PERSEPHONE', 'LOC_OP_PERSEPHONE_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    FOOD
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('OP_PERSEPHONE_YIELD_FOOD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_ANY_ARCTIC') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_PERSEPHONE_YIELD_FOOD', 'YieldType', 'YIELD_FOOD'),
							  ('OP_PERSEPHONE_YIELD_FOOD', 'Amount', 1) ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_FOOD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_FOOD', 'ModifierId', 'OP_PERSEPHONE_YIELD_FOOD') ;
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES ('OP_PERSEPHONE', 'OP_PERSEPHONE_CITY_ADDS_MODIFIER_FOOD') ;

--    PRODUCTION
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_CITY_ADDS_MODIFIER_PRODUCTION') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_PRODUCTION', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_PRODUCTION', 'ModifierId', 'OP_PERSEPHONE_YIELD_PRODUCTION') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PERSEPHONE_YIELD_PRODUCTION', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_ANY_ARCTIC') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_PERSEPHONE_YIELD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_PERSEPHONE_YIELD_PRODUCTION', 'Amount', 1) ;

--    FAITH
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_CITY_ADDS_MODIFIER_FAITH') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_FAITH', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_PERSEPHONE_CITY_ADDS_MODIFIER_FAITH', 'ModifierId', 'OP_PERSEPHONE_YIELD_FAITH') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_PERSEPHONE_YIELD_FAITH', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_ANY_ARCTIC') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_PERSEPHONE_YIELD_FAITH', 'YieldType', 'YIELD_FAITH'),
							  ('OP_PERSEPHONE_YIELD_FAITH', 'Amount', 1) ;


--  Standard Faith adjacency of 1 for Tundra, TundraHills, Snow, or SnowHills
--    Standard Holy Site Adjacency  //  1 FAITH for adjacent SNOW
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_SNOW_OR_TUNDRA_FAITH'),
							 ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_SNOW'),
							 ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PERSEPHONE_SNOW_HOLY_SITE_ADJACENCY', 'Amount', 1) ;
--    Standard Holy Site Adjacency  //  1 FAITH for adjacent SNOW_HILLS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_SNOW_OR_TUNDRA_FAITH'),
							 ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_SNOW_HILLS'),
							 ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PERSEPHONE_SNOW_HILLS_HOLY_SITE_ADJACENCY', 'Amount', 1) ;
--    Standard Holy Site Adjacency  //  FAITH for adjacent TUNDRA
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_SNOW_OR_TUNDRA_FAITH'),
							 ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_TUNDRA'),
							 ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PERSEPHONE_TUNDRA_HOLY_SITE_ADJACENCY', 'Amount', 1) ;
--    Standard Holy Site Adjacency  //  FAITH for adjacent TUNDRA_HILLS
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_PERSEPHONE', 'OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_SNOW_OR_TUNDRA_FAITH'),
							 ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_TUNDRA_HILLS'),
							 ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_PERSEPHONE_TUNDRA_HILLS_HOLY_SITE_ADJACENCY', 'Amount', 1) ;

-- ------------------------------------
--  Poseidon
-- ------------------------------------
INSERT INTO Types (Type, Kind) VALUES ('OP_POSEIDON', 'KIND_BELIEF') ;  
INSERT INTO Beliefs (BeliefType, Name, Description, BeliefClassType) VALUES ('OP_POSEIDON', 'LOC_OP_POSEIDON', 'LOC_OP_POSEIDON_DESCRIPTION', 'BELIEF_CLASS_PANTHEON') ;
--    3 PRODUCTION on OCEAN
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_POSEIDON', 'OP_POSEIDON_PRODUCTION_ON_OCEAN_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_PRODUCTION_ON_OCEAN_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_POSEIDON_PRODUCTION_ON_OCEAN_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_POSEIDON_PRODUCTION_INCREASES_ON_OCEAN') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_PRODUCTION_INCREASES_ON_OCEAN', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_OCEAN') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_POSEIDON_PRODUCTION_INCREASES_ON_OCEAN', 'YieldType', 'YIELD_PRODUCTION'),
							  ('OP_POSEIDON_PRODUCTION_INCREASES_ON_OCEAN', 'Amount', 3) ;
--    1 FAITH on OCEAN
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_POSEIDON', 'OP_POSEIDON_FAITH_ON_OCEAN_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_FAITH_ON_OCEAN_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_POSEIDON_FAITH_ON_OCEAN_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_POSEIDON_FAITH_INCREASES_ON_OCEAN') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_FAITH_INCREASES_ON_OCEAN', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_IS_OCEAN') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_POSEIDON_FAITH_INCREASES_ON_OCEAN', 'YieldType', 'YIELD_FAITH'),
							  ('OP_POSEIDON_FAITH_INCREASES_ON_OCEAN', 'Amount', 1) ;
							  
--    1 FAITH on HORSES
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_POSEIDON', 'OP_POSEIDON_FAITH_ON_HORSES_CITY_APPLIES_MODIFIER') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_FAITH_ON_HORSES_CITY_APPLIES_MODIFIER', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
                              ('OP_POSEIDON_FAITH_ON_HORSES_CITY_APPLIES_MODIFIER', 'ModifierId', 'OP_POSEIDON_FAITH_INCREASES_ON_HORSES') ;
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                      ('OP_POSEIDON_FAITH_INCREASES_ON_HORSES', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'DB_REQSET_HAS_HORSES') ;
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
							  ('OP_POSEIDON_FAITH_INCREASES_ON_HORSES', 'YieldType', 'YIELD_FAITH'),
							  ('OP_POSEIDON_FAITH_INCREASES_ON_HORSES', 'Amount', 1) ;

--    Standard Holy Site Adjacency  //  FAITH for adjacent COAST
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_POSEIDON', 'OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_WATER_FAITH'),
							 ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_COAST'),
							 ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_POSEIDON_COAST_HOLY_SITE_ADJACENCY', 'Amount', 2) ;
--    Standard Holy Site Adjacency  //  FAITH for adjacent OCEAN
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES 
                            ('OP_POSEIDON', 'OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY') ;
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES 
                     ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'MODIFIER_ALL_CITIES_TERRAIN_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS') ;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
							 ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
							 ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'Description', 'LOC_OP_DISTRICT_WATER_FAITH'),
							 ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'TerrainType', 'TERRAIN_OCEAN'),
							 ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
                             ('OP_POSEIDON_OCEAN_HOLY_SITE_ADJACENCY', 'Amount', 2) ;
