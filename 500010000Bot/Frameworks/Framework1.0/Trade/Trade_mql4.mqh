/*
   Trade_mql4.mqh 
   Copyright 2024, MetaQuotes Ltd. 
   https://www.mql5.com 
*/

#include "../CommonBase.mqh"

enum ENUM_POSITION_TYPE{

   POSITION_TYPE_BUY = ORDER_TYPE_BUY,
   POSITION_TYPE_SELL = ORDER_TYPE_SELL
};

class CTradeCustom : public CCommonBase{

private:

protected: //Member Variable

   int mMagic; //Expert magic number

public:  //Constructors
   CTradeCustom();
   ~CTradeCustom();

public: // Functions

   ulong RequestMagic(){
      
      return(mMagic);
   }
   
   void SetExpertMagicNumber(const int magic){
   
      mMagic = magic;
   }
   
   double BuyPrice(string symbol){
   
      return(SymbolInfoDouble(symbol, SYMBOL_ASK));
   }
   
   double SellPrice(string symbol){
   
      return(SymbolInfoDouble(symbol, SYMBOL_BID));
   }
   
   bool Buy(const double volume, const string symbol = NULL, double price = 0.0, const double sl = 0.0, const double tp = 0.0, const string comment = "");
   bool Sell(const double volume, const string symbol = NULL, double price = 0.0, const double sl = 0.0, const double tp = 0.0, const string comment = "");
      
   bool PositionCloseByType(const string symbol, ENUM_POSITION_TYPE positionType, const int deviation = ULONG_MAX);

};

CTradeCustom::CTradeCustom(){
   mMagic = 0;
}

CTradeCustom::~CTradeCustom(){

}

bool CTradeCustom::Buy(const double volume,const string symbol=NULL,double price=0.000000,const double sl=0.000000,const double tp=0.000000,const string comment=NULL){
   
   if(price == 0.0){
      price = BuyPrice(symbol);
   }
   int ticket = OrderSend(symbol, ORDER_TYPE_BUY, volume, price, 0, sl, tp, comment, mMagic);
   
   return(ticket > 0);

}

bool CTradeCustom::Sell(const double volume,const string symbol=NULL,double price=0.000000,const double sl=0.000000,const double tp=0.000000,const string comment=NULL){
   
   if(price == 0.0){
      price = SellPrice(symbol);
   }
   int ticket = OrderSend(symbol, ORDER_TYPE_SELL, volume, price, 0, sl, tp, comment, mMagic);
   
   return(ticket > 0);

}

bool CTradeCustom::PositionCloseByType(const string symbol,ENUM_POSITION_TYPE positionType,const int deviation){

   int slippage = (deviation == ULONG_MAX) ? 0:deviation;
   
   bool result = true;
   int count = OrdersTotal();
   for (int i = count - 1; i <= 0; i--){
   
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)){
         
         if(OrderSymbol() = symbol, && OrderMagicNumber() == mMagic && OrderType()){
            resul &= OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), slippage);
         }
      }
   }
   
   return(result);
}