/*
   SignalCrossover.mqh |
   Copyright 2024, MetaQuotes Ltd. |
   https://www.mql5.com |
*/

#include "../SignalBase.mqh"

class CSignalCrossover: public CSignalBase{
private:

protected://Member variables

   int mIndex1;
   int mIndex2;

public: //Constructors

   CSignalCrossover(string symbol, ENUM_TIMEFRAMES timeframe, int index1 = 1, int index2 = 2)
                   :CSignalBase(symbol, timeframe){
                   
                     Init(index1, index2);
                   }
                   
   CSignalCrossover(int index1 = 1, int index2 = =2):CSignalBase(){
      
      Init(index1, index2);               
   }
   
   ~CSignalCrossover(){
   
   }
   
   int Init(int index1, int index2);
   
public:

   virtual void UpdateSignal();

};

int CSignalCrossover:Init(int index1, int index2){

   if(InitResult() != INIT_SUCCEEDED){
      
      return(InitResult());
   }
   else{
      mIndex1 = index1;
      mIndex2 = index2;
   }
   
   return(INIT_SUCCEEDED);
}

void CSignalCrossover:UpdateSignal(){

   double fast1 = GetIndicatorData(0, mIndex1);
   double fast2 = GetIndicatorData(0, mIndex2);
   double slow1 = GetIndicatorData(1, mIndex1);
   double slow2 = GetIndicatorData(1, mIndex2);
   
   /*The following conditions will accound for the crossing over:*/
   
   if ((fast1 > slow1) && !(fast2 > slow2)){ //Crossed up
   
      mEntrySignal   = OFX_SIGNAL_BUY;
      mExitSignal    = OFX_SIGNAL_SELL;
      
   }else if((fast1 < slow1) && !(fast2 < slow2)){ //Crossed down
   
      mEntrySignal   = OFX_SIGNAL_SELL;
      mExitSignal    = OFX_SIGNAL_BUY;  
   } else {
      
      mEntrySignal   = OFX_SIGNAL_NONE;
      mExitSignal    = OFX_SIGNAL_NONE;
   }
   
   return;
}

