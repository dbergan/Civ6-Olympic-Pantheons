-----------------------------------------------
-----------------------------------------------
-- Tags
-----------------------------------------------
-----------------------------------------------


-- Typetags for all, land combat, and naval combat units
INSERT OR IGNORE INTO Tags 
(Tag,							Vocabulary) 
VALUES 
('DB_CLASS_ALL',					'ABILITY_CLASS'),
('DB_CLASS_ALL_COMBAT',				'ABILITY_CLASS'),
('DB_CLASS_LAND_ALL',				'ABILITY_CLASS'),
('DB_CLASS_LAND_COMBAT',			'ABILITY_CLASS'),
('DB_CLASS_LAND_CAVALRY',			'ABILITY_CLASS'),
('DB_CLASS_LAND_NON_CAVALRY',		'ABILITY_CLASS'),
('DB_CLASS_NAVAL_COMBAT',			'ABILITY_CLASS'),
('DB_CLASS_AIR_COMBAT',				'ABILITY_CLASS'),
('DB_CLASS_LAND_MELEE_ATTACKER',	'ABILITY_CLASS'),
('DB_CLASS_LAND_RANGED_ATTACKER',	'ABILITY_CLASS'),
('DB_CLASS_LAND_BOMBARD_ATTACKER',	'ABILITY_CLASS'),
('DB_CLASS_NAVAL_MELEE_ATTACKER',	'ABILITY_CLASS'),
('DB_CLASS_NAVAL_RANGED_ATTACKER',	'ABILITY_CLASS'),
('DB_CLASS_NAVAL_BOMBARD_ATTACKER', 'ABILITY_CLASS')
;
INSERT OR IGNORE INTO Tags (Tag, Vocabulary) 
  SELECT 'DB_CLASS_' || UnitType, 'ABILITY_CLASS' FROM Units ;

INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_ALL' FROM Units ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_ALL_COMBAT' FROM Units WHERE (Combat > 0 OR RangedCombat > 0 OR Bombard > 0) AND (FormationClass = 'FORMATION_CLASS_LAND_COMBAT' OR FormationClass = 'FORMATION_CLASS_NAVAL' OR FormationClass = 'FORMATION_CLASS_AIR') ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_ALL' FROM Units WHERE Domain = 'DOMAIN_LAND' ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_COMBAT' FROM Units WHERE (Combat > 0 OR RangedCombat > 0 OR Bombard > 0) AND FormationClass = 'FORMATION_CLASS_LAND_COMBAT' ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_NAVAL_COMBAT' FROM Units WHERE (Combat > 0 OR RangedCombat > 0 OR Bombard > 0) AND FormationClass = 'FORMATION_CLASS_NAVAL' ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_AIR_COMBAT' FROM Units WHERE (Combat > 0 OR RangedCombat > 0 OR Bombard > 0) AND FormationClass = 'FORMATION_CLASS_AIR' ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_MELEE_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_LAND_COMBAT' AND Combat > 0 AND RangedCombat = 0 AND Bombard = 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_RANGED_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_LAND_COMBAT' AND RangedCombat > 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_BOMBARD_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_LAND_COMBAT' AND Bombard > 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_CAVALRY' FROM Units WHERE FormationClass = 'FORMATION_CLASS_LAND_COMBAT' AND PromotionClass LIKE '%CAVALRY%' AND PromotionClass NOT LIKE '%ANTI_CAVALRY%' ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_LAND_NON_CAVALRY' FROM Units WHERE FormationClass = 'FORMATION_CLASS_LAND_COMBAT' AND (PromotionClass LIKE '%ANTI_CAVALRY%' OR PromotionClass NOT LIKE '%CAVALRY%') ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_NAVAL_MELEE_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_NAVAL' AND Combat > 0 AND RangedCombat = 0 AND Bombard = 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_NAVAL_RANGED_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_NAVAL' AND RangedCombat > 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_NAVAL_BOMBARD_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_NAVAL' AND Bombard > 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_NAVAL_BOMBARD_ATTACKER' FROM Units WHERE FormationClass = 'FORMATION_CLASS_NAVAL' AND Bombard > 0 ;
INSERT OR IGNORE INTO TypeTags (Type, Tag)
  SELECT UnitType, 'DB_CLASS_' || UnitType FROM Units ;



-----------------------------------------------
-----------------------------------------------
-- Requirements
-----------------------------------------------
-----------------------------------------------

-- Major Civ
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_PLAYER_IS_MAJOR', 'REQUIREMENT_PLAYER_IS_MAJOR') ;

-- Game eras
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_ANCIENT', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_ANCIENT', 'EraType', 'ERA_ANCIENT') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_ANCIENT', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_ANCIENT', 'DB_REQ_ERA_IS_ANCIENT') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_CLASSICAL', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_CLASSICAL', 'EraType', 'ERA_CLASSICAL') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_CLASSICAL', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_CLASSICAL', 'DB_REQ_ERA_IS_CLASSICAL') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_MEDIEVAL', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_MEDIEVAL', 'EraType', 'ERA_MEDIEVAL') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_MEDIEVAL', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_MEDIEVAL', 'DB_REQ_ERA_IS_MEDIEVAL') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_RENAISSANCE', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_RENAISSANCE', 'EraType', 'ERA_RENAISSANCE') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_RENAISSANCE', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_RENAISSANCE', 'DB_REQ_ERA_IS_RENAISSANCE') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_INDUSTRIAL', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_INDUSTRIAL', 'EraType', 'ERA_INDUSTRIAL') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_INDUSTRIAL', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_INDUSTRIAL', 'DB_REQ_ERA_IS_INDUSTRIAL') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_MODERN', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_MODERN', 'EraType', 'ERA_MODERN') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_MODERN', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_MODERN', 'DB_REQ_ERA_IS_MODERN') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_ATOMIC', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_ATOMIC', 'EraType', 'ERA_ATOMIC') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_ATOMIC', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_ATOMIC', 'DB_REQ_ERA_IS_ATOMIC') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_INFORMATION', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_INFORMATION', 'EraType', 'ERA_INFORMATION') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_INFORMATION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_INFORMATION', 'DB_REQ_ERA_IS_INFORMATION') ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_ERA_IS_FUTURE', 'REQUIREMENT_GAME_ERA_IS') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_ERA_IS_FUTURE', 'EraType', 'ERA_FUTURE') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_ERA_IS_FUTURE', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_ERA_IS_FUTURE', 'DB_REQ_ERA_IS_FUTURE') ;

-- Civ not founded religion
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_PLAYER_NOT_FOUNDED_RELIGION', 'REQUIREMENT_PLAYER_FOUNDED_NO_RELIGION') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_PLAYER_NOT_FOUNDED_RELIGION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_PLAYER_NOT_FOUNDED_RELIGION', 'DB_REQ_PLAYER_NOT_FOUNDED_RELIGION') ;

-- Civ founded religion
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse) VALUES ('DB_REQ_PLAYER_FOUNDED_RELIGION', 'REQUIREMENT_PLAYER_FOUNDED_NO_RELIGION', 1) ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_PLAYER_FOUNDED_RELIGION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_PLAYER_FOUNDED_RELIGION', 'DB_REQ_PLAYER_FOUNDED_RELIGION') ;

--  AI has founded religion
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_PLAYER_IS_AI_AND_HAS_FOUNDED_RELIGION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
                                                  ('DB_REQSET_PLAYER_IS_AI_AND_HAS_FOUNDED_RELIGION', 'REQUIRES_PLAYER_IS_AI'),
									              ('DB_REQSET_PLAYER_IS_AI_AND_HAS_FOUNDED_RELIGION', 'DB_REQ_PLAYER_FOUNDED_RELIGION') ;

-- Major Civilization having a capital city and has not founded a religion (getting a free starting prophet when they settle their capital)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_FREE_PROPHET', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
                                                 ('DB_REQSET_FREE_PROPHET', 'DB_REQ_ERA_IS_ANCIENT'), 
                                                 ('DB_REQSET_FREE_PROPHET', 'DB_REQ_PLAYER_IS_MAJOR'), 
												 ('DB_REQSET_FREE_PROPHET', 'DB_REQ_PLAYER_NOT_FOUNDED_RELIGION'),
									             ('DB_REQSET_FREE_PROPHET', 'REQUIRES_CAPITAL_CITY') ;

-- Classical era with Capital City (Saladin's free prophet)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_CAPITAL_CITY_IN_CLASSICAL_ERA', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
                                                  ('DB_REQSET_CAPITAL_CITY_IN_CLASSICAL_ERA', 'DB_REQ_ERA_IS_CLASSICAL'), 
									              ('DB_REQSET_CAPITAL_CITY_IN_CLASSICAL_ERA', 'REQUIRES_CAPITAL_CITY') ;

-- City follows pantheon (DB_REQ_CITY_FOLLOWS_PANTHEON, DB_REQSET_CITY_FOLLOWS_PANTHEON)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_CITY_FOLLOWS_PANTHEON', 'REQUIREMENT_CITY_FOLLOWS_PANTHEON') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_CITY_FOLLOWS_PANTHEON', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_CITY_FOLLOWS_PANTHEON', 'DB_REQ_CITY_FOLLOWS_PANTHEON') ;

-- City follows religion (DB_REQ_CITY_FOLLOWS_RELIGION, DB_REQSET_CITY_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_CITY_FOLLOWS_RELIGION', 'REQUIREMENT_CITY_FOLLOWS_RELIGION') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_CITY_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_CITY_FOLLOWS_RELIGION', 'DB_REQ_CITY_FOLLOWS_RELIGION') ;

-- City has X population (DB_REQ_CITY_HAS_2_POPULATION, DB_REQSET_CITY_HAS_2_POPULATION)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_POPULATION', 'REQUIREMENT_CITY_HAS_X_POPULATION' FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_POPULATION', 'Amount', x FROM counter ;

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_POPULATION', 'REQUIREMENTSET_TEST_ALL' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_POPULATION', 'DB_REQ_CITY_HAS_' || x || '_POPULATION' FROM counter ;

-- City has X population and follows religion (DB_REQ_CITY_HAS_2_POPULATION_AND_FOLLOWS_RELIGION, DB_REQSET_CITY_HAS_2_POPULATION_AND_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_HAS_' || x || '_POPULATION' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_FOLLOWS_RELIGION' FROM counter ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION', 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 99) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION', 'RequirementSetId', 'DB_REQSET_CITY_HAS_' || x || '_POPULATION_AND_FOLLOWS_RELIGION' FROM counter ;


-- City has X specialty districts (DB_REQ_CITY_HAS_2_DISTRICTS, DB_REQSET_CITY_HAS_2_DISTRICTS)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS', 'REQUIREMENT_CITY_HAS_X_SPECIALTY_DISTRICTS' FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS', 'Amount', x FROM counter ;

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS', 'REQUIREMENTSET_TEST_ALL' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS', 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS' FROM counter ;

-- City has X specialty districts and follows religion (DB_REQ_CITY_HAS_2_DISTRICTS_AND_FOLLOWS_RELIGION, DB_REQSET_CITY_HAS_2_DISTRICTS_AND_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_FOLLOWS_RELIGION' FROM counter ;

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION', 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 18) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION', 'RequirementSetId', 'DB_REQSET_CITY_HAS_' || x || '_DISTRICTS_AND_FOLLOWS_RELIGION' FROM counter ;


-- City has a certain building, including wonders (DB_REQ_CITY_HAS_LIBRARY, DB_REQSET_CITY_HAS_LIBRARY)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10), 'REQUIREMENT_CITY_HAS_BUILDING' FROM Buildings ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10), 'BuildingType', BuildingType FROM Buildings ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Buildings ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10), 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10) FROM Buildings ;


-- City has a certain building AND follows religion (DB_REQ_CITY_HAS_BROADCAST_CENTER_AND_FOLLOWS_RELIGION, DB_REQSET_CITY_HAS_BROADCAST_CENTER_AND_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL' FROM Buildings ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10) FROM Buildings ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_FOLLOWS_RELIGION' FROM Buildings ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION', 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Buildings ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION', 'RequirementSetId', 'DB_REQSET_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION' FROM Buildings ;



-- City has any level-3 building (DB_REQ_CITY_HAS_LEVEL3_HSBUILDING, DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING', 'REQUIREMENTSET_TEST_ANY') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING' , 'DB_REQ_CITY_HAS_' || SUBSTR(BuildingType, 10) || '_AND_FOLLOWS_RELIGION' FROM Buildings WHERE PrereqDistrict = 'DISTRICT_HOLY_SITE' AND BuildingType != 'BUILDING_SHRINE' AND BuildingType != 'BUILDING_TEMPLE' AND BuildingType != 'BUILDING_STAVE_CHURCH' AND BuildingType != 'BUILDING_PRASAT';
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_CITY_HAS_LEVEL3_HSBUILDING', 'REQUIREMENT_REQUIREMENTSET_IS_MET') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_CITY_HAS_LEVEL3_HSBUILDING', 'RequirementSetId', 'DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING') ;


-- City has any level-3 building AND follows religion (DB_REQ_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION, DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_HAS_LEVEL3_HSBUILDING'),
									   ('DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION', 'REQUIRES_CITY_FOLLOWS_RELIGION') ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION', 'REQUIREMENT_REQUIREMENTSET_IS_MET') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION', 'RequirementSetId', 'DB_REQSET_CITY_HAS_LEVEL3_HSBUILDING_AND_FOLLOWS_RELIGION') ;


-- City has a certain district (DB_REQ_CITY_HAS_HOLY_SITE, DB_REQSET_CITY_HAS_HOLY_SITE)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_CITY_HAS_DISTRICT' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10), 'DistrictType', DistrictType FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10), 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;

-- City has a certain district AND follows religion (DB_REQ_CITY_HAS_HOLY_SITE_AND_FOLLOWS_RELIGION, DB_REQSET_CITY_HAS_HOLY_SITE_AND_FOLLOWS_RELIGION)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION', 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION', 'DB_REQ_CITY_FOLLOWS_RELIGION' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION', 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION', 'RequirementSetId', 'DB_REQSET_CITY_HAS_' || SUBSTR(DistrictType, 10) || '_AND_FOLLOWS_RELIGION' FROM Districts WHERE TraitType IS NULL ;






-- District is... (DB_REQ_IS_HOLY_SITE, DB_REQSET_IS_HOLY_SITE)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_IS_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_DISTRICT_TYPE_MATCHES' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_IS_' || SUBSTR(DistrictType, 10), 'DistrictType', DistrictType FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(DistrictType, 10), 'DB_REQ_IS_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;


-- Next to a certain district (DB_REQ_NEXT_TO_HOLY_SITE, DB_REQSET_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DistrictType', DistrictType FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;


-- District is X and next to Y (DB_REQ_IS_CAMPUS_NEXT_TO_HOLY_SITE, DB_REQSET_IS_CAMPUS_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts AS a LEFT JOIN Districts AS b WHERE a.TraitType IS NULL AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_IS_' || SUBSTR(a.DistrictType, 10) FROM Districts AS a LEFT JOIN Districts AS b WHERE a.TraitType IS NULL AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Districts AS a LEFT JOIN Districts AS b WHERE a.TraitType IS NULL AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts AS a LEFT JOIN Districts AS b WHERE a.TraitType IS NULL AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_IS_' || SUBSTR(a.DistrictType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Districts AS a LEFT JOIN Districts AS b WHERE a.TraitType IS NULL AND b.TraitType IS NULL ;

-- Plot is terrain (DB_REQ_IS_PLAINS, DB_REQSET_IS_PLAINS)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_IS_' || SUBSTR(TerrainType, 9), 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES' FROM Terrains ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_IS_' || SUBSTR(TerrainType, 9), 'TerrainType', TerrainType FROM Terrains ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_IS_' || SUBSTR(TerrainType, 9), 'REQUIREMENTSET_TEST_ALL' FROM Terrains ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_IS_' || SUBSTR(TerrainType, 9), 'DB_REQ_IS_' || SUBSTR(TerrainType, 9) FROM Terrains ;

-- Plot is terrain X and is next to district Y (DB_REQ_IS_PLAINS_NEXT_TO_HOLY_SITE, DB_REQSET_IS_PLAINS_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Terrains AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_IS_' || SUBSTR(a.TerrainType, 9) FROM Terrains AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Terrains AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Terrains AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_IS_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Terrains AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;

-- Plot is any terrain of a certain type (DB_REQ_IS_ANY_PLAINS, DB_REQSET_IS_ANY_PLAINS)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_IS_ANY_' || SUBSTR(TerrainType, 9), 'REQUIREMENTSET_TEST_ANY' FROM Terrains WHERE TerrainType NOT LIKE '%HILLS%' AND TerrainType NOT LIKE '%MOUNTAIN%' ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_IS_ANY_' || SUBSTR(a.TerrainType, 9), 'DB_REQ_IS_' || SUBSTR(b.TerrainType, 9) FROM Terrains AS a INNER JOIN Terrains AS b ON SUBSTR(a.TerrainType, 0, 12) = SUBSTR(b.TerrainType, 0, 12) WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_IS_ANY_' || SUBSTR(TerrainType, 9), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Terrains WHERE TerrainType NOT LIKE '%HILLS%' AND TerrainType NOT LIKE '%MOUNTAIN%' ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_IS_ANY_' || SUBSTR(TerrainType, 9), 'RequirementSetId', 'DB_REQSET_IS_ANY_' || SUBSTR(TerrainType, 9) FROM Terrains WHERE TerrainType NOT LIKE '%HILLS%' AND TerrainType NOT LIKE '%MOUNTAIN%' ;

-- Plot is terrain of a certain type X and is next to district Y (DB_REQ_IS_ANY_PLAINS_NEXT_TO_HOLY_SITE, DB_REQSET_IS_ANY_PLAINS_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Terrains AS a LEFT JOIN Districts AS b WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_IS_ANY_' || SUBSTR(a.TerrainType, 9) FROM Terrains AS a LEFT JOIN Districts AS b WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Terrains AS a LEFT JOIN Districts AS b WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Terrains AS a LEFT JOIN Districts AS b WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' AND b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_IS_ANY_' || SUBSTR(a.TerrainType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Terrains AS a LEFT JOIN Districts AS b WHERE a.TerrainType NOT LIKE '%HILLS%' AND a.TerrainType NOT LIKE '%MOUNTAIN%' AND b.TraitType IS NULL ;

-- Plot is any water/arctic (DB_REQ_IS_ANY_WATER, DB_REQSET_IS_ANY_WATER)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
                                       ('DB_REQSET_IS_ANY_WATER', 'REQUIREMENTSET_TEST_ANY'), 
									   ('DB_REQSET_IS_ANY_ARCTIC', 'REQUIREMENTSET_TEST_ANY') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
                                                  ('DB_REQSET_IS_ANY_WATER', 'DB_REQ_IS_ANY_COAST'),
												  ('DB_REQSET_IS_ANY_WATER', 'DB_REQ_IS_ANY_OCEAN'),
												  ('DB_REQSET_IS_ANY_ARCTIC', 'DB_REQ_IS_ANY_SNOW'),
												  ('DB_REQSET_IS_ANY_ARCTIC', 'DB_REQ_IS_ANY_TUNDRA') ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
                                    ('DB_REQ_IS_ANY_WATER', 'REQUIREMENT_REQUIREMENTSET_IS_MET'),
									('DB_REQ_IS_ANY_ARCTIC', 'REQUIREMENT_REQUIREMENTSET_IS_MET') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
                                            ('DB_REQ_IS_ANY_WATER', 'RequirementSetId', 'DB_REQSET_IS_ANY_WATER'),
											('DB_REQ_IS_ANY_ARCTIC', 'RequirementSetId', 'DB_REQSET_IS_ANY_ARCTIC') ;


-- "Normal Desert": no oasis/floodplains (DB_REQ_IS_NORMAL_DESERT, DB_REQSET_IS_NORMAL_DESERT)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
                         ('DB_REQ_IS_NOT_FLOODPLAINS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES', 1),
                         ('DB_REQ_IS_NOT_OASIS', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES', 1),
                         ('DB_REQ_IS_NOT_FLOODPLAINS_OR_OASIS', 'REQUIREMENT_REQUIREMENTSET_IS_MET', 0),
                         ('DB_REQ_IS_NORMAL_DESERT', 'REQUIREMENT_REQUIREMENTSET_IS_MET', 0) ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
                                 ('DB_REQ_IS_NOT_FLOODPLAINS', 'FeatureType', 'FEATURE_FLOODPLAINS'),
                                 ('DB_REQ_IS_NOT_OASIS', 'FeatureType', 'FEATURE_OASIS'),
                                 ('DB_REQ_IS_NOT_FLOODPLAINS_OR_OASIS', 'RequirementSetId', 'DB_REQSET_IS_NOT_FLOODPLAINS_OR_OASIS'),
                                 ('DB_REQ_IS_NORMAL_DESERT', 'RequirementSetId', 'DB_REQSET_IS_NORMAL_DESERT') ;

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
                            ('DB_REQSET_IS_NOT_FLOODPLAINS_OR_OASIS', 'REQUIREMENTSET_TEST_ALL'),
                            ('DB_REQSET_IS_NORMAL_DESERT', 'REQUIREMENTSET_TEST_ALL') ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_IS_NOT_FLOODPLAINS_OR_OASIS', 'DB_REQ_IS_NOT_FLOODPLAINS'),
                                       ('DB_REQSET_IS_NOT_FLOODPLAINS_OR_OASIS', 'DB_REQ_IS_NOT_OASIS'),
                                       ('DB_REQSET_IS_NORMAL_DESERT', 'DB_REQ_IS_ANY_DESERT'),
                                       ('DB_REQSET_IS_NORMAL_DESERT', 'DB_REQ_IS_NOT_FLOODPLAINS_OR_OASIS') ;



-- Plot has feature (DB_REQ_HAS_FOREST, DB_REQSET_HAS_FOREST)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_HAS_' || SUBSTR(FeatureType, 9), 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES' FROM Features ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_HAS_' || SUBSTR(FeatureType, 9), 'FeatureType', FeatureType FROM Features ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(FeatureType, 9), 'REQUIREMENTSET_TEST_ALL' FROM Features ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(FeatureType, 9), 'DB_REQ_HAS_' || SUBSTR(FeatureType, 9) FROM Features ;


-- Plot has feature X and is next to district Y (DB_REQ_HAS_STONE_NEXT_TO_HOLY_SITE, DB_REQSET_HAS_STONE_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Features AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_HAS_' || SUBSTR(a.FeatureType, 9) FROM Features AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Features AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Features AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_HAS_' || SUBSTR(a.FeatureType, 9) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Features AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;


-- Some resources from Resourceful2 (so that it doesn't throw an error if Resourceful2 is missing)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
                                    ('DB_REQ_HAS_HONEY', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
									('DB_REQ_HAS_MUSHROOMS', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
									('DB_REQ_HAS_ORCA', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
                                            ('DB_REQ_HAS_HONEY', 'ResourceType', 'RESOURCE_HONEY'),
									        ('DB_REQ_HAS_MUSHROOMS', 'ResourceType', 'RESOURCE_MUSHROOMS'),
									        ('DB_REQ_HAS_ORCA', 'ResourceType', 'RESOURCE_ORCA') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
                                       ('DB_REQSET_HAS_HONEY', 'REQUIREMENTSET_TEST_ALL'),
									   ('DB_REQSET_HAS_MUSHROOMS', 'REQUIREMENTSET_TEST_ALL'),
									   ('DB_REQSET_HAS_ORCA', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_HAS_HONEY', 'DB_REQ_HAS_HONEY'),
									   ('DB_REQSET_HAS_MUSHROOMS', 'DB_REQ_HAS_MUSHROOMS'),
									   ('DB_REQSET_HAS_ORCA', 'DB_REQ_HAS_ORCA') ;

-- Plot has resource (DB_REQ_HAS_STONE, DB_REQSET_HAS_STONE)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_HAS_' || SUBSTR(ResourceType, 10), 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES' FROM Resources ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_HAS_' || SUBSTR(ResourceType, 10), 'ResourceType', ResourceType FROM Resources ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(ResourceType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Resources ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(ResourceType, 10), 'DB_REQ_HAS_' || SUBSTR(ResourceType, 10) FROM Resources ;


-- Plot has resource X and is next to district Y (DB_REQ_HAS_STONE_NEXT_TO_HOLY_SITE, DB_REQSET_HAS_STONE_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Resources AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_HAS_' || SUBSTR(a.ResourceType, 10) FROM Resources AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Resources AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Resources AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_HAS_' || SUBSTR(a.ResourceType, 10) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Resources AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;


-- Plot has improvement (DB_REQ_HAS_AIRSTRIP, DB_REQSET_HAS_AIRSTRIP)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  SELECT 'DB_REQ_HAS_' || SUBSTR(ImprovementType, 13), 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES' FROM Improvements ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  SELECT 'DB_REQ_HAS_' || SUBSTR(ImprovementType, 13), 'ImprovementType', ImprovementType FROM Improvements ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(ImprovementType, 13), 'REQUIREMENTSET_TEST_ALL' FROM Improvements ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_HAS_' || SUBSTR(ImprovementType, 13), 'DB_REQ_HAS_' || SUBSTR(ImprovementType, 13) FROM Improvements ;

-- Plot has improvement X and is next to district Y (DB_REQ_HAS_STONE_NEXT_TO_HOLY_SITE, DB_REQSET_HAS_STONE_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Improvements AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_HAS_' || SUBSTR(a.ImprovementType, 13) FROM Improvements AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  SELECT 'DB_REQSET_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Improvements AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Improvements AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10), 'RequirementSetId', 'DB_REQSET_HAS_' || SUBSTR(a.ImprovementType, 13) || '_NEXT_TO_' || SUBSTR(b.DistrictType, 10) FROM Improvements AS a LEFT JOIN Districts AS b WHERE b.TraitType IS NULL ;

-- Plantation Tags
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES 
                         ('DB_REQ_HAS_PLANTATION_TAG', 'REQUIREMENT_REQUIREMENTSET_IS_MET'),
						 ('DB_REQ_HAS_PLANTATION_TAG2', 'REQUIREMENT_REQUIREMENTSET_IS_MET') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES 
                                 ('DB_REQ_HAS_PLANTATION_TAG', 'RequirementSetId', 'PLOT_HAS_PLANTATION_TAG_REQUIREMENTS'),
								 ('DB_REQ_HAS_PLANTATION_TAG2', 'RequirementSetId', 'PLOT_HAS_PLANTATION_TAG2_REQUIREMENTS') ;
-- Plantation Tag next to district (DB_REQ_PLANTATION_TAG_NEXT_TO_HOLY_SITE, DB_REQSET_PLANTATION_TAG_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_HAS_PLANTATION_TAG' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10), 'RequirementSetId', 'DB_REQSET_PLANTATION_TAG_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;

-- Plantation Tag 2 next to district (DB_REQ_PLANTATION_TAG2_NEXT_TO_HOLY_SITE, DB_REQSET_PLANTATION_TAG2_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_HAS_PLANTATION_TAG2' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10), 'RequirementSetId', 'DB_REQSET_PLANTATION_TAG2_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;

-- Specific Mines (DB_REQ_HAS_STRATEGIC_MINE, DB_REQSET_HAS_STRATEGIC_MINE)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
						 ('DB_REQ_HAS_BONUS_MINE', 'REQUIREMENT_REQUIREMENTSET_IS_MET'),
						 ('DB_REQ_HAS_LUXURY_MINE', 'REQUIREMENT_REQUIREMENTSET_IS_MET'),
						 ('DB_REQ_HAS_STRATEGIC_MINE', 'REQUIREMENT_REQUIREMENTSET_IS_MET') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
                                 ('DB_REQ_HAS_BONUS_MINE', 'RequirementSetId', 'PLOT_HAS_BONUS_MINE_REQUIREMENTS'),
                                 ('DB_REQ_HAS_LUXURY_MINE', 'RequirementSetId', 'PLOT_HAS_LUXURY_MINE_REQUIREMENTS'),
                                 ('DB_REQ_HAS_STRATEGIC_MINE', 'RequirementSetId', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
                            ('DB_REQSET_HAS_BONUS_MINE', 'REQUIREMENTSET_TEST_ALL'),
							('DB_REQSET_HAS_LUXURY_MINE', 'REQUIREMENTSET_TEST_ALL'),
							('DB_REQSET_HAS_STRATEGIC_MINE', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_HAS_BONUS_MINE', 'DB_REQ_HAS_BONUS_MINE'),
                                       ('DB_REQSET_HAS_LUXURY_MINE', 'DB_REQ_HAS_LUXURY_MINE'),
                                       ('DB_REQSET_HAS_STRATEGIC_MINE', 'DB_REQ_HAS_STRATEGIC_MINE') ;

-- Strategic Mine next to district (DB_REQ_STRATEGIC_MINE_NEXT_TO_HOLY_SITE, DB_REQSET_STRATEGIC_MINE_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_HAS_STRATEGIC_MINE' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'RequirementSetId', 'DB_REQSET_STRATEGIC_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;

-- Bonus Mine OR Luxury Mine (DB_REQ_HAS_BONUS_OR_LUXURY_MINE, DB_REQSET_HAS_BONUS_OR_LUXURY_MINE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_HAS_BONUS_OR_LUXURY_MINE', 'REQUIREMENTSET_TEST_ANY') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_HAS_BONUS_OR_LUXURY_MINE', 'DB_REQ_HAS_LUXURY_MINE'),
									   ('DB_REQSET_HAS_BONUS_OR_LUXURY_MINE', 'DB_REQ_HAS_BONUS_MINE') ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_HAS_BONUS_OR_LUXURY_MINE', 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_HAS_BONUS_OR_LUXURY_MINE', 'RequirementSetId', 'DB_REQSET_HAS_BONUS_OR_LUXURY_MINE');

-- Bonus or Luxury mine next to district (DB_REQ_BONUS_OR_LUXURY_MINE_NEXT_TO_HOLY_SITE, DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_HOLY_SITE)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
  SELECT 'DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENTSET_TEST_ALL' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_HAS_BONUS_OR_LUXURY_MINE' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
  SELECT 'DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'DB_REQ_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) 
  SELECT 'DB_REQ_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'REQUIREMENT_REQUIREMENTSET_IS_MET' FROM Districts WHERE TraitType IS NULL ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) 
  SELECT 'DB_REQ_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10), 'RequirementSetId', 'DB_REQSET_BONUS_OR_LUXURY_MINE_NEXT_TO_' || SUBSTR(DistrictType, 10) FROM Districts WHERE TraitType IS NULL ;


-- Plot is Breathtaking (DB_REQ_BREATHTAKING_APPEAL, DB_REQSET_BREATHTAKING_APPEAL)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_BREATHTAKING_APPEAL', 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_BREATHTAKING_APPEAL', 'MinimumAppeal', 4) ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_BREATHTAKING_APPEAL', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_BREATHTAKING_APPEAL', 'DB_REQ_BREATHTAKING_APPEAL') ;


-- Units being near friendly and enemy cities that follow our religion (DB_REQ_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY, DB_REQSET_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
                                       ('DB_REQSET_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY', 'REQUIREMENTSET_TEST_ALL'),
									   ('DB_REQSET_UNIT_NEAR_ENEMY_RELIGIOUS_CITY', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                                  ('DB_REQSET_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY', 'REQUIRES_UNIT_NEAR_FRIENDLY_RELIGIOUS_CITY'),
												  ('DB_REQSET_UNIT_NEAR_ENEMY_RELIGIOUS_CITY', 'REQUIRES_UNIT_NEAR_ENEMY_RELIGIOUS_CITY') ;


-- Reqset for being within 2 tiles of owner (e.g. great generals)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_AOE_OWNER_ADJACENCY', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_AOE_OWNER_ADJACENCY', 'AOE_REQUIRES_OWNER_ADJACENCY') ;

-- Unit is Religious (all)
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_UNIT_IS_RELIGIOUS_ALL', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_UNIT_IS_RELIGIOUS_ALL', 'REQUIRES_UNIT_IS_RELIGIOUS_ALL') ;

-- Unit is Guru
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_UNIT_IS_GURU', 'REQUIREMENT_UNIT_TYPE_MATCHES') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_UNIT_IS_GURU', 'UnitType', 'UNIT_GURU') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_UNIT_IS_GURU', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_UNIT_IS_GURU', 'DB_REQ_UNIT_IS_GURU') ;

-- Unit is Great Prophet
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_UNIT_IS_GREAT_PROPHET', 'REQUIREMENT_UNIT_TYPE_MATCHES') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_UNIT_IS_GREAT_PROPHET', 'UnitType', 'UNIT_GREAT_PROPHET') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_UNIT_IS_GREAT_PROPHET', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_UNIT_IS_GREAT_PROPHET', 'DB_REQ_UNIT_IS_GREAT_PROPHET') ;

-- Unit next to Guru
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_NEXTTO_GURU', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TYPE_MATCHES') ;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('DB_REQ_NEXTTO_GURU', 'UnitType', 'UNIT_GURU') ;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_NEXTTO_GURU', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_NEXTTO_GURU', 'DB_REQ_NEXTTO_GURU') ;

-- Unit next to Great Prophet

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('DB_REQ_NEXTTO_GREAT_PROPHET', 'REQUIREMENT_PLOT_NEARBY_UNIT_TAG_MATCHES') ;
INSERT OR IGNORE INTO RequirementArguments 
(RequirementId,					Name,			Value) 
VALUES 
('DB_REQ_NEXTTO_GREAT_PROPHET',	'MaxDistance',	2),
('DB_REQ_NEXTTO_GREAT_PROPHET',	'MinDistance',	0),
('DB_REQ_NEXTTO_GREAT_PROPHET',	'Tag',			'DB_CLASS_GREAT_PROPHET') ;

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_NEXTTO_GREAT_PROPHET', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('DB_REQSET_NEXTTO_GREAT_PROPHET', 'DB_REQ_NEXTTO_GREAT_PROPHET') ;

/*
-- Non-religious unit belongs to civ that founded the religion that has this belief
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
                                       ('DB_REQSET_FOUNDERS_COMBAT_UNIT', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                                  ('DB_REQSET_FOUNDERS_COMBAT_UNIT', 'REQUIRES_NON_RELIGIOUS_UNIT'),
									              ('DB_REQSET_FOUNDERS_COMBAT_UNIT', 'REQUIRES_PLAYER_FOUNDED_RELIGION') ;


-- Inquisitor unit belongs to civ that founded the religion that has this belief
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('DB_REQSET_FOUNDERS_INQUISITOR', 'REQUIREMENTSET_TEST_ALL') ;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
                                       ('DB_REQSET_FOUNDERS_INQUISITOR', 'REQUIRES_UNIT_IS_INQUISITOR'),
									   ('DB_REQSET_FOUNDERS_INQUISITOR', 'REQUIRES_PLAYER_FOUNDED_RELIGION') ;
*/

-- Governor with X titles (DB_REQSET_CITY_HAS_PANTHEON_AND_2_GOV_TITLE_ESTABLISHED)
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_TITLE_GOVERNOR_ESTABLISHED', 'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES' FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_TITLE_GOVERNOR_ESTABLISHED', 'Amount', x FROM counter ;

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQ_CITY_HAS_' || x || '_TITLE_GOVERNOR_ESTABLISHED', 'Established', 1 FROM counter ;

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQSET_CITY_HAS_PANTHEON_AND_' || x || '_GOV_TITLE_ESTABLISHED', 'REQUIREMENTSET_TEST_ALL' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQSET_CITY_HAS_PANTHEON_AND_' || x || '_GOV_TITLE_ESTABLISHED', 'DB_REQ_CITY_HAS_' || x || '_TITLE_GOVERNOR_ESTABLISHED' FROM counter ;

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) 
  WITH counter as (SELECT 1 x UNION SELECT x + 1 FROM counter WHERE x < 6) 
  SELECT 'DB_REQSET_CITY_HAS_PANTHEON_AND_' || x || '_GOV_TITLE_ESTABLISHED', 'REQUIRES_CITY_FOLLOWS_PANTHEON' FROM counter ;


-- Attacking and Defending
INSERT OR IGNORE INTO Requirements
(RequirementId,			RequirementType,					Inverse) 
VALUES
('DB_REQ_ATTACKING',	'REQUIREMENT_PLAYER_IS_ATTACKING',	0),
('DB_REQ_DEFENDING',	'REQUIREMENT_PLAYER_IS_ATTACKING',	1)
;

INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,		RequirementSetType)
VALUES
('DB_REQSET_ATTACKING',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,		RequirementId)
VALUES
('DB_REQSET_ATTACKING',	'DB_REQ_ATTACKING'),
('DB_REQSET_DEFENDING',	'DB_REQ_DEFENDING')
;

-- Combat Type is ranged, melee
INSERT OR IGNORE INTO Requirements
(RequirementId,			RequirementType,					Inverse) 
VALUES
('DB_REQ_MELEE_COMBAT',		'REQUIREMENT_COMBAT_TYPE_MATCHES',	0),
('DB_REQ_RANGED_COMBAT',	'REQUIREMENT_COMBAT_TYPE_MATCHES',	0)
;

INSERT OR IGNORE INTO RequirementArguments
(RequirementId,				Name,				Value)
VALUES
('DB_REQ_MELEE_COMBAT',		'CombatType',		'COMBAT_MELEE'),
('DB_REQ_RANGED_COMBAT',	'CombatType',		'COMBAT_RANGED')
;

INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,				RequirementSetType)
VALUES
('DB_REQSET_MELEE_COMBAT',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_RANGED_COMBAT',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_MELEE',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_MELEE',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_RANGED',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_RANGED',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,		RequirementId)
VALUES
('DB_REQSET_MELEE_COMBAT',		'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_ATTACKING_MELEE',	'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_ATTACKING_MELEE',	'DB_REQ_ATTACKING'),
('DB_REQSET_DEFENDING_MELEE',	'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_DEFENDING_MELEE',	'DB_REQ_DEFENDING'),

('DB_REQSET_RANGED_COMBAT',		'DB_REQ_RANGED_COMBAT'),
('DB_REQSET_ATTACKING_RANGED',	'DB_REQ_RANGED_COMBAT'),
('DB_REQSET_ATTACKING_RANGED',	'DB_REQ_ATTACKING'),
('DB_REQSET_DEFENDING_RANGED',	'DB_REQ_RANGED_COMBAT'),
('DB_REQSET_DEFENDING_RANGED',	'DB_REQ_DEFENDING')
;


-- Opponent unit is Land, Sea, Air, City, damaged, etc.
INSERT OR IGNORE INTO Requirements
(RequirementId,									RequirementType,							Inverse) 
VALUES
('DB_REQ_OPPONENT_IS_LAND_UNIT',				'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	0),
('DB_REQ_OPPONENT_IS_SEA_UNIT',					'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	0),
('DB_REQ_OPPONENT_IS_AIR_UNIT',					'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	0),
('DB_REQ_OPPONENT_IS_CITY_OR_ENCAMPMENT',		'REQUIREMENT_OPPONENT_IS_DISTRICT',			0),
('DB_REQ_OPPONENT_IS_NOT_LAND_UNIT',			'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	1),
('DB_REQ_OPPONENT_IS_NOT_SEA_UNIT',				'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	1),
('DB_REQ_OPPONENT_IS_NOT_AIR_UNIT',				'REQUIREMENT_OPPONENT_UNIT_DOMAIN_MATCHES',	1),
('DB_REQ_OPPONENT_IS_DAMAGED',					'REQUIREMENT_UNIT_DAMAGE_MINIMUM',			0),
('DB_REQ_OPPONENT_HAS_21_DAMAGE',				'REQUIREMENT_UNIT_DAMAGE_MINIMUM',			0),
('DB_REQ_OPPONENT_IS_WOUNDED',					'REQUIREMENT_OPPONENT_IS_WOUNDED',			0),
('DB_REQ_OPPONENT_IS_FORTIFIED',				'REQUIREMENT_OPPONENT_IS_FORTIFIED',		0),
('DB_REQ_OPPONENT_IS_OTHER_RELIGION',			'REQUIREMENT_OPPONENT_IS_OTHER_RELIGION',	0),
('DB_REQ_OPPONENT_IS_LAND_COMBAT',				'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_NAVAL_COMBAT',				'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_AIR_COMBAT',				'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_LAND_MELEE_ATTACKER',		'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_LAND_RANGED_ATTACKER',		'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_LAND_BOMBARD_ATTACKER',	'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_NAVAL_MELEE_ATTACKER',		'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_NAVAL_RANGED_ATTACKER',	'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0),
('DB_REQ_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES',	0)
;

INSERT OR IGNORE INTO RequirementArguments
(RequirementId,									Name,				Value)
VALUES
('DB_REQ_OPPONENT_IS_LAND_UNIT',				'UnitDomain',		'DOMAIN_LAND'),
('DB_REQ_OPPONENT_IS_SEA_UNIT',					'UnitDomain',		'DOMAIN_SEA'),
('DB_REQ_OPPONENT_IS_AIR_UNIT',					'UnitDomain',		'DOMAIN_AIR'),
('DB_REQ_OPPONENT_IS_NOT_LAND_UNIT',			'UnitDomain',		'DOMAIN_LAND'),
('DB_REQ_OPPONENT_IS_NOT_SEA_UNIT',				'UnitDomain',		'DOMAIN_SEA'),
('DB_REQ_OPPONENT_IS_NOT_AIR_UNIT',				'UnitDomain',		'DOMAIN_AIR'),
('DB_REQ_OPPONENT_IS_DAMAGED',					'MinimumAmount',	1),
('DB_REQ_OPPONENT_HAS_21_DAMAGE',				'MinimumAmount',	21),
('DB_REQ_OPPONENT_IS_LAND_COMBAT',				'Tag',				'DB_CLASS_LAND_COMBAT'),
('DB_REQ_OPPONENT_IS_NAVAL_COMBAT',				'Tag',				'DB_CLASS_NAVAL_COMBAT'),
('DB_REQ_OPPONENT_IS_AIR_COMBAT',				'Tag',				'DB_CLASS_AIR_COMBAT'),
('DB_REQ_OPPONENT_IS_LAND_MELEE_ATTACKER',		'Tag',				'DB_CLASS_LAND_MELEE_ATTACKER'),
('DB_REQ_OPPONENT_IS_LAND_RANGED_ATTACKER',		'Tag',				'DB_CLASS_LAND_RANGED_ATTACKER'),
('DB_REQ_OPPONENT_IS_LAND_BOMBARD_ATTACKER',	'Tag',				'DB_CLASS_LAND_BOMBARD_ATTACKER'),
('DB_REQ_OPPONENT_IS_NAVAL_MELEE_ATTACKER',		'Tag',				'DB_CLASS_NAVAL_MELEE_ATTACKER'),
('DB_REQ_OPPONENT_IS_NAVAL_RANGED_ATTACKER',	'Tag',				'DB_CLASS_NAVAL_RANGED_ATTACKER'),
('DB_REQ_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER',	'Tag',				'DB_CLASS_NAVAL_BOMBARD_ATTACKER')
;


INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,									RequirementSetType)
VALUES
('DB_REQSET_OPPONENT_IS_LAND_UNIT',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_SEA_UNIT',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_AIR_UNIT',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_CITY_OR_ENCAMPMENT',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NOT_LAND_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NOT_SEA_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NOT_AIR_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_DAMAGED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_HAS_21_DAMAGE',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_WOUNDED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_FORTIFIED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_OTHER_RELIGION',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_LAND_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NAVAL_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_AIR_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_LAND_MELEE_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_LAND_RANGED_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_LAND_BOMBARD_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NAVAL_MELEE_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NAVAL_RANGED_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,									RequirementId)
VALUES
('DB_REQSET_OPPONENT_IS_LAND_UNIT',					'DB_REQ_OPPONENT_IS_LAND_UNIT'),
('DB_REQSET_OPPONENT_IS_SEA_UNIT',					'DB_REQ_OPPONENT_IS_SEA_UNIT'),
('DB_REQSET_OPPONENT_IS_AIR_UNIT',					'DB_REQ_OPPONENT_IS_AIR_UNIT'),
('DB_REQSET_OPPONENT_IS_CITY_OR_ENCAMPMENT',		'DB_REQ_OPPONENT_IS_CITY_OR_ENCAMPMENT'),
('DB_REQSET_OPPONENT_IS_NOT_LAND_UNIT',				'DB_REQ_OPPONENT_IS_NOT_LAND_UNIT'),
('DB_REQSET_OPPONENT_IS_NOT_SEA_UNIT',				'DB_REQ_OPPONENT_IS_NOT_SEA_UNIT'),
('DB_REQSET_OPPONENT_IS_NOT_AIR_UNIT',				'DB_REQ_OPPONENT_IS_NOT_AIR_UNIT'),
('DB_REQSET_OPPONENT_IS_DAMAGED',					'DB_REQ_OPPONENT_IS_DAMAGED'),
('DB_REQSET_OPPONENT_HAS_21_DAMAGE',				'DB_REQ_OPPONENT_HAS_21_DAMAGE'),
('DB_REQSET_OPPONENT_IS_WOUNDED',					'DB_REQ_OPPONENT_IS_WOUNDED'),
('DB_REQSET_OPPONENT_IS_FORTIFIED',					'DB_REQ_OPPONENT_IS_FORTIFIED'),
('DB_REQSET_OPPONENT_IS_OTHER_RELIGION',			'DB_REQ_OPPONENT_IS_OTHER_RELIGION'),
('DB_REQSET_OPPONENT_IS_LAND_COMBAT',				'DB_REQ_OPPONENT_IS_LAND_COMBAT'),
('DB_REQSET_OPPONENT_IS_NAVAL_COMBAT',				'DB_REQ_OPPONENT_IS_NAVAL_COMBAT'),
('DB_REQSET_OPPONENT_IS_AIR_COMBAT',				'DB_REQ_OPPONENT_IS_AIR_COMBAT'),
('DB_REQSET_OPPONENT_IS_LAND_MELEE_ATTACKER',		'DB_REQ_OPPONENT_IS_LAND_MELEE_ATTACKER'),
('DB_REQSET_OPPONENT_IS_LAND_RANGED_ATTACKER',		'DB_REQ_OPPONENT_IS_LAND_RANGED_ATTACKER'),
('DB_REQSET_OPPONENT_IS_LAND_BOMBARD_ATTACKER',		'DB_REQ_OPPONENT_IS_LAND_BOMBARD_ATTACKER'),
('DB_REQSET_OPPONENT_IS_NAVAL_MELEE_ATTACKER',		'DB_REQ_OPPONENT_IS_NAVAL_MELEE_ATTACKER'),
('DB_REQSET_OPPONENT_IS_NAVAL_RANGED_ATTACKER',		'DB_REQ_OPPONENT_IS_NAVAL_RANGED_ATTACKER'),
('DB_REQSET_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER')
;

-- Attacking/defending the different opponent types
INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,								RequirementSetType)
VALUES
('DB_REQSET_ATTACKING_LAND_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_SEA_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_AIR_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_CITY_OR_ENCAMPMENT',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NOT_LAND_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NOT_SEA_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NOT_AIR_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_DAMAGED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_VS_21_DAMAGE',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_WOUNDED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_FORTIFIED',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_OTHER_RELIGION',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_LAND_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NAVAL_COMBAT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_AIR_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_LAND_MELEE_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_LAND_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_LAND_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NAVAL_MELEE_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NAVAL_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ATTACKING_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_MELEE_ATTACKING_LAND',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_MELEE_ATTACKING_NAVAL',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_RANGED_ATTACKING_LAND',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_RANGED_ATTACKING_NAVAL',			'REQUIREMENTSET_TEST_ALL'),

('DB_REQSET_DEFENDING_LAND_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_SEA_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_AIR_UNIT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_CITY_OR_ENCAMPMENT',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NOT_LAND_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NOT_SEA_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NOT_AIR_UNIT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_DAMAGED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_VS_21_DAMAGE',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_WOUNDED',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_FORTIFIED',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_OTHER_RELIGION',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_LAND_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NAVAL_COMBAT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_AIR_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_LAND_MELEE_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_LAND_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_LAND_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NAVAL_MELEE_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NAVAL_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_DEFENDING_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_MELEE_DEFENDING_LAND',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_MELEE_DEFENDING_NAVAL',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_RANGED_DEFENDING_LAND',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_RANGED_DEFENDING_NAVAL',			'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,								RequirementId)
VALUES
('DB_REQSET_ATTACKING_LAND_UNIT',				'DB_REQ_OPPONENT_IS_LAND_UNIT'),
('DB_REQSET_ATTACKING_SEA_UNIT',				'DB_REQ_OPPONENT_IS_SEA_UNIT'),
('DB_REQSET_ATTACKING_AIR_UNIT',				'DB_REQ_OPPONENT_IS_AIR_UNIT'),
('DB_REQSET_ATTACKING_CITY_OR_ENCAMPMENT',		'DB_REQ_OPPONENT_IS_CITY_OR_ENCAMPMENT'),
('DB_REQSET_ATTACKING_NOT_LAND_UNIT',			'DB_REQ_OPPONENT_IS_NOT_LAND_UNIT'),
('DB_REQSET_ATTACKING_NOT_SEA_UNIT',			'DB_REQ_OPPONENT_IS_NOT_SEA_UNIT'),
('DB_REQSET_ATTACKING_NOT_AIR_UNIT',			'DB_REQ_OPPONENT_IS_NOT_AIR_UNIT'),
('DB_REQSET_ATTACKING_DAMAGED',					'DB_REQ_OPPONENT_IS_DAMAGED'),
('DB_REQSET_ATTACKING_VS_21_DAMAGE',			'DB_REQ_OPPONENT_HAS_21_DAMAGE'),
('DB_REQSET_ATTACKING_WOUNDED',					'DB_REQ_OPPONENT_IS_WOUNDED'),
('DB_REQSET_ATTACKING_FORTIFIED',				'DB_REQ_OPPONENT_IS_FORTIFIED'),
('DB_REQSET_ATTACKING_OTHER_RELIGION',			'DB_REQ_OPPONENT_IS_OTHER_RELIGION'),
('DB_REQSET_ATTACKING_LAND_COMBAT',				'DB_REQ_OPPONENT_IS_LAND_COMBAT'),
('DB_REQSET_ATTACKING_NAVAL_COMBAT',			'DB_REQ_OPPONENT_IS_NAVAL_COMBAT'),
('DB_REQSET_ATTACKING_AIR_COMBAT',				'DB_REQ_OPPONENT_IS_AIR_COMBAT'),
('DB_REQSET_ATTACKING_LAND_MELEE_ATTACKER',		'DB_REQ_OPPONENT_IS_LAND_MELEE_ATTACKER'),
('DB_REQSET_ATTACKING_LAND_RANGED_ATTACKER',	'DB_REQ_OPPONENT_IS_LAND_RANGED_ATTACKER'),
('DB_REQSET_ATTACKING_LAND_BOMBARD_ATTACKER',	'DB_REQ_OPPONENT_IS_LAND_BOMBARD_ATTACKER'),
('DB_REQSET_ATTACKING_NAVAL_MELEE_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_MELEE_ATTACKER'),
('DB_REQSET_ATTACKING_NAVAL_RANGED_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_RANGED_ATTACKER'),
('DB_REQSET_ATTACKING_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER'),
('DB_REQSET_MELEE_ATTACKING_LAND',				'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_MELEE_ATTACKING_NAVAL',				'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_RANGED_ATTACKING_LAND',				'DB_REQ_RANGED_COMBAT'),
('DB_REQSET_RANGED_ATTACKING_NAVAL',			'DB_REQ_RANGED_COMBAT'),


('DB_REQSET_ATTACKING_LAND_UNIT',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_SEA_UNIT',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_AIR_UNIT',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_CITY_OR_ENCAMPMENT',		'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NOT_LAND_UNIT',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NOT_SEA_UNIT',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NOT_AIR_UNIT',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_DAMAGED',					'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_VS_21_DAMAGE',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_WOUNDED',					'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_FORTIFIED',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_OTHER_RELIGION',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_LAND_COMBAT',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NAVAL_COMBAT',			'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_AIR_COMBAT',				'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_LAND_MELEE_ATTACKER',		'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_LAND_RANGED_ATTACKER',	'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_LAND_BOMBARD_ATTACKER',	'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NAVAL_MELEE_ATTACKER',	'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NAVAL_RANGED_ATTACKER',	'DB_REQ_ATTACKING'),
('DB_REQSET_ATTACKING_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_ATTACKING'),
('DB_REQSET_MELEE_ATTACKING_LAND',				'DB_REQ_ATTACKING'),
('DB_REQSET_MELEE_ATTACKING_NAVAL',				'DB_REQ_ATTACKING'),
('DB_REQSET_RANGED_ATTACKING_LAND',				'DB_REQ_ATTACKING'),
('DB_REQSET_RANGED_ATTACKING_NAVAL',			'DB_REQ_ATTACKING'),


('DB_REQSET_DEFENDING_LAND_UNIT',				'DB_REQ_OPPONENT_IS_LAND_UNIT'),
('DB_REQSET_DEFENDING_SEA_UNIT',				'DB_REQ_OPPONENT_IS_SEA_UNIT'),
('DB_REQSET_DEFENDING_AIR_UNIT',				'DB_REQ_OPPONENT_IS_AIR_UNIT'),
('DB_REQSET_DEFENDING_CITY_OR_ENCAMPMENT',		'DB_REQ_OPPONENT_IS_CITY_OR_ENCAMPMENT'),
('DB_REQSET_DEFENDING_NOT_LAND_UNIT',			'DB_REQ_OPPONENT_IS_NOT_LAND_UNIT'),
('DB_REQSET_DEFENDING_NOT_SEA_UNIT',			'DB_REQ_OPPONENT_IS_NOT_SEA_UNIT'),
('DB_REQSET_DEFENDING_NOT_AIR_UNIT',			'DB_REQ_OPPONENT_IS_NOT_AIR_UNIT'),
('DB_REQSET_DEFENDING_DAMAGED',					'DB_REQ_OPPONENT_IS_DAMAGED'),
('DB_REQSET_DEFENDING_VS_21_DAMAGE',			'DB_REQ_OPPONENT_HAS_21_DAMAGE'),
('DB_REQSET_DEFENDING_WOUNDED',					'DB_REQ_OPPONENT_IS_WOUNDED'),
('DB_REQSET_DEFENDING_FORTIFIED',				'DB_REQ_OPPONENT_IS_FORTIFIED'),
('DB_REQSET_DEFENDING_OTHER_RELIGION',			'DB_REQ_OPPONENT_IS_OTHER_RELIGION'),
('DB_REQSET_DEFENDING_LAND_COMBAT',				'DB_REQ_OPPONENT_IS_LAND_COMBAT'),
('DB_REQSET_DEFENDING_NAVAL_COMBAT',			'DB_REQ_OPPONENT_IS_NAVAL_COMBAT'),
('DB_REQSET_DEFENDING_AIR_COMBAT',				'DB_REQ_OPPONENT_IS_AIR_COMBAT'),
('DB_REQSET_DEFENDING_LAND_MELEE_ATTACKER',		'DB_REQ_OPPONENT_IS_LAND_MELEE_ATTACKER'),
('DB_REQSET_DEFENDING_LAND_RANGED_ATTACKER',	'DB_REQ_OPPONENT_IS_LAND_RANGED_ATTACKER'),
('DB_REQSET_DEFENDING_LAND_BOMBARD_ATTACKER',	'DB_REQ_OPPONENT_IS_LAND_BOMBARD_ATTACKER'),
('DB_REQSET_DEFENDING_NAVAL_MELEE_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_MELEE_ATTACKER'),
('DB_REQSET_DEFENDING_NAVAL_RANGED_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_RANGED_ATTACKER'),
('DB_REQSET_DEFENDING_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_OPPONENT_IS_NAVAL_BOMBARD_ATTACKER'),
('DB_REQSET_MELEE_DEFENDING_LAND',				'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_MELEE_DEFENDING_NAVAL',				'DB_REQ_MELEE_COMBAT'),
('DB_REQSET_RANGED_DEFENDING_LAND',				'DB_REQ_RANGED_COMBAT'),
('DB_REQSET_RANGED_DEFENDING_NAVAL',			'DB_REQ_RANGED_COMBAT'),


('DB_REQSET_DEFENDING_LAND_UNIT',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_SEA_UNIT',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_AIR_UNIT',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_CITY_OR_ENCAMPMENT',		'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NOT_LAND_UNIT',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NOT_SEA_UNIT',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NOT_AIR_UNIT',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_DAMAGED',					'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_VS_21_DAMAGE',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_WOUNDED',					'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_FORTIFIED',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_OTHER_RELIGION',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_LAND_COMBAT',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NAVAL_COMBAT',			'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_AIR_COMBAT',				'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_LAND_MELEE_ATTACKER',		'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_LAND_RANGED_ATTACKER',	'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_LAND_BOMBARD_ATTACKER',	'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NAVAL_MELEE_ATTACKER',	'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NAVAL_RANGED_ATTACKER',	'DB_REQ_DEFENDING'),
('DB_REQSET_DEFENDING_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_DEFENDING'),
('DB_REQSET_MELEE_DEFENDING_LAND',				'DB_REQ_DEFENDING'),
('DB_REQSET_MELEE_DEFENDING_NAVAL',				'DB_REQ_DEFENDING'),
('DB_REQSET_RANGED_DEFENDING_LAND',				'DB_REQ_DEFENDING'),
('DB_REQSET_RANGED_DEFENDING_NAVAL',			'DB_REQ_DEFENDING')
;


-- Adjacent unit is at war (e.g. for putting modifiers on the enemy, like Varu decrementing the enemy CS)
INSERT OR IGNORE INTO Requirements
(RequirementId,					RequirementType,								Inverse) 
VALUES
('DB_REQ_ADJACENT_UNIT_AT_WAR',	'REQUIREMENT_PLOT_ADJACENT_TO_OWNER_AT_WAR',	0)
;

INSERT OR IGNORE INTO RequirementArguments
(RequirementId,					Name,				Value)
VALUES
('DB_REQ_ADJACENT_UNIT_AT_WAR',	'MinDistance',		0),
('DB_REQ_ADJACENT_UNIT_AT_WAR',	'MaxDistance',		1)
;

INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,					RequirementSetType)
VALUES
('DB_REQSET_ADJACENT_UNIT_AT_WAR',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,					RequirementId)
VALUES
('DB_REQSET_ADJACENT_UNIT_AT_WAR',	'DB_REQ_ADJACENT_UNIT_AT_WAR')
;


-- Modifier applies when same tile/adjacent to owner (e.g. promoted unit)
INSERT OR IGNORE INTO Requirements
(RequirementId,									RequirementType,						Inverse) 
VALUES
('DB_REQ_SAME_TILE_AS_OWNER',					'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	0),
('DB_REQ_ADJACENT_TO_OWNER',					'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	0),
('DB_REQ_ADJACENT_TO_OR_SAME_TILE_AS_OWNER',	'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	0)
;

INSERT OR IGNORE INTO RequirementArguments
(RequirementId,									Name,			Value)
VALUES
('DB_REQ_SAME_TILE_AS_OWNER',					'MaxDistance',	0),
('DB_REQ_SAME_TILE_AS_OWNER',					'MinDistance',	0),
('DB_REQ_ADJACENT_TO_OWNER',					'MaxDistance',	1),
('DB_REQ_ADJACENT_TO_OWNER',					'MinDistance',	1),
('DB_REQ_ADJACENT_TO_OR_SAME_TILE_AS_OWNER',	'MaxDistance',	1),
('DB_REQ_ADJACENT_TO_OR_SAME_TILE_AS_OWNER',	'MinDistance',	0)
;

INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,								RequirementSetType)
VALUES
('DB_REQSET_SAME_TILE_AS_OWNER',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_TO_OWNER',					'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_TO_OR_SAME_TILE_AS_OWNER',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,								RequirementId)
VALUES
('DB_REQSET_SAME_TILE_AS_OWNER',				'DB_REQ_SAME_TILE_AS_OWNER'),
('DB_REQSET_ADJACENT_TO_OWNER',					'DB_REQ_ADJACENT_TO_OWNER'),
('DB_REQSET_ADJACENT_TO_OR_SAME_TILE_AS_OWNER',	'DB_REQ_ADJACENT_TO_OR_SAME_TILE_AS_OWNER')
;



-- Modifier applies to me when adjacent friendly unit matches tag (e.g. increasing range with obs balloon)
INSERT OR IGNORE INTO Requirements
(RequirementId,									RequirementType,										Inverse) 
VALUES
('DB_REQ_ADJACENT_UNIT_LAND_COMBAT',			'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_NAVAL_COMBAT',			'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_AIR_COMBAT',				'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_LAND_MELEE_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_LAND_RANGED_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_LAND_BOMBARD_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_NAVAL_MELEE_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_NAVAL_RANGED_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0),
('DB_REQ_ADJACENT_UNIT_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES',	0)
;

INSERT OR IGNORE INTO RequirementArguments
(RequirementId,									Name,	Value)
VALUES
('DB_REQ_ADJACENT_UNIT_LAND_COMBAT',			'Tag',	'DB_CLASS_LAND_COMBAT'),
('DB_REQ_ADJACENT_UNIT_NAVAL_COMBAT',			'Tag',	'DB_CLASS_NAVAL_COMBAT'),
('DB_REQ_ADJACENT_UNIT_AIR_COMBAT',				'Tag',	'DB_CLASS_AIR_COMBAT'),
('DB_REQ_ADJACENT_UNIT_LAND_MELEE_ATTACKER',	'Tag',	'DB_CLASS_LAND_MELEE_ATTACKER'),
('DB_REQ_ADJACENT_UNIT_LAND_RANGED_ATTACKER',	'Tag',	'DB_CLASS_LAND_RANGED_ATTACKER'),
('DB_REQ_ADJACENT_UNIT_LAND_BOMBARD_ATTACKER',	'Tag',	'DB_CLASS_LAND_BOMBARD_ATTACKER'),
('DB_REQ_ADJACENT_UNIT_NAVAL_MELEE_ATTACKER',	'Tag',	'DB_CLASS_NAVAL_MELEE_ATTACKER'),
('DB_REQ_ADJACENT_UNIT_NAVAL_RANGED_ATTACKER',	'Tag',	'DB_CLASS_NAVAL_RANGED_ATTACKER'),
('DB_REQ_ADJACENT_UNIT_NAVAL_BOMBARD_ATTACKER',	'Tag',	'DB_CLASS_NAVAL_BOMBARD_ATTACKER')
;

INSERT OR IGNORE INTO RequirementSets
(RequirementSetId,									RequirementSetType)
VALUES
('DB_REQSET_ADJACENT_UNIT_LAND_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_COMBAT',			'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_AIR_COMBAT',				'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_LAND_MELEE_ATTACKER',		'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_LAND_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_LAND_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_MELEE_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_RANGED_ATTACKER',	'REQUIREMENTSET_TEST_ALL'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_BOMBARD_ATTACKER',	'REQUIREMENTSET_TEST_ALL')
;

INSERT OR IGNORE INTO RequirementSetRequirements
(RequirementSetId,									RequirementId)
VALUES
('DB_REQSET_ADJACENT_UNIT_LAND_COMBAT',				'DB_REQ_ADJACENT_UNIT_LAND_COMBAT'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_COMBAT',			'DB_REQ_ADJACENT_UNIT_NAVAL_COMBAT'),
('DB_REQSET_ADJACENT_UNIT_AIR_COMBAT',				'DB_REQ_ADJACENT_UNIT_AIR_COMBAT'),
('DB_REQSET_ADJACENT_UNIT_LAND_MELEE_ATTACKER',		'DB_REQ_ADJACENT_UNIT_LAND_MELEE_ATTACKER'),
('DB_REQSET_ADJACENT_UNIT_LAND_RANGED_ATTACKER',	'DB_REQ_ADJACENT_UNIT_LAND_RANGED_ATTACKER'),
('DB_REQSET_ADJACENT_UNIT_LAND_BOMBARD_ATTACKER',	'DB_REQ_ADJACENT_UNIT_LAND_BOMBARD_ATTACKER'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_MELEE_ATTACKER',	'DB_REQ_ADJACENT_UNIT_NAVAL_MELEE_ATTACKER'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_RANGED_ATTACKER',	'DB_REQ_ADJACENT_UNIT_NAVAL_RANGED_ATTACKER'),
('DB_REQSET_ADJACENT_UNIT_NAVAL_BOMBARD_ATTACKER',	'DB_REQ_ADJACENT_UNIT_NAVAL_BOMBARD_ATTACKER')
;












-----------------------------------------------
-----------------------------------------------
-- Dynamic Modifiers
-----------------------------------------------
-----------------------------------------------

-- Yield in cities (that follow this religion)
--    CITIES (Amount, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_YIELD', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_YIELD', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_YIELD_CHANGE') ;

-- Yield in cities (that follow this religion) by x%
--   CITIES (Amount, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_YIELD_PERCENT', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_YIELD_PERCENT', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_YIELD_MODIFIER') ;

-- Follower yield in cities (that follow this religion) by x%
--   CITIES (Amount, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_FOLLOWER_YIELD_PERCENT', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_FOLLOWER_YIELD_PERCENT', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_FOLLOWER_YIELD_MODIFIER') ;

-- Can purchase unit with faith (when a city follows the religion)
--    CITIES (Tag)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_CAN_PURCHASE_UNIT_W_FAITH', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_CAN_PURCHASE_UNIT_W_FAITH', 'COLLECTION_ALL_CITIES', 'EFFECT_ENABLE_UNIT_FAITH_PURCHASE') ;

-- Can purchase districts with gold
--    CITIES (CanPurchase [boolean, set to 1])
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_CAN_PURCHASE_DISTRICTS_W_GOLD', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_CAN_PURCHASE_DISTRICTS_W_GOLD', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_CAN_PURCHASE_DISTRICTS') ;

-- Can purchase districts with faith
--    CITIES (CanPurchase [boolean, set to 1])
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_CAN_PURCHASE_DISTRICTS_W_FAITH', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_CAN_PURCHASE_DISTRICTS_W_FAITH', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CAN_FAITH_PURCHASE_DISTRICTS') ;

-- Can purchase buildings for district with faith
--    CITIES (DistrictType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_CAN_PURCHASE_BUILDING_W_FAITH', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_CAN_PURCHASE_BUILDING_W_FAITH', 'COLLECTION_ALL_CITIES', 'EFFECT_ENABLE_BUILDING_FAITH_PURCHASE') ;

-- Changing purchase costs (when a city follows the religion)
--   CITIES (Amount, UnitType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_UNIT_COST', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_UNIT_COST', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_UNIT_PURCHASE_COST') ;

-- Great Work Yield
--    CITIES (GreatWorkObjectType, ScalingFactor, YieldChange, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_GREATWORK_YIELD', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_GREATWORK_YIELD', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_GREATWORK_YIELD') ;

-- Wonder Yield
--    CITIES (Amount, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_WONDER_YIELD', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_WONDER_YIELD', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_WONDER_YIELD_CHANGE') ;

-- Tourism
--    CITIES (BoostsWonders, GreatWorkObjectType, ImprovementType, Religious, ScalingFactor)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_TOURISM', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_TOURISM', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_TOURISM') ;

-- Amenities from religion
--    CITIES (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_AMENITIES_FROM_RELIGION', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_AMENITIES_FROM_RELIGION', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_AMENITIES_FROM_RELIGION') ;

-- Housing from Great People
--    CITIES (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_HOUSING_FROM_GREAT_PEOPLE', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_HOUSING_FROM_GREAT_PEOPLE', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_HOUSING_FROM_GREAT_PEOPLE') ;

-- Harvest bonus in cities (that follow this religion) by x%
--   CITIES (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_RESOURCE_HARVEST_BONUS', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_RESOURCE_HARVEST_BONUS', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_RESOURCE_HARVEST_BONUS') ;

-- City pressure
--   CITIES (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_RELIGION_PRESSURE', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_RELIGION_PRESSURE', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_RELIGION_PRESSURE') ;

-- River adjacency
--   CITIES (Amount, Description, DistrictType, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_RIVER_ADJACENCY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_RIVER_ADJACENCY', 'COLLECTION_ALL_CITIES', 'EFFECT_RIVER_ADJACENCY') ;

-- District yield based on appeal
--    CITIES (Description, DistrictType, RequiredAppeal, YieldChange, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_DISTRICTS_YIELD_BASED_ON_APPEAL', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_DISTRICTS_YIELD_BASED_ON_APPEAL', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_DISTRICT_YIELD_BASED_ON_APPEAL') ;

-- Always loyal (e.g. Hera)
--    CITIES (AlwaysLoyal [bool])
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ALWAYS_LOYAL', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ALWAYS_LOYAL', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_ALWAYS_LOYAL') ;

-- Wall combat strength
--   CITIES (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_CITIES_ADJUST_WALL_STRENGTH', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_CITIES_ADJUST_WALL_STRENGTH', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_OUTER_DEFENSE') ;

-- Unit damage decrement
INSERT OR IGNORE INTO Types
(Type,											Kind)
VALUES
('DB_DM_REDUCE_DAMAGE_DECREMENT_BY_PERCENT',	'KIND_MODIFIER') ;

INSERT OR IGNORE INTO DynamicModifiers 
(ModifierType,									CollectionType,		EffectType)
VALUES
('DB_DM_REDUCE_DAMAGE_DECREMENT_BY_PERCENT',	'COLLECTION_OWNER',	'EFFECT_ADJUST_UNIT_STRENGTH_REDUCTION_FOR_DAMAGE_MODIFIER') ;

-- All units damage decrement
INSERT OR IGNORE INTO Types
(Type,													Kind)
VALUES
('DB_DM_REDUCE_DAMAGE_DECREMENT_BY_PERCENT_ALL_UNITS',	'KIND_MODIFIER') ;

INSERT OR IGNORE INTO DynamicModifiers 
(ModifierType,											CollectionType,			EffectType)
VALUES
('DB_DM_REDUCE_DAMAGE_DECREMENT_BY_PERCENT_ALL_UNITS',	'COLLECTION_ALL_UNITS',	'EFFECT_ADJUST_UNIT_STRENGTH_REDUCTION_FOR_DAMAGE_MODIFIER') ;


-- Grant single unit ability
INSERT OR IGNORE INTO Types
(Type,									Kind)
VALUES
('DB_DM_GRANT_ABILITY',					'KIND_MODIFIER') ;

INSERT OR IGNORE INTO DynamicModifiers 
(ModifierType,							CollectionType,				EffectType)
VALUES
('DB_DM_GRANT_ABILITY',					'COLLECTION_OWNER',			'EFFECT_GRANT_ABILITY') ;

-- Grant all units ability
INSERT OR IGNORE INTO Types
(Type,									Kind)
VALUES
('DB_DM_GRANT_ABILITY_ALL_UNITS',		'KIND_MODIFIER') ;

INSERT OR IGNORE INTO DynamicModifiers 
(ModifierType,							CollectionType,				EffectType)
VALUES
('DB_DM_GRANT_ABILITY_ALL_UNITS',		'COLLECTION_ALL_UNITS',		'EFFECT_GRANT_ABILITY') ;

-- Grant player units ability
INSERT OR IGNORE INTO Types
(Type,									Kind)
VALUES
('DB_DM_GRANT_ABILITY_PLAYER_UNITS',	'KIND_MODIFIER') ;

INSERT OR IGNORE INTO DynamicModifiers 
(ModifierType,							CollectionType,				EffectType)
VALUES
('DB_DM_GRANT_ABILITY_PLAYER_UNITS',	'COLLECTION_PLAYER_UNITS',	'EFFECT_GRANT_ABILITY') ;






-----------------------------------------------
-- First attach these to the city
-----------------------------------------------

-- DISTRICTS


-- District yields (when a city follows the religion)
--    DISTRICTS (Amount, YieldType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_DISTRICT_YIELD', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_DISTRICT_YIELD', 'COLLECTION_CITY_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_YIELD_CHANGE') ;

-- District great people points (when a city follows the religion)
--    DISTRICTS (Amount, GreatPersonClassType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_DISTRICT_GREATPERSON', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_DISTRICT_GREATPERSON', 'COLLECTION_CITY_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_GREAT_PERSON_POINTS') ;

-- District amenities (when a city follows the religion)
--    DISTRICTS (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_DISTRICT_AMENITIES', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_DISTRICT_AMENITIES', 'COLLECTION_CITY_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_AMENITY') ;

-- District housing (when a city follows the religion)
--    DISTRICTS (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_DISTRICT_HOUSING', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_DISTRICT_HOUSING', 'COLLECTION_CITY_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_HOUSING') ;


-- PLOTS

-- Amenity on plot (e.g. Dionysus)
--    CITIES (Amount)  20
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_IMPROVEMENT_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_IMPROVEMENT_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_IMPROVEMENT_AMENITY') ;

-- Amenity on plot2
--    CITIES (Amount)  20
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_RELIGION_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_RELIGION_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_CITY_AMENITIES_FROM_RELIGION') ;

--    CITIES (Amount) 27
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_CITY_STATE_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_CITY_STATE_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_CITY_AMENITIES_FROM_CITY_STATES') ;

--    CITIES (Amount) 26
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_GOVERNOR_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_GOVERNOR_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_CITY_AMENITIES_FROM_GOVERNORS') ;

--    CITIES (Amount) 26
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_GREAT_PEOPLE_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_GREAT_PEOPLE_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_CITY_AMENITIES_FROM_GREAT_PEOPLE') ;

--    CITIES (Amount) 27
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_LUX_DIVERSITY_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_LUX_DIVERSITY_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_CITY_EXTRA_AMENITY_FOR_LUXURY_DIVERSITY') ;

--    CITIES (Amount) 14
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_NATURAL_WONDER_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_NATURAL_WONDER_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_NATURAL_WONDER_AMENITY') ;

--    CITIES (Amount) 20
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLOT_ADJUST_POLICY_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLOT_ADJUST_POLICY_AMENITY', 'COLLECTION_CITY_PLOT_YIELDS', 'EFFECT_ADJUST_POLICY_AMENITY') ;


-----------------------------------------------
-- Units
-----------------------------------------------

-- Grant promotion to units trained in this city (that follows this religion)
--    UNITS (PromotionType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_GRANT_PROMOTION_TO_TRAINED_UNITS', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_GRANT_PROMOTION_TO_TRAINED_UNITS', 'COLLECTION_CITY_TRAINED_UNITS', 'EFFECT_GRANT_PROMOTION') ;

-- Grant promotion to units trained in this city (that follows this religion)
--    UNITS (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_DAMAGE_TO_UNIT', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_DAMAGE_TO_UNIT', 'COLLECTION_OWNER', 'EFFECT_ADJUST_UNIT_DAMAGE') ;


-----------------------------------------------
-- Player
-----------------------------------------------

-- Grant great person in capital (e.g. Saladin's free prophet at the beginning of the Classical era)
--    CITIES (Amount, GreatPersonClassType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLAYER_GRANT_GREAT_PERSON_IN_CAPITAL', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLAYER_GRANT_GREAT_PERSON_IN_CAPITAL', 'COLLECTION_PLAYER_CAPITAL_CITY', 'EFFECT_GRANT_GREAT_PERSON_CLASS_IN_CITY') ;

-- Grant building in all player's cities (e.g. Print Shop when discovers Printing)
--    CITIES (BuildingType)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_PLAYER_GRANT_BUILDING_IN_PLAYER_CITIES_IGNORE', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_PLAYER_GRANT_BUILDING_IN_PLAYER_CITIES_IGNORE', 'COLLECTION_PLAYER_CITIES', 'EFFECT_GRANT_BUILDING_IN_CITY_IGNORE') ;

--   PLAYERS (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_OWNED_BONUS_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_OWNED_BONUS_AMENITY', 'COLLECTION_OWNER', 'EFFECT_ADJUST_OWNED_BONUS_RESOURCE_EXTRA_AMENITIES') ;

--   PLAYERS (Amount)
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('DB_DM_ADJUST_OWNED_LUXURY_AMENITY', 'KIND_MODIFIER') ;
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES ('DB_DM_ADJUST_OWNED_LUXURY_AMENITY', 'COLLECTION_OWNER', 'EFFECT_ADJUST_OWNED_LUXURY_EXTRA_AMENITIES') ;