/*
   IndicatorBase.mqh
   Copyright 2024, MetaQuotes Ltd.
   https://www.mql5.com
*/
#include "../CommonBase.mqh"

class CIndicatorBase : public CCommonBase{

private:

protected: //Member Variable

public://Constructors
   
   CIndicatorBase(): CCommonBase(){
      
      Init();
   }
   CIndicatorBase(string symbol, ENUM_TIMEFRAMES timeframe):CCommonBase(symbol, timeframe){
      
      Init();
   }
   
   ~CIndicatorBase(){
      
   }
   
   int Init();
   
public: //Methods tobe overwritten in the child class

   //contain the bar number for the information to be returned
   virtual double GetData(const int index){
   
      return(GetData(0, index));
   }
   
   virtual double GetData(const int bufferNum, const int index){
   
      return(0);
   }   
   
};

int CIndicatorBase:: Init() {
   if(InitResult() != INIT_SUCCEEDED){
   
      return (InitResult());
   }
   
   return(INIT_SUCCEEDED);

}