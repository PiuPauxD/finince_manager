import 'package:finince_manager/data/data.dart';

List<money> geter() {
  money work = money();
  work.name = 'work';
  work.fee = '+650 BYN';
  work.time = 'today';
  work.image = 'work.png';
  work.buy = false;
  money coffee = money();
  coffee.buy = true;
  coffee.fee = '-15 BYN';
  coffee.image = 'coffee.png';
  coffee.name = 'coffee';
  coffee.time = 'today';
  money transfer = money();
  transfer.buy = true;
  transfer.fee = '-100 BYN';
  transfer.image = 'credit.png';
  transfer.name = 'transfer';
  transfer.time = 'jan 30 2022';
  return [work, coffee, transfer, work, coffee, transfer];
}
