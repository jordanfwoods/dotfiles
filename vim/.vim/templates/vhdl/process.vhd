p_register : process(clock)
begin
   if rising_edge(clock) then
      q <= d;
   end if;
end process;
