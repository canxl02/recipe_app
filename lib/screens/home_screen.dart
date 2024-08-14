import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/recipe.dart';

import 'package:recipe_app/screens/recipe_viewer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  /* void addNewRecipe(Recipe newRecipe) {
    setState(() {
      recipeList.add(newRecipe);
    });
  } 
  */

  List<Recipe> recipeList = [
    Recipe(
        ingredients:
            "1 garlic clove, 1 bunch broccolini, 500g pkt fresh mini or regular-sized gnocchi, 150g (1 cup) frozen peas, 100g sun-dried tomato strips, 1 tbsp oil reserved from jar, 1 tbsp plain flour, 375ml (11 ⁄2 cups) So Good Almond Original milk, Fresh basil leaves, to serve",
        instructions:
            "Put the kettle on.While the kettle boils, crush the garlic and cut the broccolini stalks in half lengthways. Heat a deep frying pan over medium-high heat.Pour the boiling water into a large saucepan over high heat. (Don’t fill too high or it will take too long to boil again.) Add the gnocchi and cook until gnocchi rise to the surface, adding the peas and broccolini in the last minute of cooking. Drain.Once the frying pan is hot, pour in the reserved sun-dried tomato oil. Add the garlic and cook, stirring, for 30 seconds. Add the flour. Cook, stirring, for 30 seconds. Remove from heat and gradually whisk in the almond milk until well combined. Return to a medium heat and cook, stirring constantly, until the mixture boils. Simmer for 3 minutes or until the sauce thickens slightly. SeasonAdd the gnocchi mixture and tomato strips to the sauce and stir to combine. Divide among serving bowls, season and top with basil.",
        name: "Creamy vegan sun-dried tomato and broccolini gnocchi",
        servings: "4",
        image: 'lib/assets/images/image1.jpg'),
    Recipe(
        ingredients:
            "1 brown onion, 55g (1/3 cup) unsalted roasted peanuts, 1 long fresh red chilli, 2 tsp olive oil, 450g pkt microwave long-grain rice, 1 tbsp red curry paste, 270g can coconut cream, 250ml (1 cup) Massel Chicken Style Liquid Stock, 130g (1/2 cup) Sanitarium Crunchy Peanut Butter,500g bought diced chicken breast, 140g (1 cup) pre-shredded carrot, 100g baby spinach Lime wedges, to serve (optional)",
        instructions:
            " Heat a large deep frying pan over medium-high heat.While the pan heats up, cut the onion into wedges, coarsely chop the peanuts and thinly slice the chilli.Add the oil and onion to the pan and cook, stirring often, for 1 minute or until the onion softens slightly.Meanwhile, heat the rice following packet directions.Add curry paste to pan. Cook, stirring constantly, for 30 seconds. Stir in coconut cream, stock and peanut butter. Add chicken. Reduce heat to medium and simmer, stirring occasionally, for 4-5 minutes or until the sauce thickens slightly and the chicken is cooked through.Divide chicken curry and rice among serving bowls. Top with carrot, spinach, peanuts and chilli. Serve with lime wedges, if using.",
        name: "Peanut chicken coconut curry",
        servings: "4",
        image: 'lib/assets/images/image2.jpg'),
    Recipe(
        ingredients:
            "1 1/2 tbsp extra virgin olive oil, 600g Coles RSPCA Approved Chicken Breast Stir-fry, 40g packet spice mix for fajitas, 12 small white corn tortillas, 2 green shallots, 280g jar Coles Chargrilled Peppers, drained, coarsely chopped, 200g tub avocado dip, Crème fraîche, to serve, Fresh coriander sprigs, to serve",
        instructions:
            "Preheat grill on high. Drizzle half of the 1 tbs oil over a baking tray. Place the tray under the grill to heat. While the oil on the tray is heating, place the chicken in a large bowl. Add the spice mix. Use your hands to toss until chicken is coated. Once the oil is hot, arrange the chicken mixture in a single layer on the tray. Drizzle over the remaining 1/2 tbs oil. Return the tray to the grill and cook for 3 minutes. Meanwhile, wrap the tortillas in foil and place under the grill with the chicken. Chop the shallots. Add the peppers to the tray with the chicken and toss to combine. Return to the grill for 2 minutes or until the chicken is cooked through. Serve the chicken grill bake with the warmed tortillas, avocado dip and crème fraîche, sprinkled with the shallot and coriander.",
        name: "10-minute chicken fajita tray bake",
        servings: "4",
        image: 'lib/assets/images/image3.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "What would you like to cook today?",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "hellixB",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: HexColor(backgroundColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 34,
                    ),
                    hintText: "Search for recipes",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              MasonryView(
                listOfItem: recipeList,
                numberOfColumn: 2,
                itemBuilder: (item) {
                  Recipe recipe = item as Recipe;
                  String imageName = recipe.image;
                  return InkWell(
                    onTap: () {
                      Get.to(() => const RecipeViewer(),
                          transition: Transition.rightToLeft,
                          arguments: {"recipe": recipe});
                    },
                    child: Image.asset(imageName),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
