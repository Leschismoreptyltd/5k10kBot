//
// EA_Template1.0.mq5 
// Copyright 2024, MetaQuotes Ltd. 
// https://www.mql5.com 
//
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//Trading Inputs

input double inpVolume = 0.01; //Default Order Size
input string inpComment = _FILE_; // Default Trade Comment
input int inpMagicNumber = 20240103;

// Declare an object of type expert

#define CExpert CExpertBase;
CExpert *Expert;

int OnInit()
  {
//Instantiate the expert with child class name
   Expert = new CExpert();
   
//Assign default values to expert
   Expert.SetVolume(inpVolume);
   Expert.SetComment(inpComment);
   Expert.SetMagicNumber(inpMagicNumber);
   
   //Set Up Signals Below
   
   //Set Up Signals Above
   
   //Finish expert and check results
   
   int result = Expert.OnInit();

//---
   return(result);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   delete Expert;
   return;
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//create method inside expert class which calls OnTick function
   Expert.OnTick();
   return;
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//create method inside expert class which calls OnTimer function
   Expert.OnTimer();
   return;
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---create method inside expert class which calls OnTrade function
   Expert.OnTrade();
   return;
   
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---create method inside expert class which calls OnTradeTransaction function
   Expert.OnTradeTransaction(trans,request, result);
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
//---

//---
   return(Expert.OnTester());
  }
//+------------------------------------------------------------------+
//| TesterInit function                                              |
//+------------------------------------------------------------------+
void OnTesterInit()
  {
//create method inside expert class which calls OnTesterInit function
   Expert.OnTesterInit();
   return;
   
  }
//+------------------------------------------------------------------+
//| TesterPass function                                              |
//+------------------------------------------------------------------+
void OnTesterPass()
  {
//---create method inside expert class which calls OnTesterPass function
   Expert.OnTesterPass():
   return;
   
  }
//+------------------------------------------------------------------+
//| TesterDeinit function                                            |
//+------------------------------------------------------------------+
void OnTesterDeinit()
  {
//---create method inside expert class which calls OnTesterDeinit function\

   Expert.OnTesterDeinit();
   return;
   
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---create method inside expert class which calls OnChartEvent function
   Expert.OnChartEvent(id, lparam, dparam, sparam);
   return;
   
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---create method inside expert class which calls OnBookEvent function
   Expert.OnBookEvent();
   return; 
  }
//+------------------------------------------------------------------+
