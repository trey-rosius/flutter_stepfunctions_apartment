class ApartmentModel{
  int id;
  String name;
  int reviews;
  int price;
  String imageAsset;

  ApartmentModel({required this.id, required this.name, required this.reviews, required this.price,required this.imageAsset});
}

List<ApartmentModel> apartmentModelList = [

  ApartmentModel(
    id: 1,
    name: "Wild Estates",
    reviews: 400,
    price: 60,
    imageAsset: 'assets/images/d.jpeg'
  ),
  ApartmentModel(
      id: 2,
      name: "La Grande Maison",
      reviews: 2300,
      price: 120,
      imageAsset: 'assets/images/e.jpeg'
  ),
  ApartmentModel(
      id: 3,
      name: "Sun’s Rays Place",
      reviews: 780,
      price: 50,
      imageAsset: 'assets/images/c.jpeg'
  ),
  ApartmentModel(
      id: 4,
      name: "Peace apartments",
      reviews: 1200,
      price: 40,
      imageAsset: 'assets/images/a.jpeg'
  ),
  ApartmentModel(
      id: 5,
      name: "City Dwellers",
      reviews: 200,
      price: 150,
      imageAsset: 'assets/images/b.jpeg'
  ),
  ApartmentModel(
      id: 1,
      name: "Life on the Green",
      reviews: 900,
      price: 60,
      imageAsset: 'assets/images/d.jpeg'
  ),

];