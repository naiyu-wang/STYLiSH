String hostName = "api.appworks-school.tw";
String apiVersion = "1.0";
String apiDomain = "https://$hostName/api/$apiVersion/";

enum ProductType { all, men, women, accessories }

extension ProductTypeExtension on ProductType {
  String getAPIValue() {
    switch (this) {
      case ProductType.men:
        return "${apiDomain}products/men";
      case ProductType.women:
        return "${apiDomain}products/women";
      case ProductType.accessories:
        return "${apiDomain}products/accessories";
      default:
        return "${apiDomain}products/all";
    }
  }
}

String productDetailAPI = "${apiDomain}products/details";
