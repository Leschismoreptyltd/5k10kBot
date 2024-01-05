/*
   Trade_mql5.mqh 
   Copyright 2024, MetaQuotes Ltd. 
   https://www.mql5.com 
*/

#include <Trade/Trade.mqh>
/*One of the drawbacks is that there is no way to close all positions of a specific type. 
The CTrade class includes a position close method, one which accepts a ticket and another which closes a symbol name
Neither of the methods include an argument where only trades of a specific type is included.
Being written from a perspective of hedging implimentation of MQL5*/
class CTradeCustom : public CTrade {
private:

protected:

public:// Constructors

public:

   bool PositionCloseByType(const string symbol, ENUM_POSITION_TYPE positionType, const ulong deviation = ULONG_MAX);

};

bool CTradeCustom::PositionCloseByType(const string symbol, ENUM_POSITION_TYPE positionType, const ulong deviation = ULONG_MAX){

   bool result = true;
   int count = PositionsTotal();
   for (int i = count - 1; i >= 0; i--){
      
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket)){
         
         if(PositionGetString(POSITION_SYMBOL) == symbol && PositionGetInteger(POSITION_TYPE) == positionType){
         
            result   &= PositionClose(ticket, deviation);
            /*The ampersand makes sure that the result is changed to the PositionClose value 
            and remains that way throughout the rest of the loop*/
         }
      }else{
      
         m_result.retcode = TRADE_RETCODE_REJECT;
         result = false;
      }
   }
   
   return(result);
}