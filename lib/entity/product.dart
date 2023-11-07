class Product {
  // 商品id
  final int id;
  // 商品名
  final String name;
  // 商品价格
  final double price;
  // 商品图片地址
  final String imageUrl;
  // 商品描述
  final String description;
  // 商品分类
  final int categoryId;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      this.description = '',
      this.categoryId = 0});
}
