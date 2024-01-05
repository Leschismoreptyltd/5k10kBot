/*
CommonBase.mqh 
Copyright 2024, MetaQuotes Ltd. 
https://www.mql5.com 
*/

class CCommonBase {

private:

protected: //Members variables

   int mDigits;
   string mSymbol;
   ENUM_TIMEFRAMES mTimeFrame;
   
   //Used during initialisation of the classes to 
   //determine if the initialisation has been successful of not
   string mInitMessage;
   int mInitResult;
   
protected: //Constructors  

   CCommonBase(){
   
   Init(_Symbol, (ENUM_TIMEFRAMES)_Period);
   
   } 
   
   CCommonBase(string symbol){
   
   Init(symbol, (ENUM_TIMEFRAMES)_Period);
   
   }
   
   CCommonBase(int timeframe){
   
   Init(_Symbol, (ENUM_TIMEFRAMES)timeframe);
   
   }
   
   CCommonBase(ENUM_TIMEFRAMES timeframe){
   
   Init(_Symbol, timeframe);
   
   }
   
   CCommonBase(string symbol, int timeframe){
   
   Init (symbol, (ENUM_TIMEFRAMES)timeframe);
   
   }
   
   CCommonBase(string symbol, ENUM_TIMEFRAMES timeframe){
   
   Init(symbol, timeframe);
   
   }
   
   //Destructor
   
   ~CCommonBase() {};
   
   int Init(string symbol, ENUM_TIMEFRAMES timeframe);
   
protected: // Function

   int InitError(string initMessage, int initResult){
   
   mInitMessage = initMessage;
   mInitResult = initResult;
   return(initResult);
   
   }
   
public: // Properties

   int InitResult(){
   return (mInitMessage);
   }
   
   string InitMessage(){
   return (mInitMessage);
   }
   
public: // Functions

   bool TradeAllowed(){
   
   return(SymbolInfoInteger(mSymbol, SYMBOL_TRADE_MODE) !=SYMBOL_TRADE_MODE_DISABLED);
   
   }

};

int CCommonBase::Init(string symbol, ENUM_TIMEFRAMES timeframe){
   InitError("", INIT_SUCCEEDED);
   
   mSymbol = symbol;
   mTimeFrame = timeframe;
   mDigits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
   return(INIT_SUCCEEDED);
}
