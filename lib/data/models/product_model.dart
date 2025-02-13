class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final List<String> tags;
  final String brand;
  final List<Review> reviews;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.tags,
    required this.brand,
    required this.reviews,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      tags: List<String>.from(json['tags']),
      brand: json['brand'] ?? "John Pork",
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'tags': tags,
      'brand': brand,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'thumbnail': thumbnail,
      'images': images,
    };
  }
}

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toString(),
      'reviewerName': reviewerName,
    };
  }
}
