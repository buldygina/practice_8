import 'package:dio/dio.dart';
import 'package:practice_8/model/coffee.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Coffee>> getCoffees() async {
    try {
      final response = await _dio.get('http://10.192.222.15:8080/coffees');
      if (response.statusCode == 200) {
        List<Coffee> coffee = (response.data as List)
            .map((coffee) => Coffee.fromJson(coffee))
            .toList();
        return coffee;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
  Future<Coffee> createCoffee(Coffee coffee) async {
    try {
      final response = await _dio.post(
        'http://10.192.222.15:8080/coffee/create',
        data: coffee.toJson(),
      );
      if (response.statusCode == 200) {
        return Coffee.fromJson(response.data);
      } else {
        throw Exception('Failed to create coffee: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating coffee: $e');
    }
  }
}
