package Controller
{
   import flash.utils.setTimeout;
   import model.Server;
   import model.LogApplication;
   import zebra.Game;
   import view.SentLogView;
   import zebra.system.net.GameSocketThread;
   
   public class SocketControl
   {
       
      
      private var _servermodel;
      
      private var _str:String;
      
      public var socket:GameSocketThread;
      
      public var logappliction:LogApplication;
      
      public var connectHandler:Function;
      
      public var closeHandler:Function;
      
      public var ioErrorHandler:Function;
      
      public var securityErrorHandler:Function;
      
      public function SocketControl(title:String, model:*)
      {
         this.logappliction = new LogApplication();
         super();
         this._str = title;
         this._servermodel = model;
         Game.Content.removeObject("socketControl");
         Game.Content.addObject("socketControl",this);
         this.ConnectToServer();
      }
      
      //TODO:Connect to the Socket Server
      private function ConnectToServer() : void
      {
         this.socket = new GameSocketThread();
         this.socket.connect(this._servermodel.ip,this._servermodel.port);
         var _ip:String = this._servermodel.ip;
         var _port:String = this._servermodel.port;
         var _currentdate:Date = new Date();
         var _currentdatestr:String = String(_currentdate.getHours()) + ":" + String(_currentdate.getMinutes()) + ":" + String(_currentdate.getSeconds()) + "." + String(_currentdate.getMilliseconds());
         SentLogView(Game.Content.getView(SentLogView)).info(_currentdatestr + "," + "建立socket连接" + "," + "socket" + "," + "IP:" + _ip + "port:" + _port);
         this.socket.connectHandler = this._connectHandler;
         this.socket.closeHandler = this._closeHandler;
         this.socket.ioErrorHandler = this._ioErrorHandler;
         this.socket.securityErrorHandler = this._securityErrorHandler;
      }
      
      public function reconnect(param1:Server, param2:int = 1000) : void
      {
         var _servermodel:Server = param1;
         var timer:int = param2;
         setTimeout(function():*
         {
            var _ip:String = null;
            var _port:String = null;
            if(!Main._disconnected)
            {
               _servermodel.switchIP();
               socket.connect(_servermodel.ip,_servermodel.port);
               _ip = _servermodel.ip;
               _port = String(_servermodel.port);
               logappliction.WriteLogWithIpAndPort("投标板块","断线重连",_ip,_port);
            }
         },timer);
      }
      
      private function _securityErrorHandler(param1:GameSocketThread) : void
      {
         if(this.securityErrorHandler != null)
         {
            this.securityErrorHandler();
         }
      }
      
      private function _ioErrorHandler(param1:GameSocketThread) : void
      {
         if(this.ioErrorHandler != null)
         {
            this.ioErrorHandler();
         }
      }
      
      private function _closeHandler(param1:GameSocketThread) : void
      {
         if(this.closeHandler != null)
         {
            this.closeHandler();
         }
      }
      
      private function _connectHandler(param1:GameSocketThread) : void
      {
         if(this.connectHandler != null)
         {
            this.connectHandler();
         }
      }
      
      public function close() : void
      {
         this.socket.close();
      }
   }
}