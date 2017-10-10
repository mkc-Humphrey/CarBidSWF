package Utility
{
   import flash.globalization.DateTimeFormatter;
   import flash.globalization.LocaleID;
   import mx.utils.StringUtil;
   import model.LogApplication;
   import zebra.Game;
   import view.RightContainerView;
   import view.Container;
   import view.LeftContainerView;
   import auctionmodel.BasicTradeInfo;
   import auctionmodel.TradeInfo;
   import auctionmodel.AuctionInfo;
   import auctionmodel.OtherAuctionTypeInfo;
   import auctionmodel.TypeFInfo;
   import auctionmodel.TypeEInfo;
   import auctionmodel.TypeHInfo;
   import auctionmodel.TypeGInfo;
   import auctionmodel.TypeAInfo;
   import auctionmodel.TypeDInfo;
   import auctionmodel.TypeCInfo;
   
   public class DateAndStrUtil
   {
      
      public static var logappliction:LogApplication = new LogApplication();
      
      private static const chinesedateformatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
      
      private static const chineselongdateformatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
      
      private static const shorttimeformatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
      
      private static const hourminuteformatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
      
      private static const fulldateformatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
      
      private static const title:String = "{0}上海市{1}非营业性客车额度投标拍卖会";
      
      public static var currentSN:int = 0;
      
      {
         chinesedateformatter.setDateTimePattern("yyyy年M月d日");
         chineselongdateformatter.setDateTimePattern("yyyy年M月d日H时m分s秒");
         shorttimeformatter.setDateTimePattern("HH:mm:ss");
         hourminuteformatter.setDateTimePattern("HH:mm");
         fulldateformatter.setDateTimePattern("yyyy-MM-dd HH:mm:ss");
      }
      
      private var Ѐ:Main;
      
      public var Ё:String;
      
      public function DateAndStrUtil()
      {
         this.Ѐ = new Main();
         super();
      }
      
      private static function ConverToLastMonthLongDate(param1:String) : Date
      {
         var _loc2_:Array = param1.match(/(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/);
         var _loc3_:Date = new Date(int(_loc2_[1]),int(_loc2_[2]) - 1,int(_loc2_[3]),int(_loc2_[4]),int(_loc2_[5]),int(_loc2_[6]));
         return _loc3_;
      }
      
      private static function ConverToLastMonthDate(param1:String) : Date
      {
         var _loc2_:Array = param1.match(/(\d\d\d\d)(\d\d)(\d\d)/);
         var _loc3_:Date = new Date(int(_loc2_[1]),int(_loc2_[2]) - 1,int(_loc2_[3]));
         return _loc3_;
      }
      
      private static function ConvertToShortDate(param1:String) : Date
      {
         var _loc2_:Array = param1.match(/(\d\d)(\d\d)(\d\d)/);
         var _loc3_:Date = new Date(null,null,null,int(_loc2_[1]),int(_loc2_[2]),int(_loc2_[3]));
         return _loc3_;
      }
      
      private static function ConverToHourMinute(param1:String) : Date
      {
         var _loc2_:Array = param1.match(/(\d\d)(\d\d)/);
         var _loc3_:Date = new Date(null,null,null,int(_loc2_[1]),int(_loc2_[2]));
         return _loc3_;
      }
      
      private static function ConvertToLongDate(param1:Date, param2:Date) : Date
      {
         return new Date(param1.fullYear,param1.month,param1.date,param2.hours,param2.minutes,param2.seconds);
      }
      
      public static function FillAuctionInfoData(data:String) : BasicTradeInfo
      {
         var _loc6_:TypeAInfo = null;
         var _loc7_:String = null;
         var _loc8_:AuctionInfo = null;
         var _loc9_:TypeCInfo = null;
         var _loc10_:TypeDInfo = null;
         var _loc11_:TypeEInfo = null;
         var _loc12_:TypeFInfo = null;
         var _loc13_:TypeGInfo = null;
         var _loc14_:TypeHInfo = null;
         var _loc2_:Array = data.split(",");
         var _loc3_:Date = ConverToLastMonthLongDate(_loc2_[0]);
         var _type:String = _loc2_[1];
         var _auctionType:String = _loc2_[2];
      	//首次出价阶段
         if(_type == "A")
         {
            _loc6_ = new TypeAInfo();
            _loc6_.auctionType = _auctionType;
            _loc6_.auctionDate = ConverToLastMonthDate(_loc2_[3]);
            _loc6_.quota = parseInt(_loc2_[4]);
            _loc6_.warningPrice = parseInt(_loc2_[5]);
            _loc6_.priceLowerLimit = parseInt(_loc2_[6]);
            _loc6_.startTime = ConvertToLongDate(_loc6_.auctionDate,ConverToHourMinute(_loc2_[7]));
            _loc6_.updateTime = ConvertToLongDate(_loc6_.auctionDate,ConverToHourMinute(_loc2_[8]));
            _loc6_.endTime = ConvertToLongDate(_loc6_.auctionDate,ConverToHourMinute(_loc2_[9]));
            _loc6_.systemTime = ConvertToLongDate(_loc6_.auctionDate,ConvertToShortDate(_loc2_[10]));
            _loc6_.numberOfBidUsers = parseInt(_loc2_[11]);
            _loc6_.basePrice = parseInt(_loc2_[12]);
            _loc7_ = _loc2_[13];
            if(_loc7_.length > 0)
            {
               _loc6_.basePriceTime = ConverToLastMonthLongDate(_loc7_);
            }
            _loc6_.tradeSn = parseInt(_loc2_[14]);
            _loc6_.queueLength = parseInt(_loc2_[15]);
            return _loc6_;
         }
         if(_type == "B")
         {
            _loc8_ = new AuctionInfo();
            _loc8_.auctionType = _auctionType;
            _loc8_.auctionDate = ConverToLastMonthDate(_loc2_[3]);
            _loc8_.quota = parseInt(_loc2_[4]);
            _loc8_.numberOfBidUsers = parseInt(_loc2_[5]);
            _loc8_.priceLowerLimit = parseInt(_loc2_[6]);
            _loc8_.startTime = ConvertToLongDate(_loc8_.auctionDate,ConverToHourMinute(_loc2_[7]));
            _loc8_.updateTime = ConvertToLongDate(_loc8_.auctionDate,ConverToHourMinute(_loc2_[8]));
            _loc8_.endTime = ConvertToLongDate(_loc8_.auctionDate,ConverToHourMinute(_loc2_[9]));
            _loc8_.systemTime = ConvertToLongDate(_loc8_.auctionDate,ConvertToShortDate(_loc2_[10]));
            _loc8_.basePrice = parseInt(_loc2_[11]);
            _loc7_ = _loc2_[12];
            if(_loc7_.length > 0)
            {
               _loc8_.basePriceTime = ConverToLastMonthLongDate(_loc7_);
            }
            _loc8_.lowestPrice = parseInt(_loc2_[13]);
            _loc8_.highestPrice = parseInt(_loc2_[14]);
            _loc8_.tradeSn = parseInt(_loc2_[15]);
            _loc8_.queueLength = parseInt(_loc2_[16]);
            return _loc8_;
         }
         //"没有正在举行的拍卖会，请注意拍卖公告！"
         if(_type == "C")
         {
            _loc9_ = new TypeCInfo();
            _loc9_.content = _loc2_[2];
            return _loc9_;
         }
       //"拍卖会已结束！"
         if(_type == "D")
         {
            _loc10_ = new TypeDInfo();
            _loc10_.content = _loc2_[2];
            _loc10_.tradeSn = parseInt(_loc2_[3]);
            _loc10_.queueLength = parseInt(_loc2_[4]);
            return _loc10_;
         }
         ///"拍卖会已终止！"
         if(_type == "E")
         {
            _loc11_ = new TypeEInfo();
            _loc11_.content = _loc2_[2];
            return _loc11_;
         }
       //"没有正在举行的拍卖会，请注意拍卖公告！"
         if(_type == "F")
         {
            _loc12_ = new TypeFInfo();
            _loc12_.auctionType = _auctionType;
            _loc12_.auctionDate = ConverToLastMonthDate(_loc2_[3]);
            _loc12_.startTime = ConvertToLongDate(_loc12_.auctionDate,ConverToHourMinute(_loc2_[4]));
            _loc12_.endTime = ConvertToLongDate(_loc12_.auctionDate,ConverToHourMinute(_loc2_[5]));
            _loc12_.systemTime = ConvertToLongDate(_loc12_.auctionDate,ConvertToShortDate(_loc2_[6]));
            return _loc12_;
         }
       //"拍卖会已结束！"
         if(_type == "G")
         {
            _loc13_ = new TypeGInfo();
            _loc13_.auctionType = _auctionType;
            _loc13_.auctionDate = ConverToLastMonthDate(_loc2_[3]);
            _loc13_.content = _loc2_[4];
            _loc13_.tradeSn = parseInt(_loc2_[5]);
            _loc13_.queueLength = parseInt(_loc2_[6]);
            return _loc13_;
         }
       //"拍卖会已暂停！"
         if(_type == "H")
         {
            _loc14_ = new TypeHInfo();
            _loc14_.content = _loc2_[2];
            return _loc14_;
         }
         return null;
      }
      
      private static function GetAuctionTitle(param1:TradeInfo) : String
      {
         var type:String = null;
         var time:String = chinesedateformatter.format(param1.auctionDate);
         if(param1.auctionType == "0")
         {
            type = "个人";
         }
         else if(param1.auctionType == "1")
         {
            type = "单位";
         }
         else
         {
            type = "未知类型";
         }
         return StringUtil.substitute(title,time,type);
      }
      
      public static function info(param1:BasicTradeInfo) : String
      {
         var message:* = null;
         var _loc3_:TypeAInfo = null;
         var _loc4_:String = null;
         var auctioninfo:AuctionInfo = null;
         var _loc6_:OtherAuctionTypeInfo = null;
         var _loc7_:TypeDInfo = null;
         var _loc8_:TypeFInfo = null;
         var _loc9_:TypeGInfo = null;
      //首次出价阶段
         if(param1.type == "A")
         {
            _loc3_ = TypeAInfo(param1);
            _loc4_ = GetAuctionTitle(_loc3_);
            message = _loc4_ + "\n";
            message = message + ("投放额度数:" + _loc3_.quota + "\n");
            if(_loc3_.auctionType == "1")
            {
               message = message + ("起拍价:" + _loc3_.priceLowerLimit + "\n");
            }
            if(_loc3_.auctionType == "1")
            {
               if(_loc3_.warningPrice == 0)
               {
                  message = message + ("<font color=\'#FF0000\'>本场拍卖会警示价:" + "无警示价" + "</font>\n");
               }
               else
               {
                  message = message + ("<font color=\'#FF0000\'>本场拍卖会警示价:" + _loc3_.warningPrice + "</font>\n");
               }
            }
            else
            {
               message = message + ("<font color=\'#FF0000\'>本场拍卖会警示价:" + _loc3_.warningPrice + "</font>\n");
            }
            message = message + ("拍卖会起止时间:" + hourminuteformatter.format(_loc3_.startTime) + "至" + hourminuteformatter.format(_loc3_.endTime) + "\n");
            message = message + ("首次出价时段:" + hourminuteformatter.format(_loc3_.startTime) + "至" + hourminuteformatter.format(_loc3_.updateTime) + "\n");
            message = message + ("修改出价时段:" + hourminuteformatter.format(_loc3_.updateTime) + "至" + hourminuteformatter.format(_loc3_.endTime) + "\n" + "\n");
            message = message + ("    目前为首次出价时段" + "\n");
            message = message + ("系统目前时间:<font color=\'#FF0000\'>" + shorttimeformatter.format(_loc3_.systemTime) + "</font>\n");
            message = message + ("目前已投标人数:<font color=\'#FF0000\'>" + _loc3_.numberOfBidUsers + "</font>\n");
            message = message + ("目前最低可成交价:<font color=\'#FF0000\'>" + _loc3_.basePrice + "</font>\n");
            message = message + ("最低可成交价出价时间:<font color=\'#FF0000\'>" + (_loc3_.basePriceTime != null?fulldateformatter.format(_loc3_.basePriceTime):"") + "</font>\n");
         }
         else if(param1.type == "B")
         {
            auctioninfo = AuctionInfo(param1);
            _loc4_ = GetAuctionTitle(auctioninfo);
            message = "<font color=\'#FF0000\'>";
            message = message + (_loc4_ + "\n");
            message = message + ("投放额度数:" + auctioninfo.quota + "\n");
            if(auctioninfo.auctionType == "1")
            {
               message = message + ("起拍价:" + auctioninfo.priceLowerLimit + "\n");
            }
            message = message + ("目前已投标人数:" + auctioninfo.numberOfBidUsers + "\n");
            message = message + ("拍卖会起止时间:" + hourminuteformatter.format(auctioninfo.startTime) + "至" + hourminuteformatter.format(auctioninfo.endTime) + "\n");
            message = message + ("首次出价时段:" + hourminuteformatter.format(auctioninfo.startTime) + "至" + hourminuteformatter.format(auctioninfo.updateTime) + "\n");
            message = message + ("修改出价时段:" + hourminuteformatter.format(auctioninfo.updateTime) + "至" + hourminuteformatter.format(auctioninfo.endTime) + "\n" + "\n");
            message = message + "</font>";
            message = message + ("    目前为修改出价时段" + "\n");
            message = message + ("系统目前时间:<font color=\'#FF0000\'><b>" + shorttimeformatter.format(auctioninfo.systemTime) + "</b></font>\n");
            message = message + ("目前最低可成交价:<font color=\'#FF0000\'><b>" + auctioninfo.basePrice + "</b></font>\n");
            message = message + ("最低可成交价出价时间:<font color=\'#FF0000\'><b>" + (auctioninfo.basePriceTime != null?fulldateformatter.format(auctioninfo.basePriceTime):"") + "</b></font>\n");
            message = message + ("目前数据库接受处理价格区间:<font color=\'#FF0000\'><b>" + auctioninfo.lowestPrice + "至" + auctioninfo.highestPrice + "</b></font>\n");
         }
         else if(param1.type == "C" || param1.type == "E" || param1.type == "H")
         {
            _loc6_ = OtherAuctionTypeInfo(param1);
            message = _loc6_.content;
         }
         else if(param1.type == "D")
         {
            _loc7_ = TypeDInfo(param1);
            message = _loc7_.content;
         }
         else if(param1.type == "F")
         {
            _loc8_ = TypeFInfo(param1);
            _loc4_ = GetAuctionTitle(_loc8_);
            message = StringUtil.substitute("{0}尚未开始\n起止时间为：\n{1}\n{2}\n\n系统目前时间：{3}",_loc4_,chineselongdateformatter.format(_loc8_.startTime),chineselongdateformatter.format(_loc8_.endTime),shorttimeformatter.format(_loc8_.systemTime));
         }
         else if(param1.type == "G")
         {
            _loc9_ = TypeGInfo(param1);
            _loc4_ = GetAuctionTitle(_loc9_);
            message = _loc4_ + "已经结束，" + _loc9_.content;
         }
         else
         {
            message = "";
         }
         return message;
      }
      
      public static function А(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = param1;
         var _loc4_:Array = new Array();
         _loc4_ = _loc3_.split(",",_loc3_.length);
         var _loc6_:String = _loc4_[1];
         if(_loc6_ == "A" || _loc6_ == "B" || _loc6_ == "C" || _loc6_ == "D" || _loc6_ == "E" || _loc6_ == "G" || _loc6_ == "H")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public static function Б(param1:String) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _currentdate:Date = new Date();
         var _loc3_:Array = new Array();
         _loc3_ = param1.split(":");
         var _hour:Number = _loc3_[0];
         var _minute:Number = _loc3_[1];
         var _second:Number = _loc3_[2];
         var _currentlongdate:Date = new Date(_currentdate.getFullYear(),_currentdate.getMonth(),_currentdate.getDate(),_hour,_minute,_second);
         var _timediff:Number = Math.round((_currentlongdate.getTime() - _currentdate.getTime()) / 1000);
         if(Main.§˜§)
         {
            Main.§˜§ = false;
            Main.timediff = _timediff;
         }
         else
         {
            _loc9_ = Math.abs(_loc8_ - Main.timediff);
            if(_loc9_ >= 20)
            {
               _loc10_ = param1 + "\n" + _loc2_ + "\n" + "timeDifference:" + _loc8_;
               logappliction.WriteLog2("","",_loc10_);
               Main.§˜§ = true;
               LeftContainerView(Game.Content.getView(LeftContainerView)).networklightview.lightstop(1);
               RightContainerView(Game.Content.getView(RightContainerView)).socketControl.close();
               RightContainerView(Game.Content.getView(RightContainerView)).reconnect();
               Container.removechildren();
            }
         }
      }
   }
}