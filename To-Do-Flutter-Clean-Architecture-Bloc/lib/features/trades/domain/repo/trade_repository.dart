import 'package:dartz/dartz.dart';
import 'package:todo/core/core_export.dart';

import '../entity/trade_item.dart';

abstract class TradeRepository {
  Future<Either<Failure, TradeItemList>> getTradeList();
}
