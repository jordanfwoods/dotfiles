   -- _funcFullName_
   -- _funcDescLine1_
   -- _funcDescLine2_
   -- Parameter:
   --  _param1_ - _param1Desc_
   --  _param2_ - _param2Desc_
   -- Returns:
   --  _ReturnDesc_
   function _funcName_ (
      constant _param1_ : in _param1Type_ := _param1Dflt_,
      constant _param2_ : in _param2Type_ := _param2Dflt_
      )
      return _returnType_ is
      variable _var1Name_ : _var1Type_ := _var1Dflt_; -- _var1Desc_
      variable return_v : _returnType_ := _returnDflt_;
   begin
      return return_v;
   end function _funcName_;
