   -- _procFullName_
   -- _procDescLine1_
   -- _procDescLine2_
   -- Parameter:
   --  AlertLogId - Alert/Log OSVVM ID
   --  AlertType  - OSVVM Alert Severity
   --  _param1_   - _param1Desc_
   --  _param2_   - _param2Desc_
   --  _param3_   - _param2Desc_
   --  _xcvr_     - _xcvrDesc_
   procedure _procName_ (
      constant AlertLogId : in    AlertLogIDType := 1;
      constant AlertType  : in    AlertType      := ERROR;
      constant _param1_   : in    _param1Type_   := _param1Dflt_;
      constant _param2_   : in    _param2Type_   := _param2Dflt_;
      variable _param3_   : out   _param3Type_;
      constant _xcvr_     : inout _xcvrType_
      ) is
      variable _var1Name_ : _var1Type_ := _var1Dflt_; -- _var1Desc_
   begin

   end procedure _procName_;
