import '../models/food_item.dart';

class FoodData {
  static List<FoodItem> getFoodItems() {
    return [
      // Burgers
      FoodItem(
        id: '1',
        name: 'برجر كلاسيك',
        description: 'برجر لحم بقري مع الخس والطماطم والبصل وصوص خاص',
        price: 45.0,
        imageUrl: 'assets/images/food/burger_classic.png',
        category: 'برجر',
        ingredients: ['لحم بقري', 'خس', 'طماطم', 'بصل', 'صوص خاص'],
        preparationTime: 15,
      ),
      FoodItem(
        id: '2',
        name: 'برجر دجاج مقرمش',
        description: 'قطعة دجاج مقرمشة مع المايونيز والخس',
        price: 40.0,
        imageUrl: 'assets/images/food/burger_chicken.png',
        category: 'برجر',
        ingredients: ['دجاج مقرمش', 'مايونيز', 'خس', 'طماطم'],
        preparationTime: 12,
      ),
      FoodItem(
        id: '3',
        name: 'برجر تشيز',
        description: 'برجر لحم مع جبنة شيدر ذائبة وصوص الباربكيو',
        price: 50.0,
        imageUrl: 'assets/images/food/burger_cheese.png',
        category: 'برجر',
        ingredients: ['لحم بقري', 'جبنة شيدر', 'صوص باربكيو', 'بصل'],
        preparationTime: 15,
      ),

      // Pizza
      FoodItem(
        id: '4',
        name: 'بيتزا مارجريتا',
        description: 'بيتزا كلاسيكية بالطماطم والجبنة والريحان',
        price: 65.0,
        imageUrl:
            'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400',
        category: 'بيتزا',
        ingredients: ['عجينة بيتزا', 'صوص طماطم', 'جبنة موزاريلا', 'ريحان'],
        preparationTime: 20,
      ),
      FoodItem(
        id: '5',
        name: 'بيتزا بيبروني',
        description: 'بيتزا بالبيبروني والجبنة',
        price: 75.0,
        imageUrl:
            'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400',
        category: 'بيتزا',
        ingredients: ['عجينة بيتزا', 'صوص طماطم', 'جبنة', 'بيبروني'],
        preparationTime: 22,
      ),
      FoodItem(
        id: '6',
        name: 'بيتزا مختلطة',
        description: 'بيتزا بالخضار واللحم والجبنة',
        price: 85.0,
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
        category: 'بيتزا',
        ingredients: ['عجينة بيتزا', 'لحم', 'فلفل', 'زيتون', 'جبنة'],
        preparationTime: 25,
      ),

      // Sandwiches
      FoodItem(
        id: '7',
        name: 'ساندويش شاورما دجاج',
        description: 'شاورما دجاج مع الخضار والصوص',
        price: 25.0,
        imageUrl:
            'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=400',
        category: 'ساندويش',
        ingredients: ['دجاج شاورما', 'خضار', 'صوص ثوم', 'خبز'],
        preparationTime: 10,
      ),
      FoodItem(
        id: '8',
        name: 'ساندويش شاورما لحم',
        description: 'شاورما لحم مع البصل والطماطم',
        price: 30.0,
        imageUrl:
            'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
        category: 'ساندويش',
        ingredients: ['لحم شاورما', 'بصل', 'طماطم', 'صوص', 'خبز'],
        preparationTime: 10,
      ),

      // Drinks
      FoodItem(
        id: '9',
        name: 'كوكا كولا',
        description: 'مشروب غازي منعش',
        price: 8.0,
        imageUrl:
            'https://images.unsplash.com/photo-1629203851122-3726ecdf080e?w=400',
        category: 'مشروبات',
        ingredients: ['كوكا كولا'],
        preparationTime: 1,
      ),
      FoodItem(
        id: '10',
        name: 'عصير برتقال طبيعي',
        description: 'عصير برتقال طازج 100%',
        price: 15.0,
        imageUrl:
            'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
        category: 'مشروبات',
        ingredients: ['برتقال طبيعي'],
        preparationTime: 3,
      ),

      // Desserts
      FoodItem(
        id: '11',
        name: 'كيك الشوكولاتة',
        description: 'قطعة كيك شوكولاتة لذيذة',
        price: 20.0,
        imageUrl:
            'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
        category: 'حلويات',
        ingredients: ['شوكولاتة', 'دقيق', 'سكر', 'بيض'],
        preparationTime: 5,
      ),
      FoodItem(
        id: '12',
        name: 'آيس كريم فانيليا',
        description: 'آيس كريم فانيليا كريمي',
        price: 12.0,
        imageUrl:
            'https://images.unsplash.com/photo-1567206563064-6f60f40a2b57?w=400',
        category: 'حلويات',
        ingredients: ['حليب', 'فانيليا', 'سكر'],
        preparationTime: 2,
      ),
    ];
  }

  static List<String> getCategories() {
    return ['الكل', 'برجر', 'بيتزا', 'ساندويش', 'مشروبات', 'حلويات'];
  }
}
