/*
   ExpertBase.mqh 
   Copyright 2024, MetaQuotes Ltd.
   https://www.mql5.com
*/

#include "CommonBase.mqh"
#include "Signals/SignalBase.mqh"
#include "Trade/Trade.mqh"

class CExpertBase : public CCommonBase {
// Private - Can only be used only inside this class
private:

// Protected -  Can be seen and used by classes which inherit from this calss
protected:

   int mMagicNumber;
   string mTradeComment;
   
   double mVolume;
   
   datetime mLastBarTime;
   datetime mBarTime;
   
   CSignalBase *mEntrySignal;
   CSignalBase *mExitSignal;
   
   CTradeCustom Trade; /*  Calling the trade without the pointer will create an 
                           instance/object of type CTradeCustome but the destructor
                           will not be necessary as it will use the default constructor 
                           and will auto remove. It lacks flexibility of creating pointer variables, 
                           but it is sufficient in this case.*/
   
   
protected:
   //Virtual so that sub classes can expert base can use directly or impliment their own version and 
   //overide and use own.
   virtual bool LoopMain(bool newBar, bool firstTime);
   
   //Calling init in protected section so that it cannot be called directly by an application but
   //can be called by subclasses
   int Init(int magicNumber, string tradeComment);

public:

   //
   // Constructors
   //
   
   CExpertBase()
   : CCommonBase(){
   
   Init(0,"");
   
   }
   
   CExpertBase(string symbol, int timeframe, int magicNumber, string tradeComment)
   : CCommonBase(symbol, timeframe){
   
      Init(magicNumber, tradeComment);
   
   }
   
   CExpertBase(string symbol, ENUM_TIMEFRAMES timeframe, int magicNumber, string tradeComment)
   :CCommonBase(symbol, timeframe){
   
      Init(magicNumber, tradeComment);
   
   }
   
   CExpertBase(int magicNumber, string tradeComment)
   :CCommonBase(){
   
      Init(magicNumber, tradeComment);
   
   }
   //
   //Destructor
   //
  
   ~CExpertBase();
   
public: //Default properties

//
//Assign the default values to the expert
//

   //Volume has been excluded from the constructor 
   virtual void SetVolume(double volume){
   
      mVolume = volume;
   
   }
   
   virtual void SetTradeComment(string comment){
   
      mTradeComment = comment;
   
   }
   
   virtual void SetMagicNumber(int magicNumber){
   
      mMagicNumber = magicNumber;
      Trade.SetExpertMagicNumber(magicNumber);
   
   }
   
public: // Signal Setup

   virtual void AddEntrySignal(CSignalBase *signal){
   
      mEntrySignal = signal;
      
   }
   
   virtual void AddExitSignal(CSignalBase *signal){
   
      mExitSignal = signal;
      
   }
   
public: //Event handlers

   virtual int OnInit(){
   
      return(InitResult());
   
   }
   
   virtual void OnTick();
   
   virtual void OnTimer(){
   
      return;
   
   }
   
   virtual double OnTester(){
   
      return(0.0);
   
   }
   
   virtual void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam){
   };
   
#ifdef __MQL5__
   
   virtual void OnTrade(){
   
      return;
   
   }
   
   virtual void OnTradeTransaction(const MqlTradeTransaction& trans, 
                                    const MqlTradeRequest& request,
                                    const MqlTradeResult& result){
   
      return;
   
   
   }
   
   virtual void OnTesterInit(){
   
      return;
   
   }
   
   virtual void OnTesterPass(){
   
      return;
   
   }
   
   virtual void OnTesterDeinit(){
   
      return;
   
   }
   
   virtual void OnBookEvent(){
      
      return;
   
   }

#endif 

};

CExpertBase::~CExpertBase(){

}

int CExpertBase::Init(int magicNumber,string tradeComment){
   
   if (mInitResult != INIT_SUCCEEDED){
   //Handles cases where Parent class has failed the initialiasation
   //Uses init result to set an error consdition.
    return(mInitResult);
   }
   
   else{
    
    mTradeComment = tradeComment;
    SetMagicNumber(magicNumber); 
    mLastBarTime = 0;
    return (INIT_SUCCEEDED);   
   }
}

void CExpertBase::OnTick(void){
   //Checking if trade is not allowed. There are some cases where 
   //brokers shut down and do not allow any transactions.
   if(!TradeAllowed()){
      return;
   }
   else{
   
      mBarTime = iTime(mSymbol, mTimeFrame, 0);
      
      bool firstTime = (mLastBarTime == 0);
      bool newBar = (mBarTime != mLastBarTime);
      //Pass the variables above into the loop main function.
      //Loop main is a boolean function and if it returns true, 
      //Setting last bar time to thecurrent bar time.
      
      if (LoopMain(newBar, firstTime)){
         mLastBarTime = mBarTime;
      }
   }
   return;
}

bool CExpertBase::LoopMain(bool newBar,bool firstTime){
   //
   //To start we will only be trading on a new bar
   // and not on the first bar after start.
   //
   
   if(!newBar){
      return (true);
   }
   
   if(firstTime){
      return (true);
   }
   
   if(mEntrySignal != NULL){
   
      mEntrySignal.UpdateSignal();
   
   }
   
   if(mEntrySignal != mExitSignal){
   
      if(mExitSignal !=NULL){
      
         mExitSignal.UpdateSignal();
      }
   
   }
   //
   //Should any trades be closed
   //
   
   if(mExitSignal != NULL){
   
      if(mExitSignal.ExitSignal() == OFX_SIGNAL_BOTH){
      
         Trade.PositionCloseByType(mSymbol, POSITION_TYPE_BUY);
         Trade.PositionCloseByType(mSymbol, POSITION_TYPE_SELL);   
      }
      else if(mExitSignal.ExitSignal() == OFX_SIGNAL_BUY){
      
         Trade.PositionCloseByType(mSymbol, POSITION_TYPE_BUY);
      }
      else if(mExitSignal.ExitSignal() == OFX_SIGNAL_SELL){
      
         Trade.PositionCloseByType(mSymbol, POSITION_TYPE_SELL);
      }
   }
   
   
   //
   // Should any trades be open
   //
   
   if(mEntrySignal != NULL){
      if(mEntrySignal.EntrySignal() == OFX_SIGNAL_BOTH){
      
         Trade.Buy(mVolume, mSymbol);
         Trade.Sell(mVolume, mSymbol);
      }
      else if(mEntrySignal.EntrySignal() == OFX_SIGNAL_BUY){
        
         Trade.Buy(mVolume, mSymbol);  
      }
      else if(mEntrySignal.EntrySignal() == OFX_SIGNAL_SELL){
         
         Trade.Sell(mVolume, mSymbol); 
      }
   }
   
   return(true);
}