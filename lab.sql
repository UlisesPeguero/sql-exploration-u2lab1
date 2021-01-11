create table Recipe (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name VARCHAR(25),
description VARCHAR(50), instructions VARCHAR(500)) ENGINE=InnoDB DEFAULT
CHARSET=utf8;

create table Ingredient (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name
VARCHAR(50)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table Measure (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name
VARCHAR(30)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table RecipeIngredient (recipe_id INT NOT NULL, ingredient_id INT NOT NULL,
measure_id INT, amount FLOAT, amountDesc VARCHAR(10),
CONSTRAINT fk_recipe FOREIGN KEY(recipe_id) REFERENCES Recipe(id),
CONSTRAINT fk_ingredient FOREIGN KEY(ingredient_id) REFERENCES Ingredient(id),
CONSTRAINT fk_measure FOREIGN KEY(measure_id) REFERENCES Measure(id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Changed amount to float to take partials and a description field for showing the data
# Starting with empty tables

### RECIPE (1)

INSERT INTO Ingredient (name) 
VALUES('Graham crust'), ('Heavy cream'), ('Cream cheese'), ('Sugar'), ('Vanilla extract'), ('Sour cream');
# ids   1, 2, 3, 4, 5, 6

INSERT INTO Measure (name) 
VALUES('Cup'), ('Ounce'), ('Tablespoons'), ('Teaspon'), ('Unit');
# ids   1, 2, 3, 4, 5

INSERT INTO Recipe (name, description, instructions) 
VALUES('No-bake Cheesecake', 'No-Bake Cheesecake', 'Mix all the ingredients and fill the crust with it, rest in the frigde for more than 12 hours up to 2 days.');
# id    1

# detail table
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount, amountDesc) 
VALUES 
(1, 1, 5, 1, NULL),
(1, 2, 1, 1.25, "1 and 1/4"),
(1, 3, 2, 24, NULL),
(1, 4, 1, 0.5, "1/2"),
(1, 5, 5, 1, NULL),
(1, 6, 1, 0.25, "1/4");

#### RECIPE (2)

INSERT INTO Ingredient (name) 
VALUES('Puff pastry'), ('Crème fraîche '), ('Strawberries');
# ids   7, 8, 9

INSERT INTO Measure (name) 
VALUES('Sheet');
# ids   6

INSERT INTO Recipe (name, description, instructions) 
VALUES('Strawberry dessert', '3-step Strawberry desert.', 'Cut puff pastry in half and bake at 400 degrees for 18 minutes, whip crème fraîche and sugar until fluffy. Assemble layers of puff pastry, whipped cream and strawberries.');
# id    2

# detail table
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount, amountDesc) 
VALUES 
(2, 7, 6, 2, NULL),
(2, 8, 1, 1, NULL),
(2, 4, 3, 2, NULL),
(2, 9, 2, 4, null);

#### RECIPE (3)

INSERT INTO Ingredient (name) 
VALUES('Egg'), ('Salt'), ('Pepper'), ('Vegetable oil');
# ids   10, 11, 12, 13

INSERT INTO Measure (name) 
VALUES('Pinch');
# ids   7

INSERT INTO Recipe (name, description, instructions) 
VALUES('Fried egg', 'Sunny side up fried egg', 'Heat the oil on a pan on medium heat, drop the egg on the oil and lower temperature, when they white of the egg is cook, remove and season with salt and pepper.');
# id    3

# detail table
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount, amountDesc) 
VALUES 
(3, 10, 5, 1, NULL),
(3, 11, 1, 1, NULL),
(3, 12, 1, 1, NULL),
(3, 13, 3, 3, null);


### All the recipes

SELECT  *
FROM    Recipe;

### All recipes that use a certain ingredient, example "Sugar"

SELECT      Recipe.*
FROM        Recipe
INNER JOIN  RecipeIngredient 
    ON Recipe.id = RecipeIngredient.recipe_id
LEFT JOIN   Ingredient
    ON RecipeIngredient.ingredient_id = Ingredient.id
WHERE       Ingredient.name = "Sugar";

### Update a recipe, updating recipe id:1

UPDATE  Recipe
SET     description = CONCAT('Easy', description)
WHERE   id = 1;
