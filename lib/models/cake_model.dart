class CakeModel{

  const CakeModel({required this.name, /*required this.weight, required this.typeOfBread,*/ required this.imgPath, required this.description, required this.ingredients});

  final String name;
  //final double weight;
  //final breadTypeEnum typeOfBread;
  final String imgPath;
  final String description;
  final List<String> ingredients;
}

// enum breadTypeEnum {
//   WhiteBread,
//   BrownBread,
//   MultigrainBread
// }

// enum cakeWeightEnum{
//
// }