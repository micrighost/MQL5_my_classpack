//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property description "Example of placing pending orders"
#property script_show_inputs
#include <Trade\trade.mqh>
#include <Trade\PositionInfo.mqh>
CTrade trade;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ClassPack
{
public:
   // 檢查是否有新柱形產生
   // 如果有新柱形，返回 true；否則返回 false。
   bool isnewbar(); 
   
   // 刪除所有掛單
   void delete_all_pending_orders(); 
   
   // 平倉所有持倉
   void close_all_positions();
   
   // 獲取當前時間的字符串表示（包含日期和時間）。
   // 返回格式為 "YYYY.MM.DD HH:MM:SS"。
   string current_time() const;

   // 獲取當前日期的字符串表示。
   // 返回格式為 "YYYY.MM.DD"。
   string current_time_date() const;

   // 獲取當前時間（僅秒）的字符串表示。
   // 返回格式為 "HH:MM:SS"。
   string current_time_seconds() const;

}; // class結束

//+------------------------------------------------------------------+
//|檢查有沒有新bar出現                                               |
//+------------------------------------------------------------------+
bool ClassPack::isnewbar()
{
   static datetime bartime = 0; // 存儲前一柱形的開盤時間
   datetime currbar_time = iTime(_Symbol, _Period, 0); // 獲取當前柱的開盤時間

   // 如果柱形時間改變，則表示有新柱形出現
   if (bartime != currbar_time)
   {
      bartime = currbar_time; // 更新前一柱形時間
      return true; // 有新柱形
   }
   return false; // 沒有新柱形
}


//+------------------------------------------------------------------+
//| 刪除所有掛單                                                     |
//+------------------------------------------------------------------+
void ClassPack::delete_all_pending_orders()
{
    // 刪除所有掛單
    for(int i = OrdersTotal() - 1; i >= 0; i--)
    {
        ulong ticket = OrderGetTicket(i);
        if(OrderSelect(ticket))
        {
            if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT || 
               OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT || 
               OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP || 
               OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP)
            {
                // 刪除掛單
                if(!trade.OrderDelete(ticket))
                {
                    Print("刪除掛單失敗，錯誤代碼: ", GetLastError());
                }
            }
        }
    }
}


//+------------------------------------------------------------------+
//| 平倉所有持倉                                                     |
//+------------------------------------------------------------------+
void ClassPack::close_all_positions()
{
    // 刪除所有持倉
    for(int j = PositionsTotal() - 1; j >= 0; j--)
    {
        ulong positionTicket = PositionGetTicket(j);
        if(PositionSelectByTicket(positionTicket))
        {         
            // 平倉
            if(!trade.PositionClose(positionTicket))
            {
                Print("平倉失敗，錯誤代碼: ", GetLastError());
            }
        }
    }
}

//+------------------------------------------------------------------+
//| 獲取當前時間                                                     |
//+------------------------------------------------------------------+
string ClassPack::current_time() const
{
   datetime dt1[]; // 用於存儲獲取的時間，使用動態數組
   ArrayResize(dt1, 1); // 調整數組大小為 1

   // 嘗試獲取當前時間
   if (CopyTime(_Symbol, PERIOD_CURRENT, 0, 1, dt1) == 1) 
   {
      // 返回格式化的時間字符串（包含日期和時間）
      return TimeToString(dt1[0], TIME_DATE | TIME_SECONDS);
   }
   return ""; // 返回空字符串表示獲取失敗
}

//+------------------------------------------------------------------+
//| 獲取當前日期                                                     |
//+------------------------------------------------------------------+
string ClassPack::current_time_date() const
{
   datetime dt1[]; // 用於存儲獲取的時間，使用動態數組
   ArrayResize(dt1, 1); // 調整數組大小為 1

   // 嘗試獲取當前日期
   if (CopyTime(_Symbol, PERIOD_D1, 0, 1, dt1) == 1) 
   {
      // 返回格式化的日期字符串
      return TimeToString(dt1[0], TIME_DATE);
   }
   return ""; // 返回空字符串表示獲取失敗
}

//+------------------------------------------------------------------+
//| 獲取當前時間（秒）                                               |
//+------------------------------------------------------------------+
string ClassPack::current_time_seconds() const
{
   datetime dt1[]; // 用於存儲獲取的時間，使用動態數組
   ArrayResize(dt1, 1); // 調整數組大小為 1

   // 嘗試獲取當前時間（僅秒）
   if (CopyTime(_Symbol, PERIOD_M1, 0, 1, dt1) == 1) 
   {
      // 返回格式化的時間字符串（僅秒）
      return TimeToString(dt1[0], TIME_SECONDS);
   }
   return ""; // 返回空字符串表示獲取失敗
}

//+------------------------------------------------------------------+
