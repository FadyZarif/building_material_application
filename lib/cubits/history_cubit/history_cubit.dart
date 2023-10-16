import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/history_model.dart';
import '../../models/wishlist_model.dart';
import '../wishlist_cubit/wishlist_states.dart';
import 'history_states.dart';



class HistoryCubit extends Cubit<HistoryStates>{
  HistoryCubit(): super(HistoryInitState());
  static HistoryCubit get(context) => BlocProvider.of(context);
  Map<String,HistoryModel> historyItems ={};
  void addProductsToHistory({
    required String productId,
  }) {
      historyItems.putIfAbsent(
          productId,
          () => HistoryModel(
                id: DateTime.now().toString(),
                productId: productId,
              ));
    emit(HistoryChangeItemState());
  }

  void clearHistory(){
    historyItems = {};
    emit(HistoryChangeItemState());
  }



// void deleteProductsFromWishlist({required String id,}){
//   WishlistItems.remove(id);
//   emit(WishlistChangeItemState());
//
// }

}