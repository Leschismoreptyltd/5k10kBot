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
   ENUM_TIMEFRAMES mTimeframe;
   
   //Used during initialisation of the classes to 
   //determine if the initialisation has been successful of not
   string mInitMessage;
   int mInitResult;
   
protected: //Constructors  

   CCommonBase(){
   Init(Symbol(), (ENUM_TIMEFRAMES)_Period);
   } 
   
   CCommonBase(string symbol){
   
   }
}
