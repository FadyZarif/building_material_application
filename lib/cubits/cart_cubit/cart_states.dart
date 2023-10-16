abstract class CartStates{}
class CartInitState extends CartStates{}

class CartChangeItemState extends CartStates{}
class CartChangeItemErrorState extends CartStates{}

class FetchProductsToCartSuccessState extends CartStates{}
class FetchProductsToCartErrorState extends CartStates{}
